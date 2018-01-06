package newcode.crosscut.telecom.v2.trace.indent;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect SystemContextIndentation extends ContextIndentation {
  public pointcut logContextOp() :
    Pointcuts.customerFinalCallTrace()
    || Pointcuts.callFinalCallTrace()
  ;
}
