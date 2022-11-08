//Monitor implementation of Gate (skeleton)
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2022

//Hans Henrik Lovengreen     Oct 25, 2022


public class MonGate extends Gate {

    boolean isopen = false;
    public synchronized void pass() throws InterruptedException 
    {
        while (!isopen) { wait(); }
    }

    public synchronized void open() 
    {
        isopen = true;
        notify();
    }

    public synchronized void close() 
    {
        isopen = false;
    }
}
