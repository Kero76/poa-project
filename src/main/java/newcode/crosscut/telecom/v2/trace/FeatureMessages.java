package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.trace.indent.IndentFormatter;

public class FeatureMessages {
  
  /**
   * Default repeat value.
   * 
   * @see FeatureMessages.separatorLine()
   */
  public static final int DEFAULT_REPEAT_SIZE = 72;
  
  /**
   * Default separator character show.
   * 
   * @see FeatureMessages.separatorLine()
   */
  public static final char DEFAULT_CHAR_SEPARATOR = '-';
  
  /**
   * Static method must call to log behavior of feature bill, 
   * when the customer call with success (with complete status for connection).
   * 
   * @param name
   *  Name of the customer.
   * @param areaCode
   *  Area code of the customer.
   * @param seconds
   *  The number of seconds who the customer call another people.
   * @param price
   *  The price for the call.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String billCompleteTracing(String name, int areaCode, int seconds, double price) {
    return String.format(
        "%s[%d] a été connecté %d s pour un montant de %.0f", 
        name, areaCode, seconds, price
    );
  }
  
  /**
   * Static method must call to log behavior of feature bill, 
   * when the customer try to call another people without success (with pending status of connection).
   * 
   * @param name
   *  Name of the customer.
   * @param areaCode
   *  Area code of the customer.
   * @param callerName
   *  Name of the people call without success by the customer.
   * @param price
   *  Price of the call.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String billPendingTracing(String name, int areaCode, String callerName, double price) {
    return String.format(
        "%s[%d] est en attente de %s et son montant sera supérieur à %.0f", 
        name, areaCode, callerName, price
    );
  }
  
  /**
   * Static method must call to log behavior of feature time, 
   * when the connection state change from null to pending.
   * 
   * @param connection
   *  The memory address of the object connection.
   * @param indent
   *  The indentation needed to show correctly the trace.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String timeConnectionNullToPendingTracing(String connection, String indent) {
    return String.format(
        "%s%s(null -> PENDING)", 
        IndentFormatter.SEPARATOR, connection
    );
  }
  
  /**
   * Static method must call to log behavior of feature time, 
   * when the connection state change from pending to complete.
   * 
   * @param connection
   *  The memory address of the object connection.
   * @param indent
   *  The indentation needed to show correctly the trace.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String timeConnectionPendingToCompleteTracing(String connection, String indent) {
    return String.format(
        "%s%s(PENDING -> COMPLETE)", 
        IndentFormatter.SEPARATOR, connection
    );
  }
  
  /**
   * Static method must call to log behavior of feature time, 
   * when the connection state change from complete to dropped
   * with a locale connection.
   * 
   * @param connection
   *  The memory address of the object connection.
   * @param seconds
   *  The number of seconds when the connection during open.
   * @param price
   *  The price of the connection.
   * @param indent
   *  The indentation needed to show correctly the trace.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String timeConnectionCompleteToDroppedAndLocalConnexionTracing(String connection, int seconds, double price, int indent) {
	  return String.format(
        "%s%s(COMPLETE -> DROPPED)\n%sTemps de connexion : %d \n%sMontant de la connexion locale : %.0f", 
        IndentFormatter.SEPARATOR, connection, indentCreator(indent), seconds, indentCreator(indent), price
    );
  }
  
  /**
   * Static method must call to log behavior of feature time, 
   * when the connection state change from complete to dropped,
   * with a remote connection.
   * 
   * @param connection
   *  The memory address of the object connection.
   * @param seconds
   *  The number of seconds when the connection during open.
   * @param price
   *  The price of the connection.
   * @param indent
   *  The indentation needed to show correctly the trace.
   * @return
   *  A beautiful string with all information to log on logger.
   */
  public static String timeConnectionCompleteToDroppedAndDistanteConnexionTracing(String connection, int seconds, double price, int indent) {
    return String.format(
        "%s%s(COMPLETE -> DROPPED)\n%sTemps de connexion : %d \n%sMontant de la connexion longue distance : %.0f", 
        IndentFormatter.SEPARATOR, connection, indentCreator(indent), seconds, indentCreator(indent), price
    );
  }
  
  /**
   * Show a line separator with specific separator char.
   *  
   * @param separatorChar
   *  Character use to generate the line separator.
   * @param repeat
   *  The number of separatorChar will be create for the line.
   * @return
   *  
   */
  public static String separatorLine(char separatorChar, int repeat) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < repeat; ++i) {
      sb.append(separatorChar);
    }
    return sb.toString();
  }
  
  /**
   * Create the right indentation representation for string.
   * @param indent
   * @return
   * 
   * @see timeConnectionCompleteToDroppedAndDistanteConnexionTracing()
   * @see timeConnectionCompleteToDroppedAndLocalConnexionTracing()
   */
  private static String indentCreator(int indent) {
	  StringBuilder str = new StringBuilder();
	  for (int i = 0; i <= indent; ++i) {
		  str.append(IndentFormatter.SEPARATOR);
	  }
	  
	  return str.toString();
  }
}
