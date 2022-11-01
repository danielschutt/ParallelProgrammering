//Naive implementation of Barrier class
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2022

//Hans Henrik Lovengreen     Oct 25, 2022

class NaiveBarrier extends Barrier {
    
    int arrived = 0;
    boolean active = false;
    int threshold = 10;
   
    public NaiveBarrier(CarDisplayI cd) {
        super(cd);
    }

    @Override
    public synchronized void sync(int no) throws InterruptedException {

        if (!active) return;
        
        arrived++;
            
        if (arrived < 9) { 
            if(arrived != threshold){
                wait();
            }else{
                Thread.sleep(500);
                notify();
                wait();
            }
        } else {
            arrived = 0;
            notifyAll();
        }        
    }

    @Override
    public synchronized void on() {
        active = true;
    }

    @Override
    public synchronized void off() {
        active = false;
        arrived = 0;
        
        notifyAll();        
    }


    @Override
    // May be (ab)used for robustness testing
    public synchronized void set(int k) {
        threshold = k; 
    }    


}
