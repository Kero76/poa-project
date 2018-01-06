package newcode.crosscut.telecom.v2.trace.format;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect IndenterManagement {

	pointcut stackTraceIndent() :
		Pointcuts.customerFinalCallTrace()
		|| Pointcuts.callFinalCallTrace()
	;
	
	/*after() : stackTraceIndent() {
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
	
	pointcut stackTraceLineReturn() :
		Pointcuts.customerCallTrace()
		|| Pointcuts.customerPickupCallTrace()
	;
	
	after() : stackTraceLineReturn() {
		System.out.print(System.getProperty("line.separator"));
	}*/
}
