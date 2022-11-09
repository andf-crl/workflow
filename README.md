# Core Workflow Tools
Automate your git-based docs-as-code workflow (like at CRL). For best results, place in `$PATH`!

Comprised of the following tools:

## workflow
Checks out a new branch in your local `$WORKSPACE`, sets it up for work, then opens a new VS Code workspace from 
that directory.

_Usage:_ `workflow DOC-1234-fix-typo-in-example` from anywhere on your machine.

## genrns
Generates release notes, with a focus on ease of use and automation of as many tasks as possible.

_Usage:_ `genrns v21.1.18 53cb1ed8f2f42376ad76d4888d582c88685b2820 2022-04-12` from within your local `docs` git repo directory.

## genrns-legacy
Same as `workflow` but for release notes: wraps the amazing `release-notes.py` script from ED-TOOLS to auto-generate 
release notes without user input. When working on a release notes ticket, use `genrns` _instead_ of `workflow`. `genrns-legacy` is the
original version of `genrns` before it was converted to be appropirate for team use.

_Usage:_ `genrns DOC-3239-v21.1.18-release-notes 53cb1ed8f2f42376ad76d4888d582c88685b2820 2022-04-12` from anywhere on your machine.

## push
Collects all your changes together under a commit, and creates a new - or updates an existing - PR. Pass the `-f` flag to
force push an empty commit to trigger a site rebuild. Ideally ran from the VS Code terminal in the workspace
prepared for you by `workflow`

_Usage:_ `push` from within the git repo you wish to push

# Supporting Workflow Tools
A selection of tools to assist with writing docs-as-code

## search_upstream
Search for a provided search term across all upstream generated content we currently reference as include files. Supports using the `-e` flag to
exclude a comma-separated list of directories or regexes matching directories; filenames or globs matching filenames are ignored.

_Usage:_ `search_upstream -e "archived/*,v1.0/*,v1.1/*,v2.0/*,v2.1/*,v19.1/*,v19.2/*,v20.1/*,v20.2/*,v21.1/*,v21.2/*,_includes/releases/*,releases/*" crdb-v1` from within your `docs` directory.

## update_metrics
Compare `chartcatalog` output of a live `cockroach` instance against our `metric-names.md` file, merging in any metrics found missing. Uses [`spinup`](https://github.com/andf-crl/tools/blob/main/spinup) to automate launching the `cockroach` instance. Pass the `-v` flag to specify a non-stable version. Unfortunately, `cockroach v21.1` and earlier do not support `chartcatalog`, so this tool cannot be used with those versions.

_Usage:_ `update_metrics` or `update_metrics -v 21.2` from within the git branch whose `metric-names.md` file you wish to update.

## build_settings
Build `cluster-settings.md` page directly from `cockroach gen settings-list --format=rawhtml` output, then inject anchor link targets, then sort by alpha. 

_Usage:_ `build_settings` from within the git branch whose `cluster-settings.md` file you wish to update.

## link_all_settings
Consult `cluster-settings.md` page (as created by `build_settings`), and link all settings that appear in the corpus to their new anchor links. Use `-v` to specify a non-stable version.

_Usage:_ `link_all_settings` from within the git branch whose cluster settings you'd like to link sitewide.

# Maintenance Workflow Tools
Contains a collection of small support scripts for use alongside the above Core Workflow Tools.

## rebasefork
Updates your forked copy of docs with the latest from upstream. `workflow` automatically fetches the latest state of 
upstream's `master` branch each run, so `rebasefork` only serves to save us time on `workflow`'s  initial clone & rebase 
step. You can optionally use the `-f` flag to completely reset your fork to match current upstream exactly: doing so 
discards any fork-specific commits!

## cleanspace
Clean up any staging builds from all local git repos in `$WORKSPACE`.

# Example workflow usage, using these tools:

1. `workflow DOC-1234-fix-typo-in-example`

2. In resulting VSCode window, edit appropriate Markdown files to address concerns raised in Jira ticket.

3. `push` when you are ready to commit & push your changes for review. Supply a commit message for your first commit, when prompted. In this workflow, all subsequent pushes are applied as `commit --amend`.

4. Proceed through the usual review process, in Reviewable or GH directly. If changes are proposed, repeat steps 2 and 3 as needed.

5. Once LGTM, squash & merge

Occassionally, run `rebasefork` and `cleanspace`.
