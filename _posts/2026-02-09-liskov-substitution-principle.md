---
title: Liskov Substitution Principle (LSP) in Python (with the classic Square/Rectangle trap)
description: I was serving as a TA teaching OOP in python and I came across this topic.
date: 2026-02-09
author: Zhenduo
categories: [Programming, Object-Oriented Programming]
tags: [Object-Oriented Programming, Inheritance, Polymorphism]
published: true
---

## What LSP says

The **Liskov Substitution Principle** is one of the SOLID principles. In plain terms:

> If `S` is a subtype of `T`, then anywhere your code expects a `T`, you should be able to use an `S` **without breaking behavior**.

It’s not just about “is-a” relationships. It’s about **behavioral compatibility**.

A good mental checklist:

* A subclass should **honor the contract** of its parent.
* A subclass should not **require more** than the parent required (**no stronger preconditions**).
* A subclass should not **guarantee less** than the parent guaranteed (**no weaker postconditions**).
* If swapping a base class instance for a derived class instance causes surprises, special cases, or broken assumptions — you likely violated LSP.


### The counterexample: “Square is a Rectangle”… until you implement it

Mathematically, a square *is* a rectangle (a special rectangle with equal sides).
But in real-world OOP design, that relationship often **breaks substitutability**.

#### A typical `Rectangle` contract

Most rectangle APIs imply (explicitly or implicitly) that:

* **Width and height can change independently**
* Setting width does **not** change height
* Setting height does **not** change width

That’s a behavioral contract many pieces of code silently rely on.

#### But a `Square` must maintain an invariant

A square’s defining rule is:

* `width == height` always

So if you implement `Square` as a subclass of `Rectangle`, you’re forced to “override” behavior in a way that violates the rectangle contract.


### How LSP breaks in practice (thought experiment)

Imagine code that works with *any* rectangle:

* Set width to `5`
* Set height to `10`
* Expect area = `50`

This makes perfect sense for a rectangle because width and height are independent.

But if you pass a `Square` object (subclass of `Rectangle`) into that same code, the square has a problem:

* If you set width to `5`, it *must* also set height to `5`
* If you later set height to `10`, it *must* also set width to `10`

Now the final area becomes:

* `100` (10×10) **or**
* `25` (5×5)

…depending on implementation order — but in any case, **not 50**.

So code that was correct for `Rectangle` now behaves differently for `Square`.

That’s exactly what LSP warns about.


### The takeaway

The point is not that squares and rectangles are unrelated — it’s that **inheritance must preserve expected behavior**.

**Subtyping should model substitutability, not just taxonomy.**

Better designs:

* Prefer a shared abstraction like `Shape` with `area()` (and maybe `perimeter()`), and keep `Rectangle` and `Square` as separate implementations.
* Or use composition/immutable objects if you want to preserve invariants cleanly.
* If you keep mutating setters (`set_width`, `set_height`), be careful: they define a contract that a square can’t honestly satisfy.

## Contravariance in subclasses (method parameters)

When we talk about **contravariance** in OOP/subclassing, we’re usually talking about how **method parameter types** behave under inheritance.

### The LSP-friendly rule

To keep substitutability (Liskov Substitution Principle):

* **Parameters are contravariant**: an override may accept **broader / more general** input types.
* **Returns are covariant**: an override may return **narrower / more specific** output types.

### Why parameters should be contravariant

If the base class promises: “I can handle `T`”, then any subclass must handle **at least** `T`.
So a subclass must **not** override the method to accept *less* than the base class accepted.

#### Safe vs unsafe overrides

If `Base.f(x: T)` exists, then:

* `Sub.f(x: SuperOfT)` ✅ OK (accepts *more* kinds of inputs)
* `Sub.f(x: SubOfT)` ❌ risky (accepts *fewer* kinds of inputs)

### Mini example

```python
class Animal: ...
class Dog(Animal): ...

class Base:
    def handle(self, x: Dog) -> None:
        print("handling a dog")

class SubOK(Base):
    # accepts a wider type -> contravariant parameter
    def handle(self, x: Animal) -> None:
        print("handling an animal")
```

### How this appears in Python typing

Python doesn’t enforce variance at runtime, but type checkers do. A common place you’ll see contravariance is with callables:

* `Callable[[Arg], Return]` is **contravariant** in `Arg`
* and **covariant** in `Return`

```python
from typing import Callable

class Animal: ...
class Dog(Animal): ...

def takes_animal(a: Animal) -> None: ...
def takes_dog(d: Dog) -> None: ...

f: Callable[[Dog], None] = takes_animal  # OK (contravariant args)
# g: Callable[[Animal], None] = takes_dog  # Not OK
```

## Some real-world cases PyTorch’s `nn.Module` “mypy contravariance” hack (why `forward` is an attribute)

In `torch.nn.modules.module.py`, PyTorch contains an explicit comment explaining a small trick used to keep mypy happy when users override `forward` with their own (often narrower) signatures:

```python
# Trick mypy into not applying contravariance rules to inputs by defining
# forward as a value, rather than a function.  See also
# https://github.com/python/mypy/issues/8795
```

See the documentation ([Alband][1])

Right after that, PyTorch sets up an “unimplemented” method and then **assigns it to `forward` as a typed attribute**:

```python
def _forward_unimplemented(self, *input: Any) -> None:
    raise NotImplementedError

forward: Callable[..., Any] = _forward_unimplemented
```



### What problem this avoids

If `forward` were declared as a normal method on `Module` with a very generic signature (like `(*args: Any) -> Any`), mypy would treat it as a strict override contract. Then a subclass doing the normal PyTorch thing:

```python
def forward(self, x: Tensor) -> Tensor:
    ...
```

can trigger override-compatibility checks (the “parameter types must be contravariant” rule you asked about): the base effectively accepts “anything”, while the override accepts only a `Tensor`.

### Why the attribute assignment helps

By defining `forward` as a **data attribute** typed as `Callable[..., Any]`, PyTorch makes mypy treat it more like “some callable slot” than a conventional method whose signature must be preserved across overrides.

Effectively, PyTorch is saying:

* “`Module.forward` is a callable of unknown/variadic signature (`...`)”
* so user modules are free to define `forward(self, x: Tensor, ...)` with the signature that matches their model, without mypy complaining about incompatible overrides.

That’s why this is tightly connected to contravariance: it’s a deliberate escape hatch around mypy’s usual method-override variance rules, to match how PyTorch is actually used in practice.

[1]: https://alband.github.io/doc_view/_modules/torch/nn/modules/module.html "torch.nn.modules.module — PyTorch master documentation"
