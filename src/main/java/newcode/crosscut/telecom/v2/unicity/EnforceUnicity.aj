package newcode.crosscut.telecom.v2.unicity;

import java.util.ArrayList;
import java.util.List;

import newcode.crosscut.telecom.v2.common.Pointcuts;
import newcode.domain.telecom.v2.util.NotUniqueException;

aspect EnforceUnicity {
	
	/**
	 * List of all customer's name.
	 */
	private List<String> names = new ArrayList<String>();
	
	/**
	 * Pointcut used to throws an NotUniqueException when
	 * the name is already defined previously.
	 * 
	 * @param name
	 * 	Name of the customer.
	 * @param ac
	 * 	Area code of the user.
	 * @throws NotUniqueException
	 */
	before(String name, int ac) : Pointcuts.constructorCustomerCall(name, ac) {
		if (names.contains(name)) {
			throw new NotUniqueException();
		}
		names.add(name);
	}
}
