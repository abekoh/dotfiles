---
name: obsidian-report
description: Record the current session's investigation/research summary to the Obsidian vault. Invoke when the user types /obsidian-report or asks to save, record, or export the session summary to Obsidian. Creates a report note in _reports/YYYY/MM/ with structured content and appends a tagged link to today's daily note. Use this skill whenever the user wants to preserve session findings, research results, or investigation outcomes in Obsidian.
---

# Obsidian Report

When invoked, summarize the current session's investigation and record it to the Obsidian vault at `~/obsidian/abekoh`.

## Steps

### 1. Get today's date

```bash
date +%Y-%m-%d   # e.g. 2026-06-14
date +%Y         # e.g. 2026
date +%m         # e.g. 06
```

### 2. Generate a report title

Derive a concise English title from the session's main topic. Use lowercase hyphen-separated words (e.g. `neovim-plugin-setup`, `obsidian-skill-creation`, `go-grpc-api`). Keep it short (3–5 words max).

The final filename will be: `YYYY-MM-DD-{title}.md`

### 3. Compose the report content

Use this exact structure:

```markdown
---
tags: [reports]
date: YYYY-MM-DD
---

# {タイトル（日本語でOK）}

## 概要
（このセッションで何を調べたか・目的・背景を2〜3文で）

## 調査内容
（実際に調べた内容、試したこと、気づきを箇条書きや段落で）

## 結論・まとめ
（得られた知見、結論、次のアクションがあれば）

## 参考資料
- （参照したURL、ドキュメント、文献を箇条書きで。なければ省略）
```

### 4. Save the report

**Prefer obsidian-cli** when Obsidian is running (test with `obsidian daily:read 2>/dev/null`). Fall back to direct file operations if it fails.

#### With obsidian-cli:

The `obsidian create` command does not create intermediate directories automatically. Use direct file operations for the report file to ensure `_reports/YYYY/MM/` exists, then open via obsidian-cli if desired.

```bash
# Create directory if needed
mkdir -p ~/obsidian/abekoh/_reports/YYYY/MM

# Write the report file directly
# (use Write tool or cat heredoc)
```

Alternatively, if obsidian-cli supports path creation:
```bash
obsidian create path="_reports/YYYY/MM/YYYY-MM-DD-{title}.md" content="..." silent overwrite
```

#### Without obsidian-cli (direct file operations):

```bash
mkdir -p ~/obsidian/abekoh/_reports/YYYY/MM
# Then write the file using the Write tool
```

Target path: `~/obsidian/abekoh/_reports/YYYY/MM/YYYY-MM-DD-{title}.md`

### 5. Append link to today's daily note

The daily note path is: `~/obsidian/abekoh/_daily/YYYY/MM/YYYY-MM-DD.md`

Append this block to the end of the file (the `---` delimiters are part of the format):

```
---
#reports

[[YYYY-MM-DD-{title}]]
---
```

#### With obsidian-cli:

```bash
obsidian daily:append content="---\n#reports\n\n[[YYYY-MM-DD-{title}]]\n---"
```

#### Without obsidian-cli (direct file operations):

Read the current daily note, append the block at the end, and write it back using the Write tool. If today's daily note does not exist yet, create it with just the appended block.

## Notes

- Always write the full report content — don't skip sections unless there's genuinely nothing to say
- The title in the filename is English/romaji; the `# heading` inside the file can be Japanese
- If obsidian-cli is unavailable, use the Write/Edit tools to operate directly on `~/obsidian/abekoh/`
- The `_reports` directory may not exist yet — always ensure it's created with `mkdir -p`
