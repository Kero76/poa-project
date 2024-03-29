package newcode.crosscut.telecom.v2.trace.indent;

import java.util.logging.Formatter;
import java.util.logging.LogRecord;

public class IndentFormatter extends Formatter {

  public final static String SEPARATOR = "|  ";

  public synchronized String format(LogRecord record) {
    StringBuffer sb = new StringBuffer();
    int depth = 0;
    if (record.getParameters() != null && (Integer) record.getParameters()[0] > 0) {
      depth = ((Integer) record.getParameters()[0]) - 1; 
    } else {
      depth = 0;
    }
    sb.append(getIndent(depth));
    String message = formatMessage(record);
    sb.append(message);
    sb.append(System.getProperty("line.separator"));
    return sb.toString();
  }
  
  private String getIndent(int n) {
    if (n == 0) {
      return "";
    } else {
      return "|  " + getIndent(n - 1);
    }
  }
}
