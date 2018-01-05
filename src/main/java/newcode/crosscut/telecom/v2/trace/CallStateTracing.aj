package newcode.crosscut.telecom.v2.trace;

import java.util.*;

import newcode.domain.telecom.v2.connect.*;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public privileged aspect CallStateTracing {
  /**
   * Saves customers even after they have dropped, allowing to print them after.
  */
  private List<ICustomer> newcode.domain.telecom.v2.connect.Call.dropped;
  
  /**
   * Instantiate dropped after Call construction.
  */
  after(newcode.domain.telecom.v2.connect.Call c) :
    Pointcuts.callConstruction()
    && this(c) {
    c.dropped = new ArrayList<>();
  }
  
  after(newcode.domain.telecom.v2.connect.Connection co, Call callObj) :
    Pointcuts.dropConnectionCall()
    && this(callObj)
    && target(co) {
    callObj.dropped.add(co.getCallee());
  }

  public String newcode.domain.telecom.v2.connect.Call.toString() {
    StringBuilder sb = new StringBuilder();
    sb.append('<');
    sb.append(this.getCaller().getName());
    sb.append('|');
    sb.append(mapAsString((Map<ICustomer, newcode.domain.telecom.v2.connect.Connection>) this.pending));
    sb.append('|');
    sb.append(mapAsString((Map<ICustomer, newcode.domain.telecom.v2.connect.Connection>) this.complete));
    sb.append('|');
    sb.append(listAsString(this.dropped));
    sb.append('>');
    return sb.toString();
  }
  
  /**
   * Build a String thanks to a Map.
   * 
   * @param map
   *  Map to transform on String.
   * @return
   *  The representation of the map as String.
   */
  private String newcode.domain.telecom.v2.connect.Call.mapAsString(Map<ICustomer, newcode.domain.telecom.v2.connect.Connection> map) {
    if (map.isEmpty()) {
      return "";
    } 
    
    StringBuilder str = new StringBuilder();
    for (ICustomer c : map.keySet()) {
      str.append(c.getName());
      str.append(' ');
    }
    
    return str.toString().trim();
  }
  
  /**
   * Build a String thanks to a List.
   * 
   * @param list
   *  List to transform on String.
   * @return
   *  The representation of the list as String.
   */
  private String newcode.domain.telecom.v2.connect.Call.listAsString(List<ICustomer> list) {
    if (list.isEmpty()) {
      return "";
    } 
    
    StringBuilder str = new StringBuilder();
    for (ICustomer c : list) {
      str.append(c.getName());
      str.append(' ');
    }
    
    return str.toString().trim();  
  }
}
