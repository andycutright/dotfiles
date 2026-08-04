# workagent

A personal, portable work-management toolkit: thin CLIs plus a harness-agnostic
playbook (`AGENT.md`), so the same "assistant" behaves the same in Claude Code, Cursor,
Gemini CLI, or a plain terminal — without loading expensive hosted MCP connectors.

**This repo is public.** No secrets live here, ever. Tokens come from 1Password (`op`)
or an environment variable at runtime. Anything sensitive (customer names, internal IPs,
the live ticket queue, specific noise-filter targets) stays in private repos and local
machine state — this playbook only *points* at it.

## Contents

| Path | What |
|---|---|
| `bin/jira` | Jira Cloud CLI (REST v2, stdlib Python 3). Replaces the hosted Atlassian MCP on the hot path. |
| `config.example.json` | Placeholder Jira config. Copy to `~/.config/jira/config.json` and fill in. |
| `AGENT.md` | The portable operating playbook (Phase 2). |
| `harness/` | Thin per-harness pointers to `AGENT.md` (paste into each tool's user config). |

## Install

`setup.sh` (repo root) wires this up: it symlinks `bin/jira` into `~/.local/bin`
(already on PATH) and seeds `~/.config/jira/config.json` from the example if absent.
Symlink (not copy) so edits in the repo are live.

Manual equivalent:

```sh
mkdir -p ~/.local/bin ~/.config/jira
ln -sf ~/workspace/dotfiles/workagent/bin/jira ~/.local/bin/jira
[ -e ~/.config/jira/config.json ] || cp ~/workspace/dotfiles/workagent/config.example.json ~/.config/jira/config.json
```

## Auth (no secret in the repo)

The `jira` CLI resolves its API token in order:

1. `$JIRA_API_TOKEN` (handy for CI / headless)
2. `op read <op_token_ref>` — the `op_token_ref` in your local config points at a
   1Password item field.

Create an Atlassian API token at <https://id.atlassian.com/manage-profile/security/api-tokens>,
store it in 1Password, and set `op_token_ref` in `~/.config/jira/config.json` to that
item's field (e.g. `op://Private/Atlassian API/credential`).

## `~/.config/jira/config.json`

Non-secret instance config, kept out of the repo:

```json
{
  "site": "YOURORG.atlassian.net",
  "email": "you@example.com",
  "op_token_ref": "op://<vault>/<item>/<field>",
  "account_self": "<your-accountId>",
  "sprint_field": "customfield_10020",
  "default_project": "PROJ",
  "board_id": null
}
```

`board_id` is only needed for `jira sprint-add` (find it in a board URL: `.../boards/<id>`).

## Commands

```
jira me                              whoami (auth check)
jira mine                            my open issues (KEY  STATUS  PRI  UPDATED  SUMMARY)
jira sprint                          my issues in the current open sprint
jira search 'JQL'  [--max N]         arbitrary JQL
jira issue KEY                       one issue: fields + description + last comments
jira comments KEY                    comments only
jira comment KEY "text"              add a comment
jira transition KEY "In Progress"    move status (matched by transition or target name)
jira assign KEY [me|ACCOUNT_ID]      (re)assign; default me
jira worklog KEY --dur MIN [--comment "..."]
jira sprint-add KEY                  add to the board's active sprint
```

Add `--json` to any command for the raw API object; the default output is terse and
token-cheap by design.
