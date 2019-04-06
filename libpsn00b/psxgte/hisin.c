/* Based on isin_S4 implementation from coranac:
 *	http://www.coranac.com/2009/07/sines/
 *
 */

#define qN	15
#define qA	12
#define B	19900
#define	C	3516

int hisin(int x) {

    int c, x2, y;

    c= x<<(30-qN);              // Semi-circle info into carry.
    x -= 1<<qN;                 // sine -> cosine calc

    x= x<<(31-qN);              // Mask with PI
    x= x>>(31-qN);              // Note: SIGNED shift! (to qN)
    x= x*x>>(2*qN-14);          // x=x^2 To Q14

    y= B - (x*C>>14);           // B - x^2*C
    y= (1<<qA)-(x*y>>16);       // A - x^2*(B-x^2*C)

    return c>=0 ? y : -y;

}

int hicos(int x) {

    return hisin( x+32768 );

}
