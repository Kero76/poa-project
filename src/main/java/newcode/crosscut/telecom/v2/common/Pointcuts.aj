package newcode.crosscut.telecom.v2.common;

import newcode.domain.telecom.v2.connect.*;

import org.aspectj.lang.JoinPoint;

import newcode.crosscut.telecom.v2.unicity.UniqueId;

public aspect Pointcuts {
	
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
		set(@UniqueId private !final String+ newcode..*.name)
		|| set(@UniqueId private final !String+ newcode..*.name)
	;
		
	/**
	 * Pointcut catch the constructor of a Customer.
	 * 
	 * @param name
	 * 	Name of the future customer.
	 * @param ac
	 * 	Code area of the future customer.
	 * @see newcode.domain.telecom.v2.connect.Customer
	 * @see newcode.crosscut.telecom.v2.unicity.EnforceUniticy
	 */
	public pointcut constructorCustomerCall(String name, int ac) :
		call(newcode.domain.telecom.v2.connect.Customer.new(String, int)) 
		&& args(name, ac)
	;
	
	
	// TRACE
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICustomer
	 */
	public pointcut customerCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.*(..))
		&& target(o);
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
	 */
	public pointcut customerHangupCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.hangUp(..))
		&& target(o)
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
	 */
	public pointcut customerPickupCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.pickUp(..))
		&& target(o)
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.crosscut.telecom.v2.common.Config.customerCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.customerHangupCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.customerPickupCallTrace(jp)
	 */
	public pointcut customerFinalCallTrace(Object o) :
		customerCallTrace(o)
		|| customerHangupCallTrace(o)
		|| customerPickupCallTrace(o)
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICall+.invite()
	 */
	public pointcut callInviteCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICall+.invite(..))
		&& target(o)
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICall+.hangUp()
	 */
	public pointcut callHangupCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICall+.hangUp(..))
		&& target(o)
	;

	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.domain.telecom.v2.connect.ICall+.pickUp()
	 */
	public pointcut callPickupCallTrace(Object o) :
		call(* newcode.domain.telecom.v2.connect.ICall+.pickUp(..))
		&& target(o)
	;
	
	/**
	 * 
	 * @param o
	 * 	Object who call methods catch by pointcut.
	 * @see newcode.crosscut.telecom.v2.common.Config.callHangupCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.callPickupCallTrace(jp)
	 */
	public pointcut callFinalCallTrace(Object o) :
		callHangupCallTrace(o)
		|| callPickupCallTrace(o)
	;
}
