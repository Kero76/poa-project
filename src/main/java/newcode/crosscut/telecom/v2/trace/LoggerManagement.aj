package newcode.crosscut.telecom.v2.trace;

import java.util.logging.Logger;

public aspect LoggerManagement {
	
	public final static Logger newcode.domain.telecom.v2.simulate.Simulation.logger
		= Logger.getLogger(newcode.domain.telecom.v2.simulate.Simulation.class.getName());
	
	{
		Logger.getLogger(newcode.domain.telecom.v2.simulate.Simulation.class.getName()).setParent(null);
	}
}
