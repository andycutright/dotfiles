# Cursor pointer

Add a user-level rule (Cursor Settings → Rules → User Rules, or `~/.cursor/rules/`) that
references the portable playbook:

```
Follow the work-management playbook at ~/workspace/dotfiles/workagent/AGENT.md.
```

Cursor cannot `@import` an absolute path the way Claude Code does, so the rule instructs
the agent to read the file. Keep the rule short; the file is the source of truth.
