---
name: commit
description: >
  Authors git commits and commit messages in a consistent, machine-parseable
  format that gives future readers — human or AI — the context the diff alone
  cannot provide. Always trigger on the /commit command. Also trigger
  proactively whenever authoring a git commit as part of any task, on any
  platform.
compatibility: claude-chat, claude-code, claude-cowork, copilot, codex, opencode
metadata:
  argument-hint: "[optional ticket or scope]"
---

# Git Commits

Commit messages follow the [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
spec, extended with a Jira key in the subject, `What:`/`Why:` body sections, and
git trailers. The diff already shows *what changed line-by-line* — the message
exists to record what the diff cannot: intent, decisions, and rejected
alternatives.

---

## Template

```
<type>(<scope>)<!>: <JIRA-KEY> <imperative summary>

What:
- <High-level summary of the change — behavior, not line-by-line diff>
- <One bullet per meaningful aspect>

Why:
- <The problem or goal that motivated this change>
- <Alternatives considered and rejected, and why>

BREAKING CHANGE: <description, only if applicable>
Jira: <ADDITIONAL-KEY, only if the commit touches more than one ticket>
Refs: <path, URL, or ADR — one trailer line per reference>
```

Example:

```
feat(checkout)!: PROJ-1204 reject duplicate payment submissions

What:
- Idempotency check at the API boundary, keyed on a
  client-generated request ID
- Duplicate submissions return the original charge's receipt

Why:
- Double-clicks were creating duplicate charges
- Client-side-only button disable was rejected — doesn't
  cover retries from flaky connections

BREAKING CHANGE: /payments now requires X-Request-Id header
Jira: PROJ-1205
Refs: docs/adr/0007-payment-idempotency.md
Refs: https://github.com/org/repo/issues/42
```

---

## Subject line

- Format: `<type>(<scope>): <JIRA-KEY> <summary>` — the Jira key comes first in
  the description so it survives one-line log output. Omit the key only if no
  ticket genuinely exists.
- **Imperative mood** ("reject", not "rejected"/"rejects"), no trailing period,
  ≤ 72 characters.
- **Scope** is the area of the codebase (`checkout`, `ingest`, `auth`) — short,
  lowercase, stable across commits. Omit if the change is truly global.
- Append `!` after the type/scope for breaking changes (and include the
  `BREAKING CHANGE:` footer).

### Types

| Type | Use for |
|---|---|
| `feat` | New user-facing behavior |
| `fix` | Bug fix |
| `refactor` | Code change with no behavior change |
| `perf` | Performance improvement |
| `test` | Adding or correcting tests only |
| `docs` | Documentation only |
| `build` | Build system, dependencies, tooling |
| `ci` | CI configuration |
| `chore` | Maintenance that fits nothing above |
| `revert` | Reverting a prior commit — reference it in the body |

---

## Body

- Two labeled sections, in this order: `What:` then `Why:`. Use plain `What:` /
  `Why:` label lines with hyphen bullets — **never `#` markdown headings**,
  which git strips as comments during interactive editing.
- Wrap body lines at 72 characters.
- **What** is a behavior-level summary, not a restatement of the diff. If a
  bullet could be mechanically derived from reading the patch, cut it.
- **Why** is the highest-value section for future readers. Record the
  motivating problem or goal, and any alternative that was considered and
  rejected — this prevents the decision being re-litigated later.
- A trivial commit (typo fix, version bump) may omit the body entirely; the
  subject must then be fully self-explanatory.

---

## Trailers

Trailers are git-native `Key: value` lines in the final block of the message —
machine-readable via `git interpret-trailers` and
`git log --format='%(trailers:key=Refs,valueonly)'`.

- **Repeat the key for multiple values** — one line per value:

  ```
  Refs: docs/adr/0007-payment-idempotency.md
  Refs: https://github.com/org/repo/issues/42
  ```

- `Jira:` — additional ticket keys beyond the one in the subject.
- `Refs:` — file paths, ADRs, issue/PR URLs, design docs.
- `BREAKING CHANGE:` — required by the spec when behavior breaks; pairs with
  `!` in the subject.
- `Co-Authored-By:` — when applicable (e.g. AI-assisted commits, pairing).

---

## Workflow

1. **Review what is staged** (`git status`, `git diff --cached`) before
   drafting. Never describe changes you have not read.
2. **One logical change per commit.** If the staged diff mixes concerns
   (e.g. a refactor plus a feature), propose splitting it into separate
   commits rather than writing one message that covers both.
3. Draft the full message from the template and show it to the user before
   committing, unless they have already asked you to commit autonomously.
4. Never weaken the message to avoid explaining — if you can't articulate the
   Why, that's a signal to ask, not to skip the section.

---

## Reading history (for agents)

Past commits in this format are queryable context — prefer them over guessing
at intent:

```bash
git log --oneline --grep='PROJ-1204'            # all commits for a ticket
git log --format='%h %(trailers:key=Refs,valueonly,separator=%x2C)' -5
git show <sha> --no-patch                        # full What/Why for a commit
```
