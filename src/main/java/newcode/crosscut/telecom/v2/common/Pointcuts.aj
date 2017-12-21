package newcode.crosscut.telecom.v2.common;

import newcode.domain.telecom.v2.connect.*;
import newcode.crosscut.telecom.v2.unicity.UniqueId;

public privileged aspect Pointcuts {
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
  
  /**
   * Pointcut to catch when a user hang up his phone.
   */
  public pointcut hangUpCustomerCall() : 
    call(void newcode.domain.telecom.v2.connect.ICustomer.hangUp(..))
  ;

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
    call(newcode.domain.telecom.v2.connect.Customer.new(String, int)) &&
    args(name, ac)
  ;
}
