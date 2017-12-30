package newcode.crosscut.telecom.v2.trace;

import org.aspectj.lang.JoinPoint;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect SimulationMessageManagement {

  before(Object o) : Pointcuts.customerCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  before(Object o) : Pointcuts.customerHangupCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  before(Object o) : Pointcuts.customerPickupCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  after(Object o) : Pointcuts.customerFinalCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    SimulationMessages sm = SimulationMessages.get(o.getClass(), "final");
    System.out.println(sm.format(jp));
  }

  before(Object o) : Pointcuts.callInviteCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  before(Object o) : Pointcuts.callHangupCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  before(Object o) : Pointcuts.callPickupCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    String methName = jp.getSignature().getName();
    SimulationMessages sm = SimulationMessages.get(o.getClass(), methName);
    System.out.println(sm.format(jp));
  }

  after(Object o) : Pointcuts.callFinalCallTrace() && target(o) {
    JoinPoint jp = thisJoinPoint;
    SimulationMessages sm = SimulationMessages.get(o.getClass(), "final");
    System.out.println(sm.format(jp));
  }
}
