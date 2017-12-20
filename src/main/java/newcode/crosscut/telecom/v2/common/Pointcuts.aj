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
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICustomer
	 */
	public pointcut customerCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.*(..))
		&& target(jp);
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
	 */
	public pointcut customerHangupCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.hangUp(..))
		&& target(jp)
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICustomer.hangUp()
	 */
	public pointcut customerPickupCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICustomer+.pickUp(..))
		&& target(jp)
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.crosscut.telecom.v2.common.Config.customerCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.customerHangupCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.customerPickupCallTrace(jp)
	 */
	public pointcut customerFinalCallTrace(JoinPoint jp) :
		customerCallTrace(jp)
		|| customerHangupCallTrace(jp)
		|| customerPickupCallTrace(jp)
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICall+.invite()
	 */
	public pointcut callInviteCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICall+.invite(..))
		&& target(jp)
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICall+.hangUp()
	 */
	public pointcut callHangupCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICall+.hangUp(..))
		&& target(jp)
	;

	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.domain.telecom.v2.connect.ICall+.pickUp()
	 */
	public pointcut callPickupCallTrace(JoinPoint jp) :
		call(* newcode.domain.telecom.v2.connect.ICall+.pickUp(..))
		&& target(jp)
	;
	
	/**
	 * 
	 * @param jp
	 * 	JoinPoint instance to get information on trace.
	 * @see newcode.crosscut.telecom.v2.common.Config.callHangupCallTrace(jp)
	 * @see newcode.crosscut.telecom.v2.common.Config.callPickupCallTrace(jp)
	 */
	public pointcut callFinalCallTrace(JoinPoint jp) :
		callHangupCallTrace(jp)
		|| callPickupCallTrace(jp)
	;
}
