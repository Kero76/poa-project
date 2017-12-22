package newcode.crosscut.telecom.v2.billing;

public class Bill {
	
	/**
	 * Price of one second.
	 */
	private static final double SECOND_PRICE = 0.01;
	
	/**
	 * Compute the price of call
	 * 
	 * @param seconds
	 * 	The duration of the call.
	 * @return
	 * 	Price of call.
	 */
	public static double computePrice(int seconds) {
		return Bill.SECOND_PRICE * seconds;
	}
}
