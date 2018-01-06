package newcode.crosscut.telecom.v2.trace.indent;

import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

public aspect IndentLogging {
  public static Logger logger = Logger.getLogger(newcode.crosscut.telecom.v2.trace.indent.IndentLogging.class.getName());
  {
    Handler handler = logger.getParent().getHandlers()[0];
    handler.setFormatter(new IndentFormatter());
    logger.setParent(null);
  }
}
