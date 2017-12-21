package newcode.crosscut.telecom.v2.common;

import newcode.domain.telecom.v2.connect.*;

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
	 * 	Object who call methods catch by pointcut.
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
		callHangupCallTrace()
		|| callPickupCallTrace()
	;
}
