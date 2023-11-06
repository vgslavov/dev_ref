# Effective Modern C++

Excerpts from Scott Meyer's `Effective Modern C++`.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Terminology](#terminology)
- [Chapter 1: Deducing Types](#chapter-1-deducing-types)
  - [Item 1: Understand template type deduction](#item-1-understand-template-type-deduction)
  - [Item 2: Understand `auto` type deduction](#item-2-understand-auto-type-deduction)
  - [Item 3: Understand `decltype`](#item-3-understand-decltype)
  - [Item 4: Know how to view deduced types](#item-4-know-how-to-view-deduced-types)
- [Chapter 2: `auto`](#chapter-2-auto)
  - [Item 5: Prefer `auto` to explicit type declarations](#item-5-prefer-auto-to-explicit-type-declarations)
  - [Item 6: Use the explicitly typed initializer idiom when `auto` deduces undesired types](#item-6-use-the-explicitly-typed-initializer-idiom-when-auto-deduces-undesired-types)
- [Chapter 3: Moving to Modern C++](#chapter-3-moving-to-modern-c)
  - [Item 7: Distinguish between `()` and `{}` when creating objects](#item-7-distinguish-between--and--when-creating-objects)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Terminology

* C++11's most pervasive feature: move semantics
* *rvalues*: temp. objects returned from functions
* *lvalues*: objects you can refer to, by name or by a ptr or *lvalue* ref
* an expression is an *lvalue* if you can take its address
* copies of *rvalues* are *move* constructed
* copies of *lvalues* are *copy* constructed
* function *arguments*: the expressions passed in a function call
    * arguments may be *rvalues* or *lvalues*
* function *parameters*: expressions in the function definition, initialized by
    function *arguments*
    * all parameters are *lvalues*
* *function object*: an object that acts like a function
* *closures*: function objects created through lambda expressions
* *declarations*: introduce names & types w/o details (e.g. storage,
    implementation)
* *definitions*: provide the storage locations or implementation details
* a *definition* also qualifies as a *declaration*
* function's *signature* is the part of the declaration specifying parameter &
    return types

## Chapter 1: Deducing Types

```
template<typename T>        // function declaration
void f(ParamType param);

f(expr);                    // function call
```

### Item 1: Understand template type deduction

* Case 1: `ParamType` is a Reference or Pointer, but not a Universal Reference
    * reference: `T&`
    * const ref: `const T&`
    * pointer: `T*`
* Case 2: `ParamType` is a Universal Reference: `T&&`
* Case 3: `ParamType` is Neither a Pointer nor a Reference: `T`
* Array Arguments
    * an array *decays* into a pointer to its first element
* Function Arguments
    * function types can decay into function pointers
* THINGS TO REMEMBER: TODO

### Item 2: Understand `auto` type deduction

* `auto` type deduction *is* template type deduction (w/ one exception)
    * `auto` plays the role of `T` in the template
    * the type specifier for the variable acts as `ParamType`
        * `auto x = 27;`: type specifier is `auto`
        * `const auto& rx = x;`: type specifier is `const auto&`
* four syntaxes
```
auto x1 = 27;       // type is int, value is 27
auto x2(27);        // same
auto x3 = { 27 };   // type is std::initializer_list<int>
                    // value is { 27 }
auto x4{ 27 };      // same
```
* if you declare a var using `auto`
* and you initialize it with braced initializer
* the deduced type is always `std::initializer_list`
* `auto` in a function return type or a lambda parameter implies template type
    deduction, not `auto` type deduction
* THINGS TO REMEMBER: TODO

### Item 3: Understand `decltype`

* `decltype`: given a name or expression, return its type
* type returned by a container's `operator[]` depends on the container
* a trailing return type can use a function's parameters in the return type
    ```
    // C++11
    template<typename Container, typename, Index>
    auto f(Container& c, Index i) -> decltype(c[i]) { return c[i]; }
    // C++14: better
    template<typename Container, typename, Index>
    decltype(auto) f(Container& c, Index i) { return c[i]; }
    // C++14: best
    template<typename Container, typename, Index>
    decltype(auto) f(Container&& c, Index i) { return c[i]; }
    ```
    * `auto` specifies the type to be deduced
    * `decltype` applies `decltype` rules during the deduction
* the return value of a function is an *rvalue*
* not limited to function return types
```
Widget w;
const Widget& cw = w;
auto m1 = cw;           // auto type deduction; m1's type is Widget
decltype(auto) m2 = cw; // decltype type deduction: m2's type is const Widget&
```
* applying `decltype` to a name yields the declared type for that name
* THINGS TO REMEMBER: TODO

### Item 4: Know how to view deduced types

* name `variableName Type` to yield useful error messages: e.g. `xType`
* print `typeid` and `std::type_info::name` (caution: not reliable)
```
std:: cout << typeid(x).name() << "\n";
```

## Chapter 2: `auto`

### Item 5: Prefer `auto` to explicit type declarations

* function pointers: can only point to functions
* `std::function`
    * objects can refer to any callable object
    * bigger & slower than `auto`
* explicitly specifying types can lead to *implicit* unexpected conversions
* `auto` is an option, not a mandate
* must be initialized: `auto x2;   // error`
* example 1
```
std::vector<int> v;
// wrong: unsigned int != size_type
unsigned sz1 = v.size();
// vs
auto sz2 = v.size() // sz2 is std::vector<int>::size_type
```
* example 2
```
std::unordered_map<std::string, int> m;
// wrong: key of a map is const
for (const std::pair<std::string,int>& p : m) {}
// vs
for (const auto& p : m) {}
```
* `auto` types automatically change if the type of their initializing expression
    changes
* THINGS TO REMEMBER: TODO

### Item 6: Use the explicitly typed initializer idiom when `auto` deduces undesired types

* `std::vector<bool>::reference` & `std::bitset::reference`
    * a *proxy* class emulating & augmenting the behavior of some other type
    * *inivisible* proxy classes don't play well with `auto`
* `std::shared_ptr`: a proxy class designed to be apparent to clients
* example 1
```
std::vector<bool> features(const Widget& w);
Widget w;
bool hiPrio1 = features(w)[5];
auto hiPrio2 = features(w)[5];    // auto is not bool, it's std::vector<bool>::reference
auto hiPrio3 = static_cast<bool>(features(w)[5]);  // auto is bool
```
* example 2
```
double calcEpsilon();
float ep1 = calcEpsilon();   // implicit conversion from double to float
auto ep2 = static_cast<float>(calcEpsilon());  // announce reducing precision!
```

## Chapter 3: Moving to Modern C++

### Item 7: Distinguish between `()` and `{}` when creating objects

* initialization values may be specified with: parenthesis, equals sign or braces
```
int x(0);
int y = 0;
int z{ 0 };
int t = { 0 };
```
* user-defined types: distinguish b/w initialization & assignment
```
Widget w1;      // default ctor
Widget w2 = w1; // copy ctor
w1 = w2;        // copy operator=
```
* C++11: *uniform initialization* (a.k.a. *braced initialization*)
```
std::vector<int> v{ 1, 3, 5 };
```
* *most vexing parse*: want to default ctor, but end up declaring a function
```
Widget w1(10);     // call Widget ctor w/ arg 10
Widget w2();       // a function that returns a Widget
Widget w3{};       // call Widget ctor w/o args
```
* benefits of braced initialization
    * can be used in widest variety of contexts
    * prevents implicit narrowing conversions
    * immune to *most vexing parse*
* disadvantage: surprising behavior due to `std::initializer_list`
