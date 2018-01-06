package newcode.crosscut.telecom.v2.common;

import newcode.crosscut.telecom.v2.unicity.UniqueId;
import newcode.domain.telecom.v2.connect.Customer;
import newcode.domain.telecom.v2.connect.ICustomer;

public privileged aspect Pointcuts {
  // UNICITY
  /**
   * Check if the annotation @UniqueId is used for
   * annotate the attribute Customer.name
   * 
   * @see newcode.domain.telecom.v2.connect.Customer
   */
  public pointcut checkUnicityPolicy() :
    set(@UniqueId private final String Customer.name)
  ;
  
  /**
   * Throw an error when the developer annotate wrong attribute.
   * 
   * @see newcode.domain.telecom.v2.common.Config
   */
  public pointcut unicityPolicyUnsatisfied() :  
    set(@UniqueId private !final String+ newcode..*.name) || 
    set(@UniqueId private final !String+ newcode..*.name)
  ;
  
  /**
   * Pointcut catch the constructor of a Customer.
   * 
   * @param name
   *  Name of the future customer.
   * @param ac
   *  Code area of the future customer.
   * @see newcode.domain.telecom.v2.connect.Customer
   * @see newcode.crosscut.telecom.v2.unicity.EnforceUniticy
   */
  public pointcut constructorCustomerCall(String name, int ac) :
    call(newcode.domain.telecom.v2.connect.Customer.new(String, int)) 
    && args(name, ac)
  ;
  
  
  // TIME
  /**
   * Pointcut who catch the execution of constructor for the Connection object.
   * 
   * @param c
   *  The instantiate Connection.
   */
  public pointcut constructorInstantiationConnection() :
    execution(newcode.domain.telecom.v2.connect.Connection.new(..))
  ;
  
  
  // TRACE
  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICustomer
   */
  public pointcut customerCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICustomer+.call(..))
  ;
  
  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
   */
  public pointcut customerHangupCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICustomer+.hangUp(..))
  ;
  
  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
   */
  public pointcut customerPickupCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICustomer+.pickUp(..))
  ;
  
  /**
   * 
   * @param o
   *  Object who call methods catch by pointcut.
   * @see newcode.crosscut.telecom.v2.common.Config.customerCallTrace(jp)
   * @see newcode.crosscut.telecom.v2.common.Config.customerHangupCallTrace(jp)
   * @see newcode.crosscut.telecom.v2.common.Config.customerPickupCallTrace(jp)
   */
  public pointcut customerFinalCallTrace() :
    customerCallTrace()
    || customerHangupCallTrace()
    || customerPickupCallTrace()
  ;
  
  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICall+.invite()
   */
  public pointcut callInviteCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICall+.invite(..))
  ;
  
  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICall+.hangUp()
   */
  public pointcut callHangupCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICall+.hangUp(..))
  ;

  /**
   * 
   * @see newcode.domain.telecom.v2.connect.ICall+.pickUp()
   */
  public pointcut callPickupCallTrace() :
    call(* newcode.domain.telecom.v2.connect.ICall+.pickUp(..))
  ;
  
  /**
   * 
   * @see newcode.crosscut.telecom.v2.common.Config.callHangupCallTrace(jp)
   * @see newcode.crosscut.telecom.v2.common.Config.callPickupCallTrace(jp)
   */
  public pointcut callFinalCallTrace() :
    callInviteCallTrace()
    || callHangupCallTrace()
    || callPickupCallTrace()
  ;
  
  /**
   * Pointcut to catch the call of the method complete.
   * 
   * @see newcode.crosscut.telecom.v2.time.TimeManagement
   */
  public pointcut completeConnectionCall() : 
    call(void newcode.domain.telecom.v2.connect.Connection.complete(..))
  ;
  
  /**
   * Pointcut to catch the call of the drop.
   * 
   * @see newcode.crosscut.telecom.v2.time.TimeManagement
   */
  public pointcut dropConnectionCall() :
    call(void newcode.domain.telecom.v2.connect.Connection.drop(..))
  ;
  
  // BILLING
  /**
   * Pointcut which catches the execution of constructor for the Customer object.
   */
  public pointcut constructorInstantiationCustomer() :
    execution(newcode.domain.telecom.v2.connect.Customer.new(..))
  ;
  
  
  // FINAL REPORT  
  /**
   * Catch execution of method runTestX().
   */
  public pointcut executionSimulationRunTest() :
     execution(void newcode.domain.telecom.v2.simulate.Simulation.runTest*())
  ;
  
  public pointcut callInstantiation() :
    execution(* newcode.domain.telecom.v2.connect.Customer.call(ICustomer))
  ;
    
  // CALL STATE TRACING
  
  /**
   * Catches a Call instantiation.
  */
  public pointcut callConstruction() :
    execution(newcode.domain.telecom.v2.connect.ICall+.new(..));
  ;
  
  // LINE RETURN
  public pointcut stackTraceLineReturn() :
    Pointcuts.customerCallTrace()
    || Pointcuts.customerPickupCallTrace()
  ;
}
