# Semantics MBRE-3

This [test](.) is exercising the case [3](../Readme.md) of the semantics rule [MBRE](../../mbre/Readme.md).

### Description

In this test, the source of the assignment is a call to a once function declared with an expanded type and attached to an object with copy semantics. The effect the assignment is the one of cloning this object and attaching it to the target (a local variable declared with a reference type). This test satisfies `MBRE-3`.

### Notes

* Gobo Eiffel (as of 20.05.31.5 and after) does not fully implement copy semantics. This violates `MBRE-3`.