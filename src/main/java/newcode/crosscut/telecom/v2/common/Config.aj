package newcode.crosscut.telecom.v2.common;

public aspect Config {
  /**
   * Throw an error when a field with @UniqueId is not 
   * sign with final keyword or String type. 
   */
  declare error : 
    Pointcuts.unicityPolicyUnsatisfied() :
    "An error occured because the attribute annotate by @UniqueId "
    + "must be declare as final and as String object"
  ;
    
  /**
   * Declare precedence between features.
   */
  declare precedence :
    newcode.crosscut.telecom.v2.trace.indent.IndentLogging,
    newcode.crosscut.telecom.v2.trace.SimulationMessageManagement
  ;
}
