package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;

import newcode.domain.telecom.v2.connect.*;

import java.util.*;

public aspect FinalReportTracing {
  private Set<Customer> callers = new HashSet<>();
  
  after(ICall callObj) :
    Pointcuts.executionSimulationRunTest()
    && Pointcuts.callInstantiation()
    && this(callObj) {
    Customer caller = (Customer) callObj.getCaller();
    if (!callers.contains(caller)) {
      callers.add(caller);
    }
  }
  
  after() :
    Pointcuts.executionSimulationRunTest() {
    for (Customer caller : callers) {
      ICall callObj = caller.getCall();
      if (callObj.noCalleePending()) {
        System.out.println(
          FeatureMessages.billCompleteTracing(
            caller.getName(), caller.getAreaCode(), caller.getCallDuration(), caller.getCallPrice()
          )
        );
      } else {
        for (ICustomer receiver : callObj.getReceivers()) {
          if (callObj.includes(receiver) && !callObj.isConnectedWith(receiver)) {
            System.out.println(
              FeatureMessages.billPendingTracing(
                receiver.getName(), receiver.getAreaCode(), caller.getName(), ((Customer) caller).getCallPrice()
              )
            );
          }
        }
      }
    }
    callers.clear();
  }
}
