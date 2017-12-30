package newcode.crosscut.telecom.v2.trace.format;

/**
 * Abstract class to represent all possible formatter to show the step of implication.
 * You must extends this class to add many other sort of formatters like Tabulation, ...  
 * 
 * @author Nicolas GILLE
 * @since 1.0
 * @version 1.0
 */
abstract public class AbstractFormatter {
  
  /**
   * The separator to show more easily the level of implication you are. 
   */
  public static final char SEPARATOR = '|';

  /**
   * Format with specific value.
   * 
   * @param step 
   *  Step to add specific value of formatter.
   * @return
   *  A string format with specific value.
   */
  public abstract String format(int step);
}
