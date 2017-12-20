package newcode.crosscut.telecom.v2.common;

import newcode.domain.telecom.v2.connect.*;

public aspect Pointcuts {
  public pointcut checkUnicityPolicy() :
    set(@UniqueId private final String Customer.name);
  
  public pointcut unicityPolicyUnsatisfied() :  
    set(@UniqueId private !final String newcode..*.name)
    || set(@UniqueId private final !String newcode..*.name);
}
