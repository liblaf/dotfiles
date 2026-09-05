## Choosing Astra, Sol, Terra, and Luna

<!-- ref: <https://learn.chatgpt.com/docs/models> -->

Choose **Astra** when a task needs the strongest capability across multiple steps and tools. **Sol** offers depth and polish, **Terra** suits everyday work, and **Luna** suits clear, repeatable tasks.

### Where each model shines

- **Astra, for the hardest end-to-end work.** Choose Astra for complete workflows across code, apps, and research that need sustained reasoning and judgment. Give it the sources, templates, constraints, and checks that define a useful result. Astra is better at asking focused questions and incorporating your guidance while keeping the original goal and constraints in view.
- **Sol, for complex, open-ended work.** Choose Sol for ambiguous, difficult, or high-value tasks that need extra analysis, judgment, or polish, such as complex code changes, deep research, or polished documents. For narrower tasks, define what done looks like to keep the work focused.
- **Terra, the pragmatic all-rounder.** Choose Terra for everyday work that needs strong reasoning and tool use when you do not need Sol's full depth. It is a natural starting point for work you previously gave GPT-5.5.
- **Luna, for clear, repeatable tasks.** Choose Luna for specific, high-volume tasks when you know what a good result looks like, such as extraction, classification, transformation, and structured summaries.

### Pick a reasoning effort

Use the lowest reasoning effort that produces the result you need. Increase it for tasks that need more planning, analysis, or checking.

- **Light** in the ChatGPT desktop app, ChatGPT Work on the web, and IDE extension, or **Low** in the CLI, suits quick, well-scoped tasks.
- **Medium** balances speed and depth for tasks that need more planning.
- **High** and **Extra High** suit difficult work with multiple steps, sources, or tradeoffs.

### Know when to use Max or Ultra

**Max** gives the selected model more time to reason about a single task. Use it for the hardest problems, when depth matters more than speed or usage.

**Ultra** uses subagents to handle separate parts of a complex task in parallel. Choose it when you can divide the work into meaningful parts. Most tasks do not need Max or Ultra.

## Principles

### KISS principle

<!-- ref: <https://en.wikipedia.org/wiki/KISS_principle> -->

Keep is simple, stupid.

### Offensive programming

<!-- ref: <https://en.wikipedia.org/wiki/Offensive_programming> -->

Offensive programming is a software development philosophy that deals with software bugs by having the program fail fast and visibly, rather than attempting to hide or recover from them. The goal is to make bugs obvious during development and testing, under the assumption that unexpected internal errors should be fixed by the programmer, not tolerated by the running software.

Offensive programming is concerned with failing, so to disprove the programmer's assumptions. Producing an error message may be a secondary goal.

- No unnecessary checks: Trusting that other software components behave as specified, so to not paper over any unknown problem, is the basic principle.
- Assertions – checks that can be disabled – are the preferred way to check things that should be unnecessary to check, such as design contracts between software components.
- Remove fallback code (*limp mode*) and fallback data (*default values*): These can hide defects in the main implementation, or, from the user point of view, hide the fact that the software is working suboptimally. Special attention to unimplemented parts may be needed as part of factory acceptance testing, as yet unimplemented code is at no stage of test driven development discoverable by failing unit tests.
