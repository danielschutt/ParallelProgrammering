//Implementation of Alley class avoiding starvation (skeleton)
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2022

//Hans Henrik Lovengreen     Oct 25, 2022

public class FairAlley extends Alley {
   
    public FairAlley() {
    }

    @Override
    /* Block until car no. may enter alley */
    public void enter(int no) throws InterruptedException {
    }

    @Override
    /* Register that car no. has left the alley */
    public void leave(int no) {
    }
    
}
