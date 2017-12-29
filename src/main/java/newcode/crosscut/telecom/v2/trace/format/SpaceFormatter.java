package newcode.crosscut.telecom.v2.trace.format;

/**
 * Subclass of AbstractFormatter to show 2 spaces between each
 * level of implication for the aspects.
 * 
 * @author Nicolas GILLE
 * @since 1.0
 * @version 1.0
 */
public class SpaceFormatter extends AbstractFormatter {
	
	/**
	 * Attribute use to add two space for each level of implication.
	 */
	public static final String SPACES = "  ";

	@Override
	public String format(int step) {
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < step; ++i) {
			sb.append(AbstractFormatter.SEPARATOR);
			sb.append(SpaceFormatter.SPACES);
		}
		
		return sb.toString();
	}
}
