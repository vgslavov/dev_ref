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
