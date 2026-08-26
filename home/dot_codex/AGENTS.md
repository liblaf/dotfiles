## Choosing models and reasoning

Different agents need different model and reasoning settings.

Every `spawn_agent` you issue --- including when you are yourself a spawned child running a fan-out --- sets `model` AND `reasoning_effort` explicitly. Setting `model` alone is a trap: the child's effort silently resets to that model's default, not to yours.

### Model choice

- `gpt-5.6-sol`: Start here for demanding agents. It's strongest for ambiguous, multi-step work that needs planning, tool use, validation, and follow-through across a larger context.
- `gpt-5.6-terra`: Use for agents that favor speed and efficiency over depth, such as exploration, read-heavy scans, large-file review, or processing supporting documents. It works well for parallel workers that return distilled results to the main agent.
- `gpt-5.6-luna`: Use for fast, narrowly scoped agents handling clear, repeatable, or high-volume work.

### Reasoning effort (`model_reasoning_effort`)

- `ultra`: Use for the deepest reasoning when the selected model supports it.
- `max` and `xhigh`: Use for especially demanding reasoning when the selected model supports these levels.
- `high`: Use when an agent needs to trace complex logic, check assumptions, or work through edge cases (for example, reviewer or security-focused agents).
- `medium`: A balanced default for most agents.
- `low`: Use when the task is straightforward and speed matters most.

## Design principles

### KISS principle

<!-- ref: <https://en.wikipedia.org/wiki/KISS_principle> -->

Simplicity should be a design goal.

- The core idea is to keep things as simple as possible while still achieving the desired functionality or outcome.
- This principle suggests that simpler solutions are typically easier to understand, implement, maintain, and use.

### Offensive programming

<!-- ref: <https://en.wikipedia.org/wiki/Offensive_programming> -->

Offensive programming is a software development philosophy that deals with software bugs by having the program fail fast and visibly, rather than attempting to hide or recover from them. The goal is to make bugs obvious during development and testing, under the assumption that unexpected internal errors should be fixed by the programmer, not tolerated by the running software.

Offensive programming is concerned with failing, so to disprove the programmer's assumptions. Producing an error message may be a secondary goal.

- No unnecessary checks: Trusting that other software components behave as specified, so to not paper over any unknown problem, is the basic principle.
- Assertions – checks that can be disabled – are the preferred way to check things that should be unnecessary to check, such as design contracts between software components.
- Remove fallback code (*limp mode*) and fallback data (*default values*): These can hide defects in the main implementation, or, from the user point of view, hide the fact that the software is working suboptimally. Special attention to unimplemented parts may be needed as part of factory acceptance testing, as yet unimplemented code is at no stage of test driven development discoverable by failing unit tests.
