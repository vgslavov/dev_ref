# Effective C++: 55

Excerpts from Scott Meyer's Effective C++.

## Terminology

* `declaration`: name and type of something
* `signature` of a function: its parameters and return type
* `definition`
    * object: set aside memory
    * function/template: code body
    * class/template: members of the class
* `initialization`: give an obj. its 1st value
* `default ctor`: ctor w/o parameters or with all default parameters
    * `Widget();`
    * `Widget(int x = 0);`
* `explicit` ctors prevent implicit type conversions [preferred]
    * `explicit Widget(int x);`
* `copy ctor`: init an obj. with a different obj. of same type
    * `Widget(const Widget &rhs);`
    * defines how an obj. is passed by value
* `copy assign. op.`: copy value of one obj. to another of same type
    * `Widget &operator=(const Widget &rhs);`
    ```
    Widget w1;      // default ctor
    Widget w2(w1);  // copy ctor
    w1 = w2;        // copy assign. op.
    Widget w3 = w2; // copy ctor! (w3 has to be init. so it must be a ctor, not copy)
    ```
* `function objects`: objects which act like functions, overload `operator()`
* `undefined behavior` (at runtime)
    * dereferencing a null ptr
    * referring to an invalid array index
* `interface` (generic, not a language element)
    * a function's signature
    * accessible elements of a class (public, private, protected)
* for member functions, the left-hand argument (lhs) is represented by the
  `this` ptr

## Chapter 1: Accustoming Yourself to C++

### Item 1: View C++ as a federation of languages

Rules for effective C++ programming vary, depending on the part of C++ you are
using.

* Rules within each sublanguage are 'simple' and consistent
* C++ is a federation of 4 sublanguages
    * `C`
        * blocks
        * statements
        * preprocessor
        * built-in data types
        * arrays
        * pointers
    * `Object-Oriented C++`
        * classes
        * encapsulation
        * inheritance
        * polymorphism
        * virtual functions (dynamic binding)
    * `Template C++`: generic programming
    * `The STL`
        * containers
        * iterators
        * algorithms
        * function objects
        * adaptors
* `pass-by-value` is more efficient for built-in types in `C` and `STL` (for
  iterators and function objs. as they are modeled on ptrs in C)
* `pass-by-ref-to-const` is preferred in `OO C++` and especially in `Template
  C++`

### Item 2: Prefer consts, enums, and inlines to #defines

* prefer the compiler to the preprocessor
    ```
    const double AspectRatio = 1.653;
    // instead of
    #define ASPECT_RATIO 1.653
    ```
* string instead of const char
    ```
    const std::string authorName("Scott Meyers");
    // instead of
    const char * const authorName = "Scott Meyers";
    ```
* const declaration of a static data member (allowed for static, integral types)
    ```
    // .h
    class GamePlayer {
    private:
    static const int NumTurns = 5;      // constant *declaration*
    int scores[NumTurns];               // use of constant
    ...
    };

    // .cpp
    const int GamePlayer::NumTurns;     // *definition* of NumTurns
    ```
* if an (old) compiler complains
    ```
    // .h
    class CostEstimate {
    private:

    static const double FudgeFactor;     // *declaration* of static class const
    };

    // .cpp
    const double                         // *definition* of static class const
    CostEstimate::FudgeFactor = 1.35;
    ```
* `enum-hack`: values of enumerated types can be used where ints are exptected
    ```
    class GamePlayer {
    private:
    enum { NumTurns = 5 };        // "the enum hack" — makes
                                    // NumTurns a symbolic name for 5

    int scores[NumTurns];         // fine
    };
    ```
* never write macros that look like functions, use inline template func. instead
    ```
    template<typename T>                               // because we don't
    inline void callWithMax(const T& a, const T& b)    // know what T is, we
    {                                                  // pass by reference-to-
    f(a > b ? a : b);                                // const — see Item 20
    }

    // call f with the maximum of a and b
    #define CALL_WITH_MAX(a, b) f((a) > (b) ? (a) : (b))
    ```
* preprocessor can't be avoided altogether; legitimate uses:
    * `#include`
    * `#ifdef` and `#ifndef`
* for simple constants, prefer const objects or enums to `#define`s
* for function-like macros, prefer inline functions to `#define`s

### Item 3: Use `const` whenever possible

* read right to left (e.g. `p` is a constant pointer to constant chars)
    ```
    char greeting[] = "Hello";
    char *p = greeting;                    // non-const pointer,
                                           // non-const data
    const char *p = greeting;              // non-const pointer,
                                           // const data
    char * const p = greeting;             // const pointer,
                                           // non-const data
    const char * const p = greeting;       // const pointer,
                                           // const data
    ```
* equivalent syntax
    ```
    void f1(const Widget *pw);         // f1 takes a pointer to a
                                       // constant Widget object
    void f2(Widget const *pw);         // so does f2
    ```
* iterators
    ```
    std::vector<int> vec;
    const std::vector<int>::iterator iter =     // iter acts like a T* const
    vec.begin();
    *iter = 10;                                 // OK, changes what iter points to
    ++iter;                                     // error! iter is const
    std::vector<int>::const_iterator cIter =    //cIter acts like a const T*
    vec.begin();
    *cIter = 10;                               // error! *cIter is const
    ++cIter;                                   // fine, changes cIter
    ```
* const return values
    ```
    class Rational { ... };
    const Rational operator*(const Rational& lhs, const Rational& rhs);
    // previents doing the following
    Rational a, b, c;
    (a * b) = c;                           // invoke operator= on the
    if (a * b = c) ...                     // oops, meant to do a comparison!
                                           // result of a*b!
    ```
* const member functions: overload based on const-ness
    ```
    class TextBlock {
    public:
        const char&                                       // operator[] for
        operator[](const std::size_t position) const      // const objects
        { return text[position]; }
        char&                                             // operator[] for
        operator[](const std::size_t position) const      // non-const objects
        { return text[position]; }
    private:
        std::string text;
    };

    TextBlock tb("Hello");
    std::cout << tb[0];                   // calls non-const
                                            // TextBlock::operator[]

    void print(const TextBlock& ctb)      // in this function, ctb is const
    {
        std::cout << ctb[0];              // calls const TextBlock::operator[]
    }
    ```
* it's never legal to modify the return value of a function that returns a
  built-in type: `operator[]` has to return `char&`, not `char`
* C++ returns objects by value
* **bitwise constness**: don't modify the bits inside the object (which doesn't
  include static members)
* passes bitwise constness test (by compiler) but can be misused as `operator[]`
  returns a reference to the object's internal data
    ```
    class CTextBlock {
    public:
        char& operator[](std::size_t position) const   // inappropriate (but bitwise
        { return pText[position]; }                    // const) declaration of
                                                       // operator[]
    private:
        char *pText;
    };

    const CTextBlock cctb("Hello");        // declare constant object
    char *pc = &cctb[0];                   // call the const operator[] to get a
                                           // pointer to cctb's data
    *pc = 'J';                             // cctb now has the value "Jello"
    ```
* **logical constness**: may modify some of the object's bits but only in ways
  the client cannot detect by using `mutable`
    ```
    class CTextBlock {
    public:
        std::size_t length() const;
    private:
        char *pText;
        mutable std::size_t textLength;         // these data members may
        mutable bool lengthIsValid;             // always be modified, even in
    };                                          // const member functions

    std::size_t CTextBlock::length() const {
        if (!lengthIsValid) {
            textLength = std::strlen(pText);      // now fine
            lengthIsValid= true;                 // also fine
        }
        return textLength;
    }
    ```
* avoiding code duplication in `const` and non-`const` member functions:
  implement implement `operator[]` once and use it twice using `const_cast` and
  `static_cast`
    ```
    class TextBlock {
    public:
        const char& operator[](std::size_t position) const     // same as before
        {
            return text[position];
        }

        char& operator[](std::size_t position)         // now just calls const op[]
        {
            return
            const_cast<char&>(                         // cast away const on
                                                       // op[]'s return type;
                static_cast<const TextBlock&>(*this)   // add const to *this's type;
                [position]                             // call const version of op[]
            );
        }
    };
    ```
* never try the opposite: calling the non-`const` from the `const` member
  function
* declare `const` so the compiler can detect errors
* apply `const` at any scope, to function parameters, return types, and member
  functions
* compilers enforce bitwise constness but program for logical constness
* avoid code duplication of `const` and non-`const` member functions by having
  the non-`const` version call the `const` version

### Item 4: Make sure that objects are initialized before they're used

* *always* initialize your objects before you use them
* for non-member objects of built-in types, do it manually
* for everything else, use ctors
* do not confuse assignment with initialization
* data members of an object are initialized *before* a ctor is entered!
* in ctors, use member initialization lists instead of assignment
* for most types, a signle call to a copy ctor is *much* more efficient than a
  call to the default ctor + a call to the copy assign. op.
* use member init. list even when you want to default-construct a data member
  (e.g. `phones()`)
* *always* use the member initialization list
* order in which an object's data is initialized
    * base classes are initialized before derived classes
    * within a class, data members are initialized in the order in which they
      are declared (not order in member init. list)
    * to avoid confusion, *always* list members in the init. list in the same
      order as they're declared in the class
* order of initialization of non-local static objects defined in the different
  translation units
    * a `static object` exists from the time it's constructed until the end of
      the program
        * included
            * global objects
            * objects defined at namespace scope
            * objects declared `static` inside classes: *non-local static objects*
            * objects declared `static` inside functions: *local static objects*
              (they are local to a function)
            * objects declared `static` at file scope: *non-local static objects*
        * excluded
            * stack objects
            * heap objects
        * destroyed when `main` finishes executing
    * `translation unit`: the source code giving rise to a single object file
      (a single source file + all its `#include` files)
    * **problem**: if initialization of a *non-local static object* in one
      *translation unit* uses a *non-local static object* in a different
      *translation unit*, the object it uses could be uninitialized, because
      *the relative order of initialization of non-local static objects defined
      in different translation units is undefined*.
    * **solution**: move each *non-local static object* into its own function,
      where ti's declared *static*
        * functions return references to the objects they contain
        * clients call functions instead of referring to objects
        * *non-local* static objects are replaced with *local* static objects
          (Singleton pattern)
        ```
        class FileSystem { ... };           // as before
        FileSystem& tfs()                   // this replaces the tfs object; it could be
        {                                   // static in the FileSystem class
            static FileSystem fs;           // define and initialize a local static object
            return fs;                      // return a reference to it
        }

        class Directory { ... };            // as before
        Directory::Directory( params )      // as before, except references to tfs are
        {                                   // now to tfs()
            std::size_t disks = tfs().numDisks();
        }
        Directory& tempDir()                // this replaces the tempDir object; it
        {                                   // could be static in the Directory class
            static Directory td;            // define/initialize local static object
            return td;                      // return reference to it
        }
        ```
    * these functions are good candidates for inlining
    * problematic in multithreaded systems (manually invoke the
      reference-returning functions during the single-threaded startup of the
      program to eliminated initialization-related race conditions)
* to avoid using uninitialized objects
    * manually initialize non-member objects of built-in types
      (C++ only sometimes init. them itself)
    * use member initialization lists to initialize all part of the object
    * design around init. order uncertainty which affects non-local static
      objects defined in separate translation units by replacing non-local
      static objects with local static objects

## Chapter 3: Constructors, Destructors, and Assignment Operators

### Item 5: Know what functions C++ silently writes and calls

* if not declared (but needed/called), compiler generates
    * default constructor
      (only if no ctor (neither default nor arg) has been declared)
    * copy constructor
    * copy assignment operator
    * destructor (non-virtual,
      unless for a derived class with a base class with a virtual dtor)
    ```
    // declared
    class Empty{};

    // compiler-generated (if needed)
    class Empty {
    public:
        Empty() { ... }                            // default constructor
        Empty(const Empty& rhs) { ... }            // copy constructor

        ~Empty() { ... }                           // destructor — see below
                                                    // for whether it's virtual

        Empty& operator=(const Empty& rhs) { ... } // copy assignment operator
};
    ```
* exceptions: compiler refuses to compile the code (must define copy assign. op.)
    * a class containing a reference member
    * a class containing `const` members
    * a derived class which inherit from base classes declaring the copy assign.
      op. `private`

### Item 6: Explicitly disallow the use of compiler-generated functions you do not want

* to disallow functionality automatically provided by compilers
    * declared the corresponding member functions `private`
    * don't provide definitions
    * will generate a link-time error if a call is made (e.g. to copy)
* mostly used for preventing copying of objects (copy ctor and copy assing. op.)
    ```
    class HomeForSale {
    private:
        HomeForSale(const HomeForSale&);            // declarations only
        HomeForSale& operator=(const HomeForSale&);
    };
    ```
* to move the link-time error to compile-time
    * declare copy ctor and copy assign. op. `private` in a base class
    ```
    class Uncopyable {
    protected:                                   // allow construction
        Uncopyable() {}                            // and destruction of
        ~Uncopyable() {}                           // derived objects...
    private:
        Uncopyable(const Uncopyable&);             // ...but prevent copying
        Uncopyable& operator=(const Uncopyable&);
    };
    ```
    * make current class inherit (`private`) from this base class
    ```
    class HomeForSale: private Uncopyable {     // class no longer
                                                // declares copy ctor or
    ```
    * or use Boost's `noncopyable`
