package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.crosscut.telecom.v2.trace.indent.SystemContextIndentation;
import newcode.domain.telecom.v2.connect.*;
import newcode.domain.telecom.v2.simulate.Simulation;

import java.util.*;
import java.util.logging.Level;

public privileged aspect BillTracing {
  private Set<Customer> callers = new HashSet<>();
  private Set<Customer> callees = new HashSet<>();
  
  before(ICustomer customer) : Pointcuts.customerHangupCallTrace() && target(customer) {
	  Customer caller = (Customer) customer.getCall().getCaller();
	  for (ICustomer c : caller.getCall().getReceivers()) {
	    	if (!callees.contains(c)) {
	    		callees.add((Customer) c);
	    	}
	    }
  }
  
  after(ICustomer custObj) : Pointcuts.callInstantiation() && target(custObj) {
    Customer caller = (Customer) custObj.getCall().getCaller();
    if (!callers.contains(caller)) {
      callers.add(caller);
    }
  }
  
  after() : Pointcuts.executionSimulationRunTest() {
	Simulation.logger.info(System.getProperty("line.separator"));
    for (Customer callee : callees) {
      newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
        Level.INFO,
        FeatureMessages.billCompleteTracing(
          callee.getName(), callee.getAreaCode(), callee.getCallTotalDuration(), callee.getCallTotalPrice()
        ),
        SystemContextIndentation.aspectOf().getDepth()
      );
    }
    for (Customer caller : callers) {
      ICall callObj = caller.getCall();
      // Ici, l'interlocuteur est en attente d'un appel, dans le tracing affiche un etat de pending ... 
      if (callObj != null && !callObj.noCalleePending()) {
        for (ICustomer c : ((Call) callObj).pending.keySet()) {
          newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
            Level.INFO,
            FeatureMessages.billPendingTracing(
              caller.getName(), caller.getAreaCode(), c.getName(), caller.getCallTotalPrice() // Manque le troisième élément, a savoir le nom de l'appelé.
            ),
            SystemContextIndentation.aspectOf().getDepth()
          );
        }
      }
      // ... sinon l'ensemble des appels est terminés, et le tracing affiche le message de billing complet.
      else {
        newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
          Level.INFO,
          FeatureMessages.billCompleteTracing(
            caller.getName(), caller.getAreaCode(), caller.getCallTotalDuration(), caller.getCallTotalPrice()
          ),
          SystemContextIndentation.aspectOf().getDepth()
        );
      }
    }
    callers.clear();
    callees.clear();
  }
}
