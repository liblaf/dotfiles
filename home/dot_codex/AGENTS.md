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
