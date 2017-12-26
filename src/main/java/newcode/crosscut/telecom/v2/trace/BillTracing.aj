package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect BillTracing {

	// Add line separator between each runTest method.
	after() : Pointcuts.executionSimulationRunTest() {
		System.out.println(
			FeatureMessages.separatorLine(
				FeatureMessages.DEFAULT_CHAR_SEPARATOR, 
				FeatureMessages.DEFAULT_REPEAT_SIZE
			)
		);
	}
}
