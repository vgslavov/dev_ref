# C++ Common Knowledge

Excerpts from Stephen Dewhurst's C++ Common Knowledge.

## Data Abstraction

* a `type` is a set of operations
* an `abstract data type` is a set of operations with an implementation
* "What can I do with this object"?
* a type should be "easy to use correctly and hard to use incorrectly"
* designing abstract data types
    * choose a descriptive name for the type
    * list the operations that the type can perform
    * design an interface for the type
    * implement the type (the implementation of most ADT will change much more
      frequently than their interfaces)

## Polymorphism

* a `polymorphic type` is a class type that has a virtual function
* a `polymorphic object` is an object with more than one type
* a `polymorphic base class` is a base class that is designed for use by
  polymorphic objects
* the most important things inherited from its base classes are their
  interfaces, not their implementations
* the base class can be ignorant of everything but itself
* a base class should have no specific knowledge of any of the classes derived
  from it
* in object-oriented design, as in life, ignorance is bliss

```
AmOption *d = new AmOption;
Option *b = d;
d->price();     // virtual, calls AmOption::price
b->price();     // will call same f.
b->update();    // non-virtual, calls Option::update
d->update();    // will call same f.
```

## Design Patterns

* patterns are about programmer to programmer communication
* describe proven, successful design techniques
* document not only the applied technique but also the reasons for its
  application
* a design pattern must
    * have an unambiguous name
    * have a description which
        * defines the problem addressed by the pattern
        * describes the problem's solution
        * describes the consequences of applying the pattern to the context

## The STL

[TODO]
