// an array name decays into a ptr to its 1st el
// i.e. array name is ptr to ptr

// case 1: array of ptrs

Shape *picture[MAX];
// same as
Shape **pic1 = picture;

// case 2: change value of a ptr passed to a func

// C
void scanTo(const char **p);

const char *cp;
scanTo(&cp);

// C++
void scanTo(const char *&p);

const char *cp;
scanTo(cp);

// conversions which apply to ptrs DO NOT apply to ptrs to ptrs

// a ptr to a derived class can be converted to a ptr to the base class
Circle *c = new Circle;
Shape *s = c;   // fine, Circle is-a Shape, it's also a ptr to a Shape

// a ptr to a ptr to a Circle is not a ptr to a ptr to a Shape
Circle **c = &c;
Shape **s = cc; // error!

char *s1 = 0;
// can convert a ptr to non-const to a ptr to const
const char *s2 = s1;    // OK
char *a[MAX];           // a.k.a. char **
// cannot convert a ptr to a ptr to non-const to a ptr to ptr to const
const char **ps = a;    // error!
