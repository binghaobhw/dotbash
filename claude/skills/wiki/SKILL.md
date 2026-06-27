---
name: wiki
description: Manage the personal knowledge base (Wiki) — ingest documents, answer questions from it, and run health checks. Use when the user wants to add notes/documents to their wiki, query their knowledge base, or maintain it. The wiki lives at $WIKI_ROOT.
argument-hint: "[ingest <file> | query <question> | lint]"
---

# Wiki knowledge base manager

This skill operates on a personal knowledge base whose location is given by the
`$WIKI_ROOT` environment variable. All rules (page schema, naming, cross-link
conventions, and the Ingest / Query / Lint protocols) are defined authoritatively
in `$WIKI_ROOT/wiki/CLAUDE.md` — that file is the source of truth, this skill only
routes to it.

## Step 0 — Resolve the wiki root (always do this first)

```bash
echo "${WIKI_ROOT:?WIKI_ROOT is not set. Add 'export WIKI_ROOT=/path/to/Wiki' to your shell rc.}"
```

If `$WIKI_ROOT` is empty, stop and tell the user to set it. Otherwise read these
two files before doing anything else:

- `$WIKI_ROOT/wiki/CLAUDE.md` — the schema and protocols you must follow
- `$WIKI_ROOT/wiki/index.md` — the current page index

## Step 1 — Dispatch on the argument

The user's argument is in `$ARGUMENTS`. Match the first word:

- **`ingest <file>`** — Follow the **Ingest 协议** in `wiki/CLAUDE.md` for the given
  file. If no file is given, default to processing everything in `$WIKI_ROOT/inbox/`
  (skipping `inbox/processed/`). After a file is successfully ingested, move it to
  `$WIKI_ROOT/inbox/processed/`.

- **`query <question>`** — Follow the **Query 协议**: find relevant pages via
  `index.md`, read them, answer with citations to the page names, and if a valuable
  new connection emerges, create/update a page per the schema.

- **`lint`** — Follow the **Lint 协议**: find orphan pages, contradictions, missing
  index entries, and excess stubs, then fix them.

- **no argument / anything else** — Briefly show the three usage forms above and ask
  what the user wants to do.

## Rules

- Never invent the schema from memory — always re-read `wiki/CLAUDE.md`, it may have
  changed.
- Use absolute paths built from `$WIKI_ROOT`; do not hardcode the wiki location.
- Every Ingest / Query / Lint action must append a record to `$WIKI_ROOT/wiki/log.md`
  in the format that file's section of `wiki/CLAUDE.md` specifies.
- Respect the page format template and the "每个页面至少 2-3 个 [[链接]]" rule.
