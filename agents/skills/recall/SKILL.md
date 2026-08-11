---
name: recall
description: >
  Manages durable, identity-scoped knowledge — preferences, standing decisions,
  hard-won lessons, domain patterns — that persists across sessions, projects,
  and platforms. Unlike sessions (task-scoped scratchpads), memory entries are
  updated intentionally and meant to endure. Always trigger on the /recall
  command regardless of what follows — if the subcommand is missing,
  prompt to clarify. Also suggest /recall save proactively when the user shares
  a standing preference, recurring pattern, or hard-won lesson that would be
  worth preserving across sessions.
compatibility: claude-chat, claude-code, claude-cowork, copilot, codex, opencode
metadata:
  storage: ~/.agents/context/memory/
  argument-hint: "save|load|list [slug-or-topic]"
---

# Long-Term Memory

Memory entries are **durable and identity-scoped**. They answer: *"What do I always
need to know about this person, project, or domain?"*

Unlike sessions (which capture transient working state), memory files hold things
that remain true across many sessions — preferences, constraints, recurring decisions,
domain knowledge, and lessons from failure.

---

## Storage

```
~/.agents/context/memory/
  {scope}-{slug}.md       ← one file per memory entry
```

No index file is maintained. Listing and selection use frontmatter only — scan
`~/.agents/context/memory/*.md` and read only the YAML frontmatter block from each
file. Do not load bodies until the user selects an entry.

### Scopes

| Scope | Examples |
|---|---|
| `work` | Company domain knowledge, Jira/Confluence conventions, team processes |
| `personal` | Health constraints, family context, recurring commitments |
| `prefs` | Communication style, formatting preferences, tool choices |
| `homelab` | Server hardware decisions, LLM routing, network layout |
| `project` | Standing decisions for a specific long-running project |

Example filenames: `work-company-domain.md`, `prefs-communication.md`, `homelab-server.md`

---

## Commands

### `/recall save [slug-or-topic]`

1. **Check for duplicates first.** Scan frontmatter of all files in `memory/` to see
   if a related entry exists. If yes, update it rather than creating a new file.
2. **If new:** Propose a scope+slug, populate the template, confirm with user before writing.
3. **If updating:** Show the user what's changing. Append a changelog row. Never silently
   overwrite — always confirm the diff before writing.
4. Write to `~/.agents/context/memory/{scope}-{slug}.md`.
5. Confirm with the path written.

**What to save:**
- A decision that affects future sessions
- A pattern worth reusing
- A hard-won lesson (something that failed and shouldn't be repeated)
- A standing preference or constraint

**Do NOT save:**
- Raw conversation transcripts
- Sensitive data (credentials, PII, API keys)
- Speculative or unverified conclusions
- Things derivable from code or git history

**Proactive suggestion:** If the user shares something that sounds durable — a preference,
a recurring pattern, a domain fact they've explained before — offer:
*"Want me to save that to memory so you don't have to repeat it?"*

---

### `/recall load [slug-or-topic]`

1. Scan frontmatter of all files in `memory/` (bodies not loaded).
2. Show entries and let the user pick by number, slug, or description.
3. Load the full file(s) for selected entries.
4. Confirm what was loaded and how you'll apply it.
5. Ask: "Anything here that's out of date?"

**Bulk load by scope:** `/recall load work` — show all `work-*` entries and let the
user confirm loading all or pick individually.

---

### `/recall list`

Read **only the YAML frontmatter** from each `*.md` file in `memory/`. Do not load
bodies. Group by scope:

```
Scope: work
  #  Slug                    Updated      Summary
  1  company-domain          2026-04-02   Core domain concepts, industry standards, billing terminology…
  2  confluence-publishing   2026-03-10   Storage format rules, surgical replacement pattern, @mention syntax…

Scope: prefs
  #  Slug                    Updated      Summary
  3  communication           2026-02-01   Direct, minimal formatting, invite pushback, approach-before-execute…

Scope: homelab
  #  Slug                    Updated      Summary
  4  server-config           2026-03-28   GPU vendor decision, virtualization layout, storage pool config…
```

Filter: `/recall list work` — show only entries with `scope: work`.

To read frontmatter without loading bodies:

```bash
for f in ~/.agents/context/memory/*.md; do
  echo "=== $(basename $f) ==="
  awk '/^---/{n++} n==1' "$f"
  echo ""
done
```

---

## Memory file template

```markdown
---
title: "{Human-readable title}"
scope: {work|personal|prefs|homelab|project}
slug: {scope-descriptive-slug}
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
tags: [{tag1}, {tag2}]
summary: >
  {One sentence for /recall list — what this entry covers.}
---

## Context
Why this memory entry exists; what situation it applies to.

## Content
The durable knowledge — facts, decisions, patterns, preferences.

## Changelog
| Date | Change |
|---|---|
| {YYYY-MM-DD} | Initial entry |
```

---

## Relationship to sessions

| | Session | Memory |
|---|---|---|
| Lifespan | Hours to days | Months to indefinite |
| Scope | One task | One domain / preference / pattern |
| Volatility | Updated every working block | Updated intentionally |
| Command | `/handoff` | `/recall` |
| Content | Working state, next steps | Standing facts, preferences, lessons |

Sessions and memory complement each other. A session handoff might reference a memory
entry ("see `work-company-domain` for domain context") without duplicating its content.

---

## Platform notes

See `references/platform-notes.md` for per-platform file I/O details and fallback
behavior when direct filesystem access isn't available.

---

## Rules

- Scan frontmatter before creating — prefer updating over creating duplicates
- Updates are transparent — show diffs, append changelog rows
- One topic per file — keep entries focused
- Update or replace stale entries rather than accumulating contradictions
- The `summary` frontmatter field is what `/recall list` shows — keep it one sentence
