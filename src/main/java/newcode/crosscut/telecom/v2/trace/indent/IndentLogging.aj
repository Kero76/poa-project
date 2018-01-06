package newcode.crosscut.telecom.v2.trace.indent;

import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

import newcode.domain.telecom.v2.simulate.Simulation;

public aspect IndentLogging {
  private Logger logger = Logger.getLogger(this.getClass().getName());
  private Handler handler = logger.getParent().getHandlers()[0];
  
  public IndentLogging() {
    handler.setFormatter(new IndentFormatter());
  }

  private pointcut logged(Logger log, Level level, String mess) :
    call(* newcode.crosscut.telecom.v2.trace.*.Simulation.logger.info(..))
    && target(log)
    && args(level, mess)
    && !within(ContextIndentation)
  ;

  void around(Logger log, Level level, String mess) :
    logged(log, level, mess) {
    logger.setLevel(log.getLevel());
    logger.log(level, mess, SystemContextIndentation.aspectOf().getDepth());
    System.out.println("Hey!");
  }
}
