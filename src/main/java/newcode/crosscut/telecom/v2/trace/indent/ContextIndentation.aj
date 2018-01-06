package newcode.crosscut.telecom.v2.trace.indent;

public abstract aspect ContextIndentation {
  private int depth;
  
  public abstract pointcut logContextOp();
  
  before() : logContextOp() {
    depth++;
  }
  
  after() : logContextOp() {
    depth--;
  }
  
  public int getDepth() {
    return depth;
  }
}
