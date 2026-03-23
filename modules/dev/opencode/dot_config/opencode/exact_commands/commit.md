---
description: Generate a high-quality conventional commit message from current changes
agent: commit
subtask: true
---

<task>
Generate a single polished Conventional Commit message for the current repository state.
</task>

<user_hints>
$ARGUMENTS
</user_hints>

<instructions>
Treat user hints as guidance, not ground truth. If they conflict with the actual diff, follow the diff.

Use the staged change set when anything is staged. Fall back to unstaged plus untracked changes only when nothing is staged.
</instructions>

<repository_context>
<repository_root>
!`git rev-parse --show-toplevel`
</repository_root>

<current_branch>
!`git branch --show-current`
</current_branch>

<git_status>
!`git status --short --branch --untracked-files=all`
</git_status>

<untracked_files>
!`git ls-files --others --exclude-standard`
</untracked_files>

<staged_diff_summary>
!`git diff --cached --no-color --stat --summary --find-renames --find-copies`
</staged_diff_summary>

<staged_diff>
!`git diff --cached --no-color --no-ext-diff --unified=3 | sed -n '1,320p'`
</staged_diff>

<unstaged_diff_summary>
!`git diff --no-color --stat --summary --find-renames --find-copies`
</unstaged_diff_summary>

<unstaged_diff>
!`git diff --no-color --no-ext-diff --unified=3 2>/dev/null | sed -n '1,320p'`
</unstaged_diff>
</repository_context>

If the available diff looks truncated or ambiguous, inspect the relevant files or use the configured `git_*` / `repomix_*` tools before finalizing.

Return only the final commit message.
