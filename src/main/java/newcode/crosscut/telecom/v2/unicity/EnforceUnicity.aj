package newcode.crosscut.telecom.v2.unicity;

import newcode.crosscut.telecom.v2.common.*;

aspect EnforceUnicity {
  declare error : Pointcuts.unicityPolicyUnsatisfied()
    : "Error";
}
