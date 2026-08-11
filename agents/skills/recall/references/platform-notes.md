# Platform Notes — Session & Memory

Shared reference for both `handoff` and `recall` skills.
Documents per-platform file I/O behavior and fallback patterns.

---

## Claude Code / opencode / Codex CLI

**Bash:** Full access on the user's local machine.
**Paths:** `~` expands correctly. Read/write directly.

```bash
# List session frontmatter
for f in ~/.agents/context/sessions/active/*.md; do
  echo "=== $(basename $f) ===" && awk '/^---/{n++} n==1' "$f" && echo ""
done

# List memory frontmatter
for f in ~/.agents/context/memory/*.md; do
  echo "=== $(basename $f) ===" && awk '/^---/{n++} n==1' "$f" && echo ""
done
```

---

## Claude Cowork

**Bash:** Available via bash tool, runs on user's machine.
**Behavior:** Same as Claude Code — direct read/write works.

---

## Claude Chat (claude.ai)

**Bash:** Available via `bash_tool`, but runs in an **isolated sandbox** — files
written there do not persist to `~/.agents/` on the user's machine.

**Try filesystem tools first.** Before falling back, attempt to use the MCP
filesystem tool to access `~/.agents/context/` directly — it operates on the
user's actual machine, not the sandbox:

```
Filesystem:list_directory  ~/.agents/context/sessions/active/
Filesystem:read_multiple_files  [paths to selected files]
Filesystem:write_file  ~/.agents/context/sessions/active/{slug}.md
```

If the filesystem tool is available and `~/.agents/context/` is within its allowed
directories, use it for all reads and writes. No fallback needed.

**Save fallback** (if filesystem tool unavailable): Emit the complete file as a
fenced code block with a path comment. The user writes it locally.

````
```markdown
<!-- Save to: ~/.agents/context/sessions/active/checkout-flow-redesign.md -->
---
project: webapp
task: checkout-flow-redesign
...
```
````

**Load fallback:** Ask the user to paste the file contents into the chat.

**List fallback:** Give the user a ready-to-run terminal command:

```bash
# Sessions
for f in ~/.agents/context/sessions/active/*.md; do
  echo "=== $(basename $f) ===" && awk '/^---/{n++} n==1' "$f" && echo ""
done

# Memory
for f in ~/.agents/context/memory/*.md; do
  echo "=== $(basename $f) ===" && awk '/^---/{n++} n==1' "$f" && echo ""
done
```

---

## GitHub Copilot (VS Code / JetBrains)

**Bash:** Available via integrated terminal if enabled; otherwise not.
**Save:** Emit labeled code block for manual save, or use `#file:` workspace reference.
**Load:** User adds file as workspace reference (`@workspace`) or pastes frontmatter.
**List:** Provide bash snippet for user to run in integrated terminal.

---

## General fallback (any platform without direct file access)

**Save:** Produce the complete file as a fenced code block with a `<!-- Save to: path -->`
comment header. Instruct the user to write it.

**Load:** Ask the user to paste either the full file, or just the frontmatter if they
only need to pick which session/memory to work with.

**List:** Provide the bash one-liner from the Claude Code section for the user to run
and paste back.

---

## Directory bootstrap

If `~/.agents/context/` doesn't exist yet, create it before the first write:

```bash
mkdir -p ~/.agents/context/sessions/active
mkdir -p ~/.agents/context/sessions/archive
mkdir -p ~/.agents/context/memory
```
