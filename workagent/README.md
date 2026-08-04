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

## Quickstart (new user)

Cloning gives you the tools plus a starting playbook. The two things **you** supply are
your own `~/.config/jira/config.json` and your own API token — no private context is
inherited.

**Prereqs:** `python3`, `~/.local/bin` on your `PATH`, and either the 1Password CLI `op`
(signed in) or a `$JIRA_API_TOKEN` env var. `gh` optional (for GitHub work).

1. **Clone to the expected path** (scripts assume it):
   ```sh
   git clone <repo-url> ~/workspace/dotfiles
   ```
2. **Install** — minimal (see [Install](#install) for the `setup.sh` alternative):
   ```sh
   mkdir -p ~/.local/bin ~/.config/jira
   ln -sf ~/workspace/dotfiles/workagent/bin/jira ~/.local/bin/jira
   cp ~/workspace/dotfiles/workagent/config.example.json ~/.config/jira/config.json
   ```
3. **Create an Atlassian API token** (see [Auth](#auth-no-secret-in-the-repo)) and store it
   in your 1Password, or export it as `$JIRA_API_TOKEN`.
4. **Fill in `~/.config/jira/config.json`** with your values: `site`, `email`,
   `op_token_ref`, `default_project`, `sprint_field` (default `customfield_10020` — verify
   for your instance), optional `board_id`. `account_self` you can grab from `jira me`.
5. **Test:** `jira me` then `jira mine`.
6. **Wire your harness(es)** to the playbook (see [harness/](harness)):
   - Claude Code: add `@~/workspace/dotfiles/workagent/AGENT.md` to `~/.claude/CLAUDE.md`
   - Cursor: add a **User** rule pointing at `~/workspace/dotfiles/workagent/AGENT.md`
   - Gemini CLI: add the same pointer to `~/.gemini/GEMINI.md`
7. **(Optional) personalize `AGENT.md`** — it encodes one person's working-style
   preferences and briefing habits; adjust to taste. Nothing sensitive to strip.

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
