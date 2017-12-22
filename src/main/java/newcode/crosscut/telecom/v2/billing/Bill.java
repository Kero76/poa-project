package newcode.crosscut.telecom.v2.billing;

import newcode.domain.telecom.v2.connect.ICustomer;

public class Bill {
  public static int computePrice(ConnectionType type, int seconds) {
    return type.getRate() * seconds;
  }
  
  public static ConnectionType getConnectionType(ICustomer c1, ICustomer c2) {
    if (c1.getAreaCode() == c2.getAreaCode()) {
      return ConnectionType.LOCAL;
    } else {
      return ConnectionType.NATIONAL;
    }
  }  
}
