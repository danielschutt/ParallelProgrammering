//Skeleton implementation of an Alley class  using passing-the-baton
//Mandatory assignment 2
//Course 02158 Concurrent Programming, DTU, Fall 2022

//Hans Henrik Lovengreen     Sep 26, 2022

public class BatonAlley extends Alley {

    int up = 0;
    int down = 0;

    int delayedUp = 0;
    int delayedDown = 0;

    Semaphore enterSem = new Semaphore(1);
    Semaphore downSem = new Semaphore(0);
    Semaphore upSem = new Semaphore(0);

    protected BatonAlley() {
        
    }

    /* Block until car no. may enter alley */
    public void enter(int no) throws InterruptedException {

        enterSem.P();
        if (no < 5) {            
            if (up > 0) {
                delayedDown++;
                enterSem.V();
                downSem.P();
                delayedDown--;
            }

            down++;

            if (delayedDown > 0){
                downSem.V();
            }
            else {
                enterSem.V();
            }
        } 
        else {
            if (down > 0){
                delayedUp++;
                enterSem.V();;
                upSem.P();
                delayedUp--;
            }

            up++;

            if (delayedUp > 0){
                upSem.V();
            }
            else {
                enterSem.V();
            }
        }
     }

    /* Register that car no. has left the alley */
    public void leave(int no){

        try {
            enterSem.P();
            if (no < 5) {
                
                down--;
                if (down == 0 && delayedUp > 0) {
                    upSem.V();
                }
                else {
                    enterSem.V();
                }
            } else {

                up--;
                if (up == 0 && delayedDown > 0) {
                    downSem.V();
                }
                else {
                    enterSem.V();
                }
            }
        } catch (Exception e) {
            
        }
    }
}
