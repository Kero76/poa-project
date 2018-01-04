package newcode.crosscut.telecom.v2.trace;

import newcode.crosscut.telecom.v2.common.Pointcuts;

public aspect CallStateTracing {

	before() : Pointcuts.executionListToString() {
		/*
		 * Idees :
		 * 	- Call.isConnectedWith(Customer x) permet de savoir si un Callee est en état Complete.
		 *  - Call.includes(Customer x) permet de savoir si un Callee est en état Complete ou Pending.
		 *  - Ainsi, si un Customer n'est présent dans aucun dès deux, alors il est Dropped, vu qu'il est nul part.
		 *  - De plus, si un Callee est dans isConnectedWith mais non dans includes, alors il est en etat Complete forcément.
		 *  - Donc on en conclut qu'un callee présent dans includes mais pas isConnectedwith nous permet d'affirmer qu'il est en état Pending.
		 * 
		 * A partir de ces données, on peut facilement savoir ou placer les gens, l'idée peut être de faire une Map<ETAT, List<Customer>> 
		 * afin de répartir au final les custoemrs dans le bon endoir du résultat final.
		 * Ensuite, il suffit de boucler sur la map pour répartir directement les gens aux bons endroits 
		 * (en plaçant astucieusement les états dans l'ordre suivant : Pending / Complete / Dropped)
		 * 
		 * Pour récupérer la liste des Customer, l'utilisation d'un ThisJoinPoint permettrait de récupérer
		 * l'ensemble des Customer que doit trairer la méthode SimulationMessages.listToString(Customer ... c).
		 * Voilà pour l'idée principal de comment ça doit marcher en interne pour finaliser cette feature.
		 */
	
	}
}
