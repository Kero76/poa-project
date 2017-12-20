package newcode.domain.telecom.v2.connect;

/**
 * Un client est caract�ris� par son nom.
 * Il peut appeler un autre client, d�crocher, raccrocher et inviter d'autres
 *  clients � un appel en cours.
 * @inv
 *     getName() != null && !"".equals(getName())
 *     x.getName().equals(getName()) <==> x == this
 *     getAreaCode() >= 0
 *     isFree() <==> getCall() == null
 *     !isFree()
 *         ==> getCall().getCaller() == this || getCall().isConnectedWith(this)
 *     this.isCalling(x) <==> x.isCalling(this)
 *     !this.isCalling(this)
 * @cons
 *     $ARGS$ String n, int ac
 *     $PRE$
 *         n != null && !"".equals(n)
 *         n n'est pas d�j� pris
 *         ac >= 0
 *     $POST$
 *         getName().equals(n)
 *         getAreaCode() == ac
 *         isFree()
 */
public interface ICustomer {
    
    // REQUETES
    
    /**
     * La zone g�ographique du client.
     */
    int getAreaCode();

    /**
     * L'appel en cours.
     * Retourne null s'il n'y en a pas.
     */
    ICall getCall();

    /**
     * Le nom de ce client.
     */
    String getName();

    /**
     * D�termine si ce client est en communication avec x.
     * @pre
     *     x != null
     */
    boolean isCalling(ICustomer x);
    
    /**
     * Indique si ce client est libre ou occup�.
     */
    boolean isFree();

    // COMMANDES
    
    /**
     * Appelle le client x.
     * Si x est occup�, l'appel n'aboutit pas : aucune nouvelle connexion n'est
     *  mise en place.
     * Si ce client est d�j� en communication, il s'agit d'une conf�rence.
     * @pre
     *     x != null && x != this
     *     isFree() || getCall().getCaller() == this
     * @post
     *     x.isFree()
     *         ==> old isFree()
     *                 ==> !this.isFree()
     *                     getCall().getCaller() == this
     *                     getCall().includes(x)
     *         ==> old (!isFree() && getCall().getCaller() == this)
     *                 ==> getCall().includes(r)
     */
    void call(ICustomer x);

    /**
     * Raccroche d'un appel.
     * @pre
     *     !isFree()
     * @post
     *     isFree()
     *     this == old getCall().getCaller()
     *         ==> forall r:(old getCall().isConnectedWith(r)) : r.isFree()
     */
    void hangUp();

    /**
     * R�pond � un appel.
     * @pre
     *     c != null && c.includes(this)
     *     isFree()
     * @post
     *     getCall() == c
     *     c.isConnectedWith(this)
     */
    void pickUp(ICall c);
}
