package newcode.crosscut.telecom.v2.common;

import newcode.domain.telecom.v2.connect.*;
import newcode.crosscut.telecom.v2.unicity.UniqueId;

public aspect Pointcuts {
	
	/**
	 * Check if the annotation @UniqueId is used for
	 * annotate the attribute Customer.name
	 * 
	 * @see newcode.domain.telecom.v2.connect.Customer
	 */
	public pointcut checkUnicityPolicy() :
		set(@UniqueId private final String Customer.name)
	;
  
	/**
	 * Throw an error when the developer annotate wrong attribute.
	 * 
	 * @see newcode.domain.telecom.v2.common.Config
	 */
	public pointcut unicityPolicyUnsatisfied() :  
		set(@UniqueId private !final String+ newcode..*.name)
		|| set(@UniqueId private final !String+ newcode..*.name)
	;
}
