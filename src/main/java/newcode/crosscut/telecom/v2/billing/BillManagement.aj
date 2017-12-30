package newcode.crosscut.telecom.v2.billing;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.domain.telecom.v2.connect.Customer;

public privileged aspect BillManagement {
  
  /**
   * Add an attribute callPrice on Customer.
   */
  private int newcode.domain.telecom.v2.connect.Customer.callPrice;

  /**
   * Instantiate callPrice for the connection object.
   */
  public void newcode.domain.telecom.v2.connect.Customer.constructorInstantiationCustomer() {
    callPrice = 0;
  }

  /**
   * Add method to get CallPrice value.
   */
  public int newcode.domain.telecom.v2.connect.Customer.getCallPrice() {
    return callPrice;
  }

  /**
   * Add the price on the maximum price who must paid by the customer.
   */
  public void newcode.domain.telecom.v2.connect.Customer.addPrice(int price) {
    callPrice += price;
  }
  
  /**
   * Add the attribute callPrice on the object Customer.
   * 
   * @param c
   *  The object Customer where add new attribute.
   */
  after(Customer c) : Pointcuts.constructorInstantiationCustomer() && this(c) {
    c.constructorInstantiationCustomer();
  }
  
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.dropConnectionCall() && target(c) {
    Customer caller = (Customer) c.getCaller();
    caller.addPrice(Bill.computePrice(c.type, c.getTimer().getTime()));
  }
  
  /**
   * Add an attribute type to Connection.
  */  
  private ConnectionType newcode.domain.telecom.v2.connect.Connection.type;
  
  /**
   * Tells a new connection what is its type.
   * @param c
   *   The newly instantiated connection.
  */
  after(newcode.domain.telecom.v2.connect.Connection c) : Pointcuts.constructorInstantiationConnection() && this(c) {
    c.type = Bill.getConnectionType(c.getCaller(), c.getCallee());
  }
}
