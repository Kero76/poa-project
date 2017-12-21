package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect SimulationMessageManagement {

	before(Object o) : Pointcuts.customerCallTrace() && target(o) {
		
	}

	before(Object o) : Pointcuts.customerHangupCallTrace() && target(o) {
		
	}

	before(Object o) : Pointcuts.customerPickupCallTrace() && target(o) {
		
	}

	after(Object o) : Pointcuts.customerFinalCallTrace() && target(o) {
		
	}

	before(Object o) : Pointcuts.callInviteCallTrace() && target(o) {
		
	}

	before(Object o) : Pointcuts.callHangupCallTrace() && target(o) {
		
	}

	before(Object o) : Pointcuts.callPickupCallTrace() && target(o) {
		
	}

	after(Object o) : Pointcuts.callFinalCallTrace() && target(o) {
		
	}
}
