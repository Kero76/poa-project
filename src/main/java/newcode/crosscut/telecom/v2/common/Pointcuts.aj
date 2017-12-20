package newcode.crosscut.telecom.v2.common;

public privileged aspect Pointcuts {
	
	/**
	 * Pointcut who catch the execution of constructor for the Connection object.
	 * 
	 * @param c
	 * 	The instantiate Connection.
	 */
	public pointcut constructorInstantiationConnection(newcode.domain.telecom.v2.connect.Connection c) :
		execution(newcode.domain.telecom.v2.connect.Connection.new(..))
		&& this(c)
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
	
	/**
	 * Pointcut who catch the execution of constructor for the Connection object.
	 * 
	 * @param c
	 * 	The instantiate Connection.
	 */
//	public pointcut constructorInstantiationConnection(newcode.domain.telecom.v2.connect.Connection c) :
//		execution(newcode.domain.telecom.v2.connect.Connection.new(..))
//		&& this(c)
//	;
	
	/**
	 * Pointcut to catch when a user pick up his phone.
	 * 
	 * @see newcode.crosscut.telecom.v2.time.TimeManagement
	 */
	public pointcut pickUpCustomerCall() : 
		call(void newcode.domain.telecom.v2.connect.ICustomer.pickUp(..))
	;
	
	/**
	 * Pointcut to catch when a user hangh up his phone.
	 * 
	 * @see newcode.crosscut.telecom.v2.time.TimeManagement
	 */
	public pointcut hangUpCustomerCall() : 
		call(void newcode.domain.telecom.v2.connect.ICustomer.hangUp(..))
	;
}
