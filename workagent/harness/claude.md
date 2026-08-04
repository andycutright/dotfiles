# Claude Code pointer

Append this line to your **global** `~/.claude/CLAUDE.md` (do not replace the file — it
holds other global instructions):

```
@~/workspace/dotfiles/workagent/AGENT.md
```

That imports the portable work-management playbook into every Claude Code session,
regardless of which repo you're in.
