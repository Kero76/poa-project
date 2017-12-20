package newcode.domain.telecom.v2.util;

public class Contract {
    private Contract() {
        // rien
    }
    public static void checkCondition(boolean condition, String... msg) {
        if (!condition) {
            if (msg.length > 0) {
                throw new AssertionError(msg[0]);
            }
            throw new AssertionError();
        }
    }
}
