package newcode.crosscut.telecom.v2.trace;

import java.util.Map;

import newcode.domain.telecom.v2.connect.ICustomer;

public privileged aspect CallStateTracing {
	
	public String newcode.domain.telecom.v2.connect.Call.toString() {
		StringBuilder str = new StringBuilder();
		str.append('<');
		str.append(this.getCaller().getName());
		str.append('|');
		str.append(mapAsString((Map<ICustomer, newcode.domain.telecom.v2.connect.Connection>) this.pending));
		str.append('|');
		str.append(mapAsString((Map<ICustomer, newcode.domain.telecom.v2.connect.Connection>) this.complete));
		str.append('|');
		// Insert dropped string to complete process ;)
		str.append('>');
		return str.toString();
	}
	
	/**
	 * Build a String thanks to a Map.
	 * 
	 * @param map
	 * 	Map to transform on String.
	 * @return
	 * 	The representation of the map as String.
	 */
	private String newcode.domain.telecom.v2.connect.Call.mapAsString(Map<ICustomer, newcode.domain.telecom.v2.connect.Connection> map) {
		if (map.isEmpty()) {
			return "";
		} 
		
		StringBuilder str = new StringBuilder();
		for (ICustomer c : map.keySet()) {
			str.append(c.getName());
			str.append(' ');
		}
		
		return str.toString();
	}
}
