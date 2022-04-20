# Core Workflow Tools
Contains a series of Bash wrappers to automate using a git-based docstools workflow (like at CRL). For best results, 
place in `$PATH`!

Comprised of the following tools:

## workflow
Checks out a new branch in your local `$WORKSPACE`, sets it up for work, then opens a new VS Code workspace from 
that directory.

_Usage:_ `workflow DOC-1234-fix-typo-in-example` from anywhere on your machine.

## genrns
Same as `workflow` but for release notes: wraps the amazing `release-notes.py` script from ED-TOOLS to auto-generate 
release notes without user input. When working on a release notes ticket, use `genrns` _instead_ of `workflow`.

_Usage:_ `genrns DOC-3239-v21.1.18-release-notes 53cb1ed8f2f42376ad76d4888d582c88685b2820 2022-04-12` from anywhere on your machine.

## stage
Stages the repo for viewing in a webbrowser.

_Usage:_ `stage` from within the git repo you wish to stage.

**NOTE**: Not yet implemented

## review
Commits your changes to git, and submits for code review using the MDB internal Rietveld tool. If the first round of CR, 
uses the new CR ID. If a subsequent round, re-uses the existing one. Requires locally storing the CR ID for now.

_Usage:_ `review` from within the git repo you wish to submit. Ideally ran from the VS Code terminal in the workspace 
prepared for you by `workflow`

**NOTE**: Not yet implemented

## push
Once LGTM has been obtained, submits the code as-is to Git Hub, and provides links to the next three web-based steps (PR 
in GitHub, Close JIRA, close CR). Also supports force-pushing with the `-f` flag.

_Usage:_ `push` from within the git repo you wish to publish. Ideally ran from the VS Code terminal in the workspace
prepared for you by `workflow`

**NOTE**: Not yet implemented

# Supporting Workflow Tools
Contains a collection of small support scripts for use alongside the above Core Workflow Tools.

## rebasefork
Updates your forked copy of docs with the latest from upstream. `workflow` automatically fetches the latest state of 
upstream's `master` branch each run, so `rebasefork` only serves to save us time on `workflow`'s  initial clone & rebase 
step. You can optionally use the `-f` flag to completely reset your fork to match current upstream exactly: doing so 
discards any fork-specific commits!

## cleanspace
Clean up any staging builds from all local git repos in `$WORKSPACE`.

# Other Automation
Contains ad-hoc or otherwise tangential support scripts not related to git, but for use in a docs-as-code workflow

## prom
Manage a locally-installed Prometheus instance with ease


# Example workflow usage, using these tools:

**Note**: Several components not yet implemented

1. `workflow DOC-1234-fix-typo-in-example`

2. In resulting VSCode window, edit appropriate Markdown files to address concerns raised in Jira ticket.

3. `stage` within VSCode terminal to preview changes via local Makefile staging

4. Repeat steps 2 and 3 until ready for review

5. `review` from within the VSCode terminal to submit to Reviewable when ready for feedback

6. One of:

   - CR is returned with LGTM: `push` from within VSCode terminal to create PR and open the resulting GH page

   - CR comes back with feedback. Repeat steps 2-5 (edit - `stage` - `review`)

Occassionally, run `rebasefork` and `cleanspace`.

