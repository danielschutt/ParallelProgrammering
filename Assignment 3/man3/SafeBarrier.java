import java.util.ArrayList;

//Implementation of a basic Barrier class (skeleton)
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2022

//Hans Henrik Lovengreen     Oct 25, 2022

class SafeBarrier extends Barrier {
    
    int arrived = 0;
    boolean active = false;
    ArrayList<Boolean> carContinue;
    int threshold = 10;

    public SafeBarrier(CarDisplayI cd) {
        super(cd);
        carContinue = new ArrayList<Boolean>(9);
        for (int i = 0; i < 9; i++){
            carContinue.add(false);
        }
    }

    @Override
    public synchronized void sync(int no) throws InterruptedException {

        if (!active) return;
        
        arrived++;        

        if (arrived == 9){
            for (int i = 0; i < 9; i++){
                carContinue.set(i, true);
            }
            arrived = 0;
            notifyAll();
        }
        else {
            if(arrived != threshold){
                while(!carContinue.get(no)){
                    wait();
                }                
            }else{
                Thread.sleep(500);
                notify();
                while (!carContinue.get(no)){
                    wait();
                }
            }            
        }
        
        carContinue.set(no, false);

    }

    @Override
    public synchronized void on() {
        active = true;

        for (int i = 0; i < 9; i++){
            carContinue.set(i, false);
        }
    }

    @Override
    public synchronized void off() {
        active = false;
        arrived = 0;
        for (int i = 0; i < 9; i++){
            carContinue.set(i, true);
        }
        notifyAll();        
    }


    @Override
    // May be (ab)used for robustness testing
    public synchronized void set(int k) {
        threshold = k; 
    }    

    
}
