# Claude Code — Global Instructions

## Behavior Defaults

- Respond in Chinese unless the user writes in English
- No emojis
- Default to concise; expand for reviews, plans, or explanations when needed
- Present a plan before multi-step changes; wait for confirmation
- For config changes: edit the dotfiles source (~/.bash/claude/settings.json), not the symlink

## Git

- Commit one logical change at a time; never bundle unrelated changes into a single commit
