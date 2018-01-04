package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;

import newcode.domain.telecom.v2.connect.*;

import java.util.*;

public aspect FinalReportTracing {
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
    for (Customer callee : callees) {
      System.out.println(
        FeatureMessages.billCompleteTracing(
          callee.getName(), callee.getAreaCode(), callee.getCallTotalDuration(), callee.getCallPrice()
        )
      );
    }
    for (Customer caller : callers) {
      ICall callObj = caller.getCall();
      // Ici, l'interlocuteur est en attente d'un appel, dans le tracing affiche un etat de pending ... 
      if (callObj != null && !callObj.noCalleePending()) {
        System.out.println(
          FeatureMessages.billPendingTracing(
            caller.getName(), caller.getAreaCode(), "", caller.getCallPrice() // Manque le troisième élément, a savoir le nom de l'appelé.
          )
        );
      } 
      // ... sinon l'ensemble des appels est terminés, et le tracing affiche le message de billing complet.
      else {
        System.out.println(
          FeatureMessages.billCompleteTracing(
            caller.getName(), caller.getAreaCode(), caller.getCallTotalDuration(), caller.getCallPrice()
          )
        );
      }
//      if (callObj.noCalleePending()) {
//        System.out.println(
//          FeatureMessages.billCompleteTracing(
//            caller.getName(), caller.getAreaCode(), caller.getCallDuration(), caller.getCallPrice()
//          )
//        );
//      } else {
//        for (ICustomer receiver : callObj.getReceivers()) {
//          if (callObj.includes(receiver) && !callObj.isConnectedWith(receiver)) {
//            System.out.println(
//              FeatureMessages.billPendingTracing(
//                receiver.getName(), receiver.getAreaCode(), caller.getName(), ((Customer) caller).getCallPrice()
//              )
//            );
//          }
//        }
//      }
    }
    callers.clear();
    callees.clear();
  }
}
