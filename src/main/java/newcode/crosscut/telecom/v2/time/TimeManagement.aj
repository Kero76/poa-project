package newcode.crosscut.telecom.v2.time;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.crosscut.telecom.v2.time.Timer;
import newcode.domain.telecom.v2.connect.Customer;

public privileged aspect TimeManagement {
  
  /**
   * Add an attribute timer on Connection.
   */
  private Timer newcode.domain.telecom.v2.connect.Connection.timer;

  /**
   * Instantiate timer for the connection object.
   */
  private void newcode.domain.telecom.v2.connect.Connection.createTimer() {
    timer = new Timer();
  }

  /**
   * Start timer when connection is complete.
   */
  private void newcode.domain.telecom.v2.connect.Connection.startTimer() {
    timer.start();
  }

  /**
   * Stop timer when connection is drop. 
   */
  private void newcode.domain.telecom.v2.connect.Connection.stopTimer() {
    timer.stop();
  }
  
  /**
   * Get the timer.
   * 
   * @return
   *  The timer.
   */
  public Timer newcode.domain.telecom.v2.connect.Connection.getTimer() {
    return timer;
  } 
  
  /**
   * Add an attribute callDuration and callTotalDuration on Customer object.
   */
  private int newcode.domain.telecom.v2.connect.Customer.callDuration; 
  private int newcode.domain.telecom.v2.connect.Customer.callTotalDuration; 
  
  /**
   * Instantiate timer for the connection object.
   */
  private void newcode.domain.telecom.v2.connect.Customer.createCallDuration() {
    callDuration = 0;
  }

  /**
   * Get the call duration.
   * 
   * @return
   *  The current duration after the customer hang up.
   */
  public int newcode.domain.telecom.v2.connect.Customer.getCallDuration() {
    return callDuration;
  } 

  /**
   * Get the total call duration.
   * 
   * @return
   *  The total duration after the customer hang up.
   */
  public int newcode.domain.telecom.v2.connect.Customer.getCallTotalDuration() {
    return callTotalDuration;
  } 
  
  /**
   * Add new duration on current duration.
   * 
   * @param duration
   *  New duration of call.
   */
  public void newcode.domain.telecom.v2.connect.Customer.addDuration(int duration) {
    callDuration = duration;
  }
  
  /**
   * Add new duration on current duration.
   * 
   * @param duration
   *  New duration of call.
   */
  public void newcode.domain.telecom.v2.connect.Customer.addTotalDuration(int duration) {
    callTotalDuration += duration;
  }
  
  /*
   * ADVICES 
   */
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.constructorInstantiationConnection() && this(c) {
    c.createTimer();
  }
  
  after(newcode.domain.telecom.v2.connect.Customer c) : Pointcuts.constructorInstantiationCustomer() && this(c) {
    c.createCallDuration();
  }

  before(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.completeConnectionCall() && target(c) {
    c.startTimer();
  }
  
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.dropConnectionCall() && target(c) {
    c.stopTimer();
    Customer caller = (Customer) c.getCaller();
    Customer callee = (Customer) c.getCallee();
    int duration = c.getTimer().getTime();
    caller.addDuration(duration);
    caller.addTotalDuration(duration);
    callee.addDuration(duration);
    callee.addTotalDuration(duration);
  }
}
