package newcode.crosscut.telecom.v2.trace.format;

/**
 * Counter class use to count step to show easily
 * the level of implication for stack trace aspects.
 * 
 * This class respect the pattern Singleton because 
 * in all project, only one counter must be used in same time.
 * So the Singleton pattern force only one access point for the step counter.
 * 
 * @author Nicolas GILLE
 * @since 1.0
 * @version 1.0
 */
public class Counter {

	/**
	 * Indicate the number of step can must show on console.
	 */
	private int counter;
	
	/**
	 * Only instance of Counter.
	 */
	private static Counter instance = null;
	
	/**
	 * Private constructor of the counter.
	 */
	private Counter() {
		this.counter = 0;
	}
	
	/**
	 * Only access point of the counter instance. 
	 * 
	 * @return
	 * 	The only one instance of Counter.
	 */
	public static Counter getInstance() {
		if (Counter.instance == null) {
			Counter.instance = new Counter();
		}
		return Counter.instance;
	}
		
	/**
	 * Get the value of the counter.
	 * 
	 * @return
	 * 	The value of the counter.
	 */
	public int getCounter() {
		return counter;
	}

	/**
	 * Increment the counter.
	 */
	public void increment() {
		this.counter++;
	}
	
	/**
	 * Decrement the counter.
	 */
	public void decrement() {
		this.counter--;
	}
}
