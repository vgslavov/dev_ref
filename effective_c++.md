# Effective C++

Excerpts from Scott Meyer's `Effective C++`.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Terminology](#terminology)
- [Chapter 1: Accustoming Yourself to C++](#chapter-1-accustoming-yourself-to-c)
  - [Item 1: View C++ as a federation of languages](#item-1-view-c-as-a-federation-of-languages)
  - [Item 2: Prefer consts, enums, and inlines to #defines](#item-2-prefer-consts-enums-and-inlines-to-defines)
  - [Item 3: Use `const` whenever possible](#item-3-use-const-whenever-possible)
  - [Item 4: Make sure that objects are initialized before they're used](#item-4-make-sure-that-objects-are-initialized-before-theyre-used)
- [Chapter 2: Constructors, Destructors, and Assignment Operators](#chapter-2-constructors-destructors-and-assignment-operators)
  - [Item 5: Know what functions C++ silently writes and calls](#item-5-know-what-functions-c-silently-writes-and-calls)
  - [Item 6: Explicitly disallow the use of compiler-generated functions you do not want](#item-6-explicitly-disallow-the-use-of-compiler-generated-functions-you-do-not-want)
  - [Item 7: Declare destructors virtual in polymorphic base classes](#item-7-declare-destructors-virtual-in-polymorphic-base-classes)
  - [Item 8: Prevent exceptions from leaving destructors](#item-8-prevent-exceptions-from-leaving-destructors)
  - [Item 9: Never call virtual functions during construction or destruction](#item-9-never-call-virtual-functions-during-construction-or-destruction)
  - [Item 10: Have assignment operators return a reference to `*this`](#item-10-have-assignment-operators-return-a-reference-to-this)
  - [Item 11: Handle assignment to self in `operator=`](#item-11-handle-assignment-to-self-in-operator)
  - [Item 12: Copy all parts of an object](#item-12-copy-all-parts-of-an-object)
- [Chapter 3: Resource Management](#chapter-3-resource-management)
  - [Item 13: Use objects to manage resources](#item-13-use-objects-to-manage-resources)
  - [Item 14: Think carefully about copying behavior in resource-managing classes](#item-14-think-carefully-about-copying-behavior-in-resource-managing-classes)
  - [Item 15: Provide access to raw resources in resource-managing classes](#item-15-provide-access-to-raw-resources-in-resource-managing-classes)
  - [Item 16: Use the same form in corresponding uses of `new` and `delete`](#item-16-use-the-same-form-in-corresponding-uses-of-new-and-delete)
  - [Item 17: Store `new`ed objects in smart pointers in standalone statements](#item-17-store-newed-objects-in-smart-pointers-in-standalone-statements)
- [Chapter 4: Designs and Declarations](#chapter-4-designs-and-declarations)
  - [Item 18: Make interfaces easy to use correctly and hard to use incorrectly](#item-18-make-interfaces-easy-to-use-correctly-and-hard-to-use-incorrectly)
  - [Item 19: Treat class design as type design](#item-19-treat-class-design-as-type-design)
  - [Item 20: Prefer pass-by-reference-to-`const` to pass-by-value](#item-20-prefer-pass-by-reference-to-const-to-pass-by-value)
  - [Item 21: Don't try to return a reference when you must return an object](#item-21-dont-try-to-return-a-reference-when-you-must-return-an-object)
  - [Item 22: Declare data members `private`](#item-22-declare-data-members-private)
  - [Item 23: Prefer non-member non-friend functions to member functions](#item-23-prefer-non-member-non-friend-functions-to-member-functions)
  - [Item 24: Declare non-member functions when type conversions should apply to all parameters](#item-24-declare-non-member-functions-when-type-conversions-should-apply-to-all-parameters)
  - [Item 25: Consider support for a non-throwing `swap`](#item-25-consider-support-for-a-non-throwing-swap)
- [Chapter 5: Implementations](#chapter-5-implementations)
  - [Item 26: Postpone variable definitions as long as possible](#item-26-postpone-variable-definitions-as-long-as-possible)
  - [Item 27: Minimize casting](#item-27-minimize-casting)
  - [Item 28: Avoid returning “handles” to object internals](#item-28-avoid-returning-handles-to-object-internals)
  - [Item 29: Strive for exception-safe code](#item-29-strive-for-exception-safe-code)
  - [Item 30: Understand the ins and outs of inlining](#item-30-understand-the-ins-and-outs-of-inlining)
  - [Item 31: Minimize compilation dependencies between files](#item-31-minimize-compilation-dependencies-between-files)
- [Chapter 6: Inheritance and Object-Oriented Design](#chapter-6-inheritance-and-object-oriented-design)
  - [Item 32: Make sure `public` inheritance models "is-a"](#item-32-make-sure-public-inheritance-models-is-a)
  - [Item 33: Avoid hiding inherited names](#item-33-avoid-hiding-inherited-names)
  - [Item 34: Differentiate between inheritance of interface and interitance of implementation](#item-34-differentiate-between-inheritance-of-interface-and-interitance-of-implementation)
  - [Item 35: Consider alternatives to `virtual` functions](#item-35-consider-alternatives-to-virtual-functions)
  - [Item 36: Never redefine an inherited non-`virtual` function](#item-36-never-redefine-an-inherited-non-virtual-function)
  - [Item 37: Never redefine a function's inherited default parameter value](#item-37-never-redefine-a-functions-inherited-default-parameter-value)
  - [Item 38: Model "has-a" or "is-implemented-in-terms-of" through composition](#item-38-model-has-a-or-is-implemented-in-terms-of-through-composition)
  - [Item 39: Use `private` inheritance judiciously](#item-39-use-private-inheritance-judiciously)
  - [Item 40: Use *multiple* inheritance judiciously](#item-40-use-multiple-inheritance-judiciously)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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
* things to remember
    * rules for effective C++ programming vary, depending on the part of C++ you
      are using

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
* things to remember
    * for simple constants, prefer `const` objects or `enum`s to `#define`s
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
* things to remember
    * declaring something `const` helps compilers detect usage errors. `const`
      can be applied to objects at any scope, to function parameters and return
      types, and to member functions as a whole
    * compilers enforce bitwise constness, but you should program using
      conceptual constness
    * when `const` and non-`const` member functions have essentially identical
      implementations, code duplication can be avoided by having the non-`const`
       version call the `const` version.

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
* things to remember
    * manually initialize objects of built-in type, because C++ only sometimes
      initializes them itself
    * in a constructor, prefer use of the member initialization list to
      assignment inside the body of the constructor; list data members in the
      initialization list in the same order they're declared in the class.
    * avoid initialization order problems across translation units by replacing
      non-local static objects with local static objects

## Chapter 2: Constructors, Destructors, and Assignment Operators

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
* things to remember
    * compilers may implicitly generate a class's default constructor,
      copy constructor, copy assignment operator, and destructor

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
* things to remember
    * to disallow functionality automatically provided by compilers, declare
      the corresponding member functions `private` and give no implementations;
      Using a base class like `Uncopyable` is one way to do this

### Item 7: Declare destructors virtual in polymorphic base classes

* things to remember
    * polymorphic base classes should declare virtual destructors; if a class
      has any virtual functions, it should have a virtual destructor
    * classes not designed to be base classes or not designed to be used
      polymorphically should not declare virtual destructors

### Item 8: Prevent exceptions from leaving destructors

* things to remember
    * destructors should never emit exceptions; if functions called in a
      destructor may throw, the destructor should catch any exceptions, then
      swallow them or terminate the program
    * if class clients need to be able to react to exceptions thrown during an
      operation, the class should provide a regular (i.e., non-destructor)
      function that performs the operation

### Item 9: Never call virtual functions during construction or destruction

* things to remember
    * don't call virtual functions during construction or destruction, because
      such calls will never go to a more derived class than that of the
      currently executing constructor or destructor

### Item 10: Have assignment operators return a reference to `*this`

* things to remember
    * have assignment operators return a reference to *this

### Item 11: Handle assignment to self in `operator=`

* things to remember
    * make sure `operator=` is well-behaved when an object is assigned to
      itself; techniques include comparing addresses of source and target
      objects, careful statement ordering, and copy-and-swap
    * make sure that any function operating on more than one object behaves
      correctly if two or more of the objects are the same

### Item 12: Copy all parts of an object

* things to remember
    * copying functions should be sure to copy all of an object's data members
      and all of its base class parts
    * don't try to implement one of the copying functions in terms of the other;
      instead, put common functionality in a third function that both call

## Chapter 3: Resource Management

### Item 13: Use objects to manage resources

* things to remember
    * to prevent resource leaks, use RAII objects that acquire resources in
      their constructors and release them in their destructors
    * two commonly useful RAII classes are `tr1::shared_ptr` and `auto_ptr`;
      `tr1::shared_ptr` is usually the better choice, because its behavior when
      copied is intuitive; copying an `auto_ptr` sets it to null

### Item 14: Think carefully about copying behavior in resource-managing classes

* things to remember
    * copying an RAII object entails copying the resource it manages, so the
      copying behavior of the resource determines the copying behavior of the
      RAII object
    * common RAII class copying behaviors are disallowing copying and performing
      reference counting, but other behaviors are possible

### Item 15: Provide access to raw resources in resource-managing classes

* things to remember
    * APIs often require access to raw resources, so each RAII class should
      offer a way to get at the resource it manages
    * access may be via explicit conversion or implicit conversion; in general,
      explicit conversion is safer, but implicit conversion is more convenient
      for clients

### Item 16: Use the same form in corresponding uses of `new` and `delete`

* things to remember
    * if you use `[]` in a `new` expression, you must use `[]` in the
      corresponding `delete` expression; if you don't use `[]` in a `new`
      expression, you mustn't use `[]` in the corresponding `delete` expression

### Item 17: Store `new`ed objects in smart pointers in standalone statements

* things to remember
    * store `new`ed objects in smart pointers in standalone statements; failure
      to do this can lead to subtle resource leaks when exceptions are thrown

## Chapter 4: Designs and Declarations

### Item 18: Make interfaces easy to use correctly and hard to use incorrectly

* the type system is your primary ally in preventing undesirable code from
  compiling
* reliable initialization of non-local *static* objects can be problematic
* have your types behave consistently with the built-in types
* when in doubt, do as the `int`s do!
* things to remember
    * good interfaces are easy to use correctly and hard to use incorrectly
    * your should strive for these characteristics in all your interfaces
    * ways to facilitate correct use include consistency in interfaces and
      behavioral compatibility with built-in types
    * ways to prevent errors include creating new types, restricting operations
      on types, constraining object values, and eliminating client resource
      management responsibilities
    * `tr1::shared_ptr` supports custom deleters
    * this prevents the cross-DLL problem, can be used to automatically unlock
      mutexes (see Item 14), etc.

### Item 19: Treat class design as type design

* defining a new *class* defines a new *type*: you are a *type* designer!
* questions
    * How should objects of your new type be created and destroyed?
        * ctor design
        * dtor design
        * mem allocation: `new`, `delete`
    * How should object initialization differ from object assignment?
        * ctor vs assignment operator differences
    * What does it mean for objects of your new type to be passed by value?
        * copy ctor design
    * What are the restrictions on legal values for your new type?
        * decide combinations of values for a class's data members
        * to determine the invariants class has to maintain
    * Does your new type fit into an inheritance graph?
        * any `virtual` functions? 
        * is dtor `virtual`?
    * What kind of type conversions are allowed for your new type?
        * a type conversion function
        * a non-`explicit` ctor
    * What operators and functions make sense for the new type?
    * What standard functions should be disallowed?
    * Who should have access to the members of your new type?
    * What is the “undeclared interface” of your new type?
    * How general is your new type?
        * a whole *family* of types: define a new class `template`
    * Is a new type really what you need?
* things to remember
    * class design is type design
    * before defining a new type, be sure to consider all the issues discussed
      in this Item

### Item 20: Prefer pass-by-reference-to-`const` to pass-by-value

* prevent the creation of new objects by passing by ref to `const`: not ctors &
  dtors will be called
* slicing problem
    * when a derived class obj is passed (by value) as a base class obj
    * the base class copy ctor is called
    * and the specialized features that make the obj behave like a dervied class
      obj are "sliced" off
* references are typically implemented as pointers
* passing something by reference means really passing a ptr
* for built-in types, choose pass-by-value (small)
* for iterators & function obj, choose pass-by-value (designed to be)
* `smallType != pass-by-value`
* for user-defined types, their size is subject to change *by definition*
* *only* types pass-by-value is guaranteed to be inexpensive are built-in types
  and STL iterator and function obj
* things to remember
    * prefer pass-by-reference-to-`const` over pass-by-value
    * it's typically more efficient and it avoids the slicing problem
    * the rule doesn't apply to built-in types and STL iterator and function
      object types
    * for them, pass-by-value is usually appropriate

### Item 21: Don't try to return a reference when you must return an object

* things to remember
    * never return a pointer or reference to a local stack object, a reference
    to a heap-allocated object, or a pointer or reference to a local static
    object if there is a chance that more than one such object will be needed;
    (Item 4 provides an example of a design where returning a reference to a
    local static is reasonable, at least in single-threaded environments)

### Item 22: Declare data members `private`

* things to remember
    * declare data members `private`; it gives clients syntactically uniform
      access to data, affords fine-grained access control, allows invariants to
      be enforced, and offers class authors implementation flexibility
    * `protected` is no more encapsulated than `public`

### Item 23: Prefer non-member non-friend functions to member functions

* things to remember
    * prefer non-member non-friend functions to member functions; doing so
      increases encapsulation, packaging flexibility, and functional
      extensibility

### Item 24: Declare non-member functions when type conversions should apply to all parameters

* things to remember
    * if you need type conversions on all parameters to a function (including
      the one pointed to by the this pointer), the function must be a non-member

### Item 25: Consider support for a non-throwing `swap`

* things to remember
    * provide a `swap` member function when `std::swap` would be inefficient for
      your type; make sure your `swap` doesn't throw exceptions
    * if you offer a member `swap`, also offer a non-member `swap` that calls
      the member; for classes (not templates), specialize `std::swap`, too
    * when calling `swap`, employ a using declaration for `std::swap`, then call
      swap without namespace qualification
    * it's fine to totally specialize `std` templates for user-defined types,
      but never try to add something completely new to `std`

## Chapter 5: Implementations

### Item 26: Postpone variable definitions as long as possible

* default-constructing an obj & then assigning to it is less efficient than
    initializing it
```
string encrypted1;              // default ctor
encrypted2 = password;          // assignment operator

string encrypted2(password);    // define & initialize via copy ctor
```
* postpone the definition until you have the init. args for it
* help doc purpose of vars by init-ing them in contexts to make meaning clear
* (A) define outside loop: 1 ctor + 1 dtor + n assignments
```
Widget w;
for (int i = 0; i < n; ++i) {
    w = i * 10;
}
```
* (B) define inside loop: n ctors + n dtors
```
for (int i = 0; i < n; ++i) {
    Widget w(i * 10);
}
```
* `(A) < (B)` unless ctor/dtor is much more expensive than assignment
* things to remember
    * postpone variable definitions as long as possible
    * it increases program clarity and improves program efficiency

### Item 27: Minimize casting

* casts subvert the type system!
* old-style casts
    * C-style: `(T) expression` cast *expression* to be of type T
    * function-style: `T(expression)` cast *expression* to be of type T
* new-style (C++) casts
    * `const_cast<T>(expression)`
    * `dynamic_cast<T>(expression)`
    * `reinterpret_cast<T>(expression)`
    * `static_cast<T>(expression)`
* `const_cast`
    * cast away constness of objects (`const` to non-`const`)
    * only cast that can do this
* `dynamic_cast`
    * "safe downcasting": determine object type in inheritance hierarchy
    * significant runtime cost
    * can't do using old syntax
* `reinterpret_cast`
    * implementation dependent (i.e. unportable)
    * use rarely outside low-level code
* `static_cast`
    * force implicit conversions (i.e. non-`const` to `const` object, `int` to
      `double`, pointer-to-base to pointer-to-derived)
* easier to identify/find in code
* type conversions of any kind often lead to code executed at runtime
* a single object may have more than one addess
* avoid making assumptions about how things are laid out in C++
* alternatives to `dynamic_cast`: when you only have a ptr/ref-to-base
    * use containers that store smart pointers to derived class objects
    * provide a `virtual` function in the base class to do what you need
* avoid cascading `dynamic_cast`: if type1, else if type2, etc.
    * big, slow & brittle
    * new derived class, new else if
* good C++ uses very few casts
* isolate by hiding inside functions
* things to remember
    * avoid casts whenever practical, especially `dynamic_casts` in
      performance-sensitive code
    * if a design requires casting, try to develop a cast-free alternative
    * when casting is necessary, try to hide it inside a function
    * clients can then call the function instead of putting casts in their own
      code
    * prefer C++-style casts to old-style casts
    * they are easier to see, and they are more specific about what they do

### Item 28: Avoid returning “handles” to object internals

* a data member is only as encapsulated as the most accessible function
  returning a reference to it
* if a `const` member function returns a ref to data associated with an obj
  stored outside the obj itself, the caller of the function can modify the data
* references, pointers, and iterators are all *handles*
* member functions not accessible to the general public (i.e. `protected` or
    `private`) are part of an obj's internals
* never have a member function return a ptr to a less accessible member function
* solution: return `const` refs
* *dangling handles*: handles that refer to parts of the obj that don't exist
  any longer
* things to remember
    * avoid returning handles (references, pointers, or iterators) to object
      internals
    * it increases encapsulation, helps `const` member functions act `const`,
      and minimizes the creation of dangling handles

### Item 29: Strive for exception-safe code

* exception safety requirements
    * leak no resources
    * don't allow data structures to become corrupted
* types of guarantees if exception
    * the basic guarantee: everything in the program remains in a *valid* state
    * the strong guarantee: the state of the program is *unchanged*
    * the nothrow guarantee: never throw exceptions
* things to remember
    * exception-safe functions leak no resources and allow no data structures
      to become corrupted, even when exceptions are thrown; such functions
      offer the basic, strong, or nothrow guarantees
    * the strong guarantee can often be implemented via copy-and-swap, but the
      strong guarantee is not practical for all functions
    * a function can usually offer a guarantee no stronger than the weakest
      guarantee of the functions it calls

### Item 30: Understand the ins and outs of inlining

* implicit: member functions in class definitions
* explicit: with `inline` keyword
* inlining pros
    * no function calls
    * potentially *smaller* object code
* inlining cons
    * cost: code bloat if overzealous
    * debuggers usually can't work with inlined functions
    * forces clients of libraries to recompile or at least relink when library
      with inlined functions changes
    * compilers may generate a function body for seemingly empty functions
      (e.g. derived class ctors)
    * inline functions must typically be in header files (most compilers do
      inlining during compilation)
    * function templates need to be inlined! (but are typically in header files
      as well)
* strategy
    * don't inline anything initially
    * or inline truly trivial and functions meant to be inlined (Item 46)
    * meant for hand optimization *after* done with debugging
    * 80-20 rule: typtical programs spend 80% of their time executing only 20%
      of their code
* things to remember
    * limit most inlining to small, frequently used functions
        * facilitates debugging and binary upgradability
        * minimizes potential code bloat
        * maximizes chances of greater program speed
    * don't delcare function templates `inline` just because they appear in
      header files

### Item 31: Minimize compilation dependencies between files

* C++ doesn't do a good job of separating *interfaces* from *implementations*
* a class definition specifies not only a class interface but also a fair
  amount of implementation details (e.g. data members which are defined
  somewhere else)
* can't forward-declare everything because compilers need to know the size of
  objects during compilation
* *never* forward-declare std types/objects
* `pimpl` (pointer to implementation, a.k.a. *Handle* class)
    * a design where a main class contains as a data member nothing but a
    * pointer to its implementation class
* to minimize compilation dependencies, replace dependencies on *definitions*
  with dependencies on *declarations*
    * make your header files safe sufficient when practical
    * depend on declarations in other files, not definitions
* avoid using objects when object references and pointers will do
    * you may define refs and ptrs to a type with only a declaration for the
      type
    * defining *objects* of a type necessitates the presence of the type's
      definition
* depend on class declarations instead of class definitions whenever you can
    * you *never* need a class definition to declare a function using that
        class
    * not even if the function passes or returns the class type by value
* provide separate header files for declarations and definitions
* *Interface* class: a special kind of abstract base class
    * specifies an interface for derived classes
    * no data members and ctors
    * has virtual dtor
    * has a set of pure virtual functions which specify the interface
    * clients use ptrs and refs to Interface class
    * like in *Handle* class, no recompilation is needed unless *Interface*
      class's interface is modified
    * new objects are created using a factory function (a.k.a *virtual ctor*)
        * returns (smart) ptr to dynamically-allocated objects to *Interface*
          class
        * `static` inside the Interface class
* ways to implement an *Interface* class
    * inherit interface spec from the Interface class
    * implement the functions in the interface
    * or use multiple inheritance
* *Interface* and *Handle* classes summary
    * decouple interfaces from implementations reducing compilation
      dependencies b/w files
    * Handle class cost
        * member functions must go through the implementation ptr to get to the
          object's data
        * object size increases due to ptrs
        * need to init implementation ptr
    * Interface class cost
        * every function call is virtual
        * objects derived from Interface class must contain a virtual table
          pointer which increases object size
    * neither one can make use of inline functions (inline function definitions
      must be in header files and both approaches try to hide implementation
      as much as possible)
* things to remember
    * minimize compilation dependencies by depending on declaration instead of
      definitions (use Handle and Interface classes)
    * library header files should exist in full and declaration-only forms
      (regardless of whether templates are involved)

## Chapter 6: Inheritance and Object-Oriented Design

### Item 32: Make sure `public` inheritance models "is-a"

* `public` inheritance means "is-a"
* `class D: public B`: every D is-a B, but not vice versa
* *everything* that applies to base class obj also applies to derived class obj
* just because the code compiles doesn't mean it will work
* other inter-class relationships
    * "has-a"
    * "is-implemented-in-terms-of"
* things to remember
    * `public` inheritance means "is-a"
    * everything that applies to base classes must also apply to derived
        classes, because every derived class object *is* a base class object

### Item 33: Avoid hiding inherited names

* names in inner scopes hide ("shadow") names in outer scopes
* C++'s name-hiding rules hide *names*, the *type* of the duplicate names is immaterial
* the scope of a derived class is nested inside its base class's scope
* name hiding applies even for same function name
    * with different parameter types
    * `virtual` or non-`virtual`
* reason for name hiding: prevents you from accidentally inheriting overloads
    from distant base classes in a new derived class
* ways to override default hiding
```
class B {
public:
    virtual void mf1() = 0;
    virtual void mf1(int);
};
class D1: public B {
public:
    using Base::mf1;                    // (1) using declaration
};
class D2: private B {
public:
    virtual void mf1() { Base::mf1(); } // (2) forwarding function
};
```
* `using` *declarations*
    * makes *all* base class functions w/ a given name visible & public in derived class scope
    * not a problem for `public` inheritance
        * every D is a B
        * names that are `public` in a base class should also be `public` in a publicly derived class
    * a problem for `private` inheritance
        * if a function is *overloaded* in base class, but you want to inherit
            only 1 version
        * use forwarding function instead of `using` declaration
* things to remember
    * names in *derived* classes hide names in *base* classes. Under `public`
        inheritance, this is never desirable
    * to make hidden names visible again, employ `using` declarations or
        forwarding functions

### Item 34: Differentiate between inheritance of interface and interitance of implementation

* `public` inheritance consists of
    * inheritance of function interfaces: function *declarations*
    * inheritance of function implementations: function *definitions*
* how to inherit only interface (declaration) of a member function?
* member function *interfaces* are always inherited
    * because `public` inheritance means is-a
    * anything that's true of a base class must also be true of its derived
        classes
* an abstract class
    * a base class with a pure `virtual` function (`virtual void f() = 0;`)
    * clients cannot create instances of abstract classes, only of classes
        derived from it
* `virtual` functions
    * *must* be redeclared by any concerte class that inherits them
    * have no *definition* in abstract classes
    * *pure* `virtual` functions allow derived classes to inherit a function
        *interface* only
    * *simple* `virtual` functions allow derived classes to inherit a function
        *interface* as well as a default implementation
* classic object-oriented design: 2 classes share a common feature, so the
    common feature is moved into a base class, the features is inherited by the
    2 classes
```
class Airplane {
public:
    virtual void fly() {...}   // default code for flying
};

class ModelA: public Airplane {};
class ModelB: public Airplane {};
```
* how to protect yourself from inheriting a default implementation of a base
  class function when creating new derived classes?
* (1) sever connection b/w *interface* of the `virtual` function and its
  default *implementation*
```
class Airplane {
public:
    virtual void fly() = 0;
protected:                      // don't let derived classes inherit
    void defaultFly() {...}     // default code for flying, non-virtual:
                                // no derived class should redefine
};

class ModelA: public Airplane {
public:
    virtual void fly() { defaultFly(); }
};
```
* (2) use pure `virtual` functions with a definition
    * must be redeclared in concrete derived classes
    * may have implementation of their own in *base* class
```
class Airplane {
public:                         // lost protection levels, public only
    virtual void fly() = 0;     // interface: derived classes *must* use
};
void Airplane::fly() {...}      // implementation: derived classes *may* use

class ModelA: public Airplane {
public:
    virtual void fly() { Airplane::fly(); } // call base class pure virtual def.
};
```
* a non-`virtual` function specifies an invariant over specialization: it
    identifies behavior that's not supposed to change
* control over inheritance
    * pure `virtual`: interface only
    * simple `virtual`: interface and *default* implementation
    * non-`virtual`: interface and a *mandatory* implementation
* mistakes
    * declaring all functions non-`virtual`: no room for specialization in
        derived classes
    * declaring *all* member functions `virtual`: too much flexibility, some
        functions should *not* be redefinable in derived classes
* things to remember
    * inheritance of interfaces is different from inheritance of implementation
    * under `public` inheritance, derived classes always inherit base class
      interfaces
    * pure `virtual` functions specify inheritance of interface only
    * simple (impure) `virtual` functions specify inheritance of interface plus
        inheritance of a default implementation
    * non-`virtual` functions specify inheritance of interface plus inheritance
        of mandatory implementation

### Item 35: Consider alternatives to `virtual` functions

* things to remember
    * alternatives to `virtual` functions include NVI (non-`virtual` interface)
        idiom and various forms of the Strategy design pattern; the NVI idiom is
        itself an example of the Template Method design pattern
    * a disadvantage of moving functionality from a member function to a
        function outside the class is that the non-member function lacks access
        to the class's non-public members
    * `tr1::function` objects act like generalized function pointers; such
        objects support all callable entities compatible with a given target
        signature

### Item 36: Never redefine an inherited non-`virtual` function


* things to remember
    * never redefine an inherited non-`virtual` function

### Item 37: Never redefine a function's inherited default parameter value

* things to remember
    * never redefine an inherited fault parameter value, because default
        parameter values are *statically* bound, while `virtual` functions--the
        only functions you should be redefining--are *dynamically* bound

### Item 38: Model "has-a" or "is-implemented-in-terms-of" through composition

* *composition* is the relationship b/w types that arises when objects of one
    type contain objects of another type
* *has-a* example: a `Person` has a `PhoneNumber`
* *is-implemented-in-terms-of* example: a `set` is implemented in terms of a
    `list`
* things to remember
    * composition has meanings completely different from that of `public`
        inheritance (*is-a*)
    * in the application domain, composition means *has-a*
    * in the implementation domain, it means *is-implemented-in-terms-of*

### Item 39: Use `private` inheritance judiciously

* things to remember
    * `private` inheritance means *is-implemented-in-terms-of*
    * it's usually inferior to composition, but it makes sense when a derived
      class needs access to `protected` base class members or needs to redefine
      inherited `virtual` functions
    * unlike composition, `private` inheritance can enable the empty base
      optimization
    * this can be important for library developers who strive to minimize object
      sizes

### Item 40: Use *multiple* inheritance judiciously

* things to remember
    * multiple inheritance is more complex than single inheritance; it can lead
        to new ambiguity issues and to the need for `virtual` inhertiance
    * `virtual` inheritance imposes costs in size, speed, and complexity of
      initialization and assignment
    * it's most practical when `virtual` base classes have no data
    * multiple inheritance does have legitimate uses
    * one scenario involves combining `public` inheritance from an Interface
      class with `private` inheritance from a class that helps with
      implementation
