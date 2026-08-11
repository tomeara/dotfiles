---
name: handoff
description: >
  Manages short-lived, task-scoped working state so any AI tool or platform can
  pick up exactly where another left off. Always trigger on the /handoff command
  regardless of what follows — if the subcommand is missing, prompt to clarify.
  Also trigger proactively (without being asked) before ending a conversation,
  before a context-heavy operation, or when approaching context limits.
compatibility: claude-chat, claude-code, claude-cowork, copilot, codex, opencode
metadata:
  storage: ~/.agents/context/sessions/
  argument-hint: "save|load|list|archive [task-slug]"
---

# Session Handoff

Session files provide continuity across conversations and platforms. They live in
`~/.agents/context/sessions/` and are structured as **handoff documents** — assume
the reader has zero conversation history.

---

## Storage

```
~/.agents/context/sessions/
  active/
    {task-slug}.md      ← one file per in-flight task
  archive/
    {task-slug}.md      ← completed sessions moved here
```

The slug is short kebab-case derived from the task (e.g. `checkout-flow-redesign`,
`home-lab-server`). If not provided, infer from context or ask.

---

## Commands

### `/handoff save [task-slug]`

1. Infer or confirm the slug. Check `sessions/active/` for an existing file.
2. If **new**: populate the full template below and confirm with the user before writing.
3. If **updating**: keep header sections (Objective through Open Questions) current;
   append a new `## Log` entry. **Never edit or delete prior log entries.**
4. Write to `~/.agents/context/sessions/active/{slug}.md`.
5. Confirm with the path written.

**Proactive saves** (no user prompt needed): after completing a subtask, before a
context-heavy operation, when switching topics, before ending a conversation, when
approaching context limits.

---

### `/handoff load [task-slug]`

1. If no slug given, run list (see below) and let the user pick.
2. Read the full file for the selected session.
3. Summarize what was loaded: objective, current state, and the first next step.
4. Ask: "Anything changed since this was saved that I should know?"

---

### `/handoff list`

Read **only the YAML frontmatter** from each file in `sessions/active/`. Do not
load bodies. Present as a compact table:

```
#  Slug                    Project          Last Updated          Status   Summary
1  checkout-flow-redesign  webapp           2026-04-02T14:30Z     active   Mid-sprint on checkout flow. Waiting on API spec…
2  home-lab-server         homelab          2026-03-28T09:00Z     active   Hardware path decision pending budget…
```

To read frontmatter without loading bodies:

```bash
for f in ~/.agents/context/sessions/active/*.md; do
  echo "=== $(basename $f) ==="
  awk '/^---/{n++} n==1' "$f"
  echo ""
done
```

---

### `/handoff archive [task-slug]`

1. Before archiving, check `## Open Questions` — surface any that should become
   memory entries and offer to run `/recall save` for them.
2. Move the file from `sessions/active/` to `sessions/archive/`.
3. Confirm. Session files are scratchpads — archive when the task is fully complete.

---

## Session file template

```markdown
---
project: {project-name}
task: {task-slug}
started: {YYYY-MM-DD}
last-updated: {YYYY-MM-DDThh:mmZ}
last-platform: {claude-chat|claude-code|claude-cowork|copilot|codex|opencode}
status: active
summary: >
  {One sentence suitable for /handoff list — what this task is doing right now.}
---

# Session: {task-slug}

## Objective
One sentence: what is this task trying to accomplish.

## Current State
What has been done. Decisions made and why. What is in flight.

## Next Steps
1. ...
2. ...

## Key Context
- Relevant file paths
- External IDs (Jira, Confluence, etc.)
- Gotchas discovered mid-task

## Open Questions
Anything unresolved that the next agent/platform needs to surface.

## Log
<!-- Append entries below. Never edit or delete prior entries. -->
<!-- Format: ### [{YYYY-MM-DDThh:mmZ}] {platform} | {type} -->
```

### Log entry types

| Type | When to use |
|---|---|
| `status` | Progress update |
| `decision` | A choice made and the reasoning |
| `open-question` | Unresolved follow-up |
| `blocker` | Something preventing progress |
| `finding` | Discovery relevant to the task |
| `handoff` | End-of-turn summary for the next agent/platform |

---

## Platform notes

See `references/platform-notes.md` for per-platform file I/O details and fallback
behavior when direct filesystem access isn't available.

---

## Rules

- Header sections (Objective → Open Questions) stay **current** — rewrite them on each save
- Log is **append-only** — never edit or delete prior entries
- Include the task slug in every handoff so the receiving agent knows which file to load
- The `summary` frontmatter field is what `/handoff list` shows — keep it one sentence
- Session files are scratchpads, not permanent records — archive when done
