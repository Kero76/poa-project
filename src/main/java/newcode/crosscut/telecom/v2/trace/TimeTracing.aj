package newcode.crosscut.telecom.v2.trace;

import java.util.logging.Level;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.crosscut.telecom.v2.trace.format.AbstractFormatter;
import newcode.crosscut.telecom.v2.trace.format.Counter;
import newcode.crosscut.telecom.v2.trace.format.SpaceFormatter;
import newcode.crosscut.telecom.v2.trace.indent.SystemContextIndentation;
import newcode.domain.telecom.v2.connect.Customer;

public privileged aspect TimeTracing {
  
  // Formatter to show properly the trace level.
  AbstractFormatter formatter = new SpaceFormatter();

  // Add line separator between each runTest method.
  after() : Pointcuts.executionSimulationRunTest() {
    newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
      Level.INFO, 
      FeatureMessages.separatorLine(
        FeatureMessages.DEFAULT_CHAR_SEPARATOR, 
        FeatureMessages.DEFAULT_REPEAT_SIZE
      ),
      SystemContextIndentation.aspectOf().getDepth()
    );
  }
  
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.constructorInstantiationConnection() && this(c) {
     newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
        Level.INFO, 
        FeatureMessages.timeConnectionNullToPendingTracing(
        c.toString().substring(c.toString().lastIndexOf('.') + 1),
        formatter.format(SystemContextIndentation.aspectOf().getDepth())
      ),
      SystemContextIndentation.aspectOf().getDepth()
    );
  }
  
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.completeConnectionCall() && target(c) {
    newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
      Level.INFO, 
      FeatureMessages.timeConnectionPendingToCompleteTracing(
        c.toString().substring(c.toString().lastIndexOf('.') + 1),
        formatter.format(SystemContextIndentation.aspectOf().getDepth())
      ),
      SystemContextIndentation.aspectOf().getDepth()
    );
  }
  
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.dropConnectionCall() && target(c) {
    Customer caller = (Customer)c.getCaller();
    Customer callee = (Customer)c.getCallee();

    if (caller.getAreaCode() == callee.getAreaCode()) {
      newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
        Level.INFO, 
        FeatureMessages.timeConnectionCompleteToDroppedAndLocalConnexionTracing(
          c.toString().substring(c.toString().lastIndexOf('.') + 1), 
          c.getTimer().getTime(), 
          caller.getCallPrice(), 
          SystemContextIndentation.aspectOf().getDepth()
        ),
        SystemContextIndentation.aspectOf().getDepth()
      );
    } else {
      newcode.crosscut.telecom.v2.trace.indent.IndentLogging.logger.log(
        Level.INFO, 
        FeatureMessages.timeConnectionCompleteToDroppedAndDistanteConnexionTracing(
          c.toString().substring(c.toString().lastIndexOf('.') + 1),
          c.getTimer().getTime(), 
          caller.getCallPrice(), 
          SystemContextIndentation.aspectOf().getDepth()
        ),
        SystemContextIndentation.aspectOf().getDepth()
      );
    }
  }
}
