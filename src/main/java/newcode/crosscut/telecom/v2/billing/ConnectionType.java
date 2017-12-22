package newcode.crosscut.telecom.v2.billing;

enum ConnectionType {
    LOCAL(3),
    NATIONAL(10);
    private int rate;
    ConnectionType(int r) {
      rate = r;
    }
    public int getRate() {
      return rate;
    }
    @Override
    public String toString() {
      return name().toLowerCase();
    }
}
