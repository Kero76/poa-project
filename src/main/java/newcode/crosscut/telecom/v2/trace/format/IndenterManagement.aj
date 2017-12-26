package newcode.crosscut.telecom.v2.trace.format;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect IndenterManagement {

	/**
	 * Formatter.
	 */
	private AbstractFormatter formatter = new SpaceFormatter();

	pointcut stackTraceIndent() :
		Pointcuts.customerCallTrace() 		||
		Pointcuts.customerHangupCallTrace() ||
		Pointcuts.customerPickupCallTrace() ||
		Pointcuts.customerFinalCallTrace() 	||
		Pointcuts.callInviteCallTrace() 	||
		Pointcuts.callHangupCallTrace() 	||
		Pointcuts.callPickupCallTrace()	 	||
		Pointcuts.callFinalCallTrace() 		|| 
		Pointcuts.hangUpCustomerCall()		||
		Pointcuts.dropConnectionCall()
	;
	
	after() : stackTraceIndent() {
		Counter.getInstance().decrement();
		System.out.print(
			formatter.format(Counter.getInstance().getCounter())
		);
	}
	
	before() : stackTraceIndent() {
		System.out.print( 
			formatter.format(Counter.getInstance().getCounter())
		);
		Counter.getInstance().increment();
	}
}
