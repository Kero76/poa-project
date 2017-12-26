package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.crosscut.telecom.v2.trace.format.AbstractFormatter;
import newcode.crosscut.telecom.v2.trace.format.Counter;
import newcode.crosscut.telecom.v2.trace.format.SpaceFormatter;
import newcode.domain.telecom.v2.connect.Customer;

public privileged aspect TimeTracing {

	// Add line separator between each runTest method.
	after() : Pointcuts.executionSimulationRunTest() {
		System.out.println(
			FeatureMessages.separatorLine(
				FeatureMessages.DEFAULT_CHAR_SEPARATOR, 
				FeatureMessages.DEFAULT_REPEAT_SIZE
			)
		);
	}
	
	after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.constructorInstantiationConnection() && this(c) {
		System.out.println(
			FeatureMessages.timeConnectionNullToPendingTracing(
				c.toString().substring(c.toString().lastIndexOf('.') + 1)
			)
		);
	}
	
	after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.completeConnectionCall() && target(c) {
		System.out.println(
			FeatureMessages.timeConnectionPendingToCompleteTracing(
				c.toString().substring(c.toString().lastIndexOf('.') + 1)
			)
		);
	}
	
	after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.dropConnectionCall() && target(c) {
		Customer caller = (Customer)c.getCaller();
		Customer callee = (Customer)c.getCallee();
		AbstractFormatter formatter = new SpaceFormatter();
		
		// Replace line by "if (c.type == ConnectionType.LOCAL)" 
		if (caller.getAreaCode() == callee.getAreaCode()) {
			System.out.println(
				FeatureMessages.timeConnectionCompleteToDroppedAndLocalConnexionTracing(
					c.toString().substring(c.toString().lastIndexOf('.') + 1), 
					c.getTimer().getTime(), 
					caller.getCallPrice(), 
					formatter.format(Counter.getInstance().getCounter() - 1)
				)
			);
		} else {
			System.out.println(
				FeatureMessages.timeConnectionCompleteToDroppedAndDistanteConnexionTracing(
					c.toString().substring(c.toString().lastIndexOf('.') + 1), 
					c.getTimer().getTime(), 
					caller.getCallPrice(), 
					formatter.format(Counter.getInstance().getCounter() - 1)
				)
			);
		}
	}
}
