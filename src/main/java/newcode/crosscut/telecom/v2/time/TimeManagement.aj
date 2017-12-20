package newcode.crosscut.telecom.v2.time;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.crosscut.telecom.v2.time.Timer;

public privileged aspect TimeManagement {
	
	/**
	 * Add an attribute timer on Connection.
	 */
	private Timer newcode.domain.telecom.v2.connect.Connection.timer;

	/**
	 * Instantiate timer for the connection object.
	 */
	private void newcode.domain.telecom.v2.connect.Connection.createTimer() {
		timer = new Timer();
	}

	/**
	 * Start timer when connection is complete.
	 */
	private void newcode.domain.telecom.v2.connect.Connection.startTimer() {
		timer.start();
	}

	/**
	 * Stop timer when connection is drop. 
	 */
	private void newcode.domain.telecom.v2.connect.Connection.stopTimer() {
		timer.stop();
	}
	
	/**
	 * Get the timer.
	 * 
	 * @return
	 * 	The timer.
	 */
	public Timer newcode.domain.telecom.v2.connect.Connection.getTimer() {
		return timer;
	}
	
	
	/*
	 * ADVICES 
	 */
	after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.constructorInstantiationConnection(c) {
		c.createTimer();
	}

	before(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.completeConnectionCall() && target(c) {
		c.startTimer();
	}
	
	after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.dropConnectionCall() && target(c) {
		c.stopTimer();
		System.out.println(c.getTimer().getTime());
		System.out.println();
	}
}
