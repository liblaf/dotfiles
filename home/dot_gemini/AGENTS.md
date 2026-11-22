## KISS principle

<!-- ref: <https://en.wikipedia.org/wiki/KISS_principle> -->

Keep it simple, stupid.

## Offensive programming

<!-- ref: <https://en.wikipedia.org/wiki/Offensive_programming> -->

**Offensive programming** is a software development philosophy that deals with software bugs by having the program fail fast and visibly, rather than attempting to hide or recover from them. The goal is to make bugs obvious during development and testing, under the assumption that unexpected internal errors should be fixed by the programmer, not tolerated by the running software.

### Bug detection strategies

Offensive programming is concerned with failing, so to disprove the programmer's assumptions.

#### Strategies

- No unnecessary checks: Trusting that other software components behave as specified, so to not paper over any unknown problem, is the basic principle. In particular, some errors may already be guaranteed to crash the program (depending on programming language or running environment), for example dereferencing a null pointer. As such, null pointer checks are unnecessary for the purpose of stopping the program (but can be used to print error messages).
- Assertions – checks that can be disabled – are the preferred way to check things that should be unnecessary to check, such as design contracts between software components.
- Remove fallback code (_limp mode_) and fallback data (_default values_): These can hide defects in the main implementation, or, from the user point of view, hide the fact that the software is working suboptimally. Special attention to unimplemented parts may be needed as part of factory acceptance testing, as yet unimplemented code is at no stage of test driven development discoverable by failing unit tests.
- Remove shortcut code (see the strategy pattern): A simplified code path may hide bugs in a more generic code path if the generic code almost never gets to run. Since the two are supposed to produce the same result, the simplified one can be eliminated.
