---
name: incremental-delivery-workflow
description: "Run or resume a scaled Git/GitHub delivery workflow for any finalized implementation plan so changes stay appropriately sized, reviewable, and safely integrated: preflight existing workflow state before planning/coding, choose direct single-PR delivery for small low-risk plans, or create a base feature branch with task/phase/review-fix slice PRs for larger work, integrate approved slices with fast-forward Git history, optionally run independent slices in parallel when requested, then raise or update one aggregate PR to the project deployment branch. Use when implementing a finalized plan, resuming implementation, continuing implementation, continuing a plan, picking up implementation, moving to the next feature/task/phase, avoiding one large risky PR, choosing between one PR and sliced delivery, preserving linear Git history, coordinating serial phases, or coordinating independent parallel task branches."
---

# Incremental Delivery Workflow

Use this workflow after any implementation plan is finalized when the delivery shape should be scaled to the work. Small, cohesive, low-risk plans should usually ship as one normal PR directly to the project's deployment-ready branch. Larger or riskier plans should be split into small reviewable PR artifacts plus one final human review PR from a created base branch to the deployment-ready branch. Execute dependent sliced work sequentially by default; run independent slice branches in parallel only when the finalized plan clearly supports it or the user explicitly asks for parallel work.

When the user asks to implement, continue, resume, or work on the next feature/task, check workflow state before planning or coding. A previous session may have ended abruptly, leaving an unreviewed PR, uncommitted slice, unpushed branch, or unfinished integration.

## Core model

- **Deployment branch**: the project's deployment-ready integration branch, e.g. `main`, `master`, `develop`, or a release branch. This is the branch the final aggregate PR targets.
- **Direct PR branch**: one feature/fix branch created from the deployment branch for small plans that fit the direct-PR threshold. It opens one PR directly to the deployment branch and does not create a workflow base branch or slice PRs.
- **Base branch**: one feature/plan branch created from the deployment branch for sliced delivery. This is not the deployment branch itself. Name it using project contribution conventions, e.g. `feature/<ticket>-<slug>` when that is the repo norm.
- **Slice branch**: one task, phase, or review-fix branch, created from the current base branch during sliced delivery. Example names like `task/<slug>`, `phase/<number>-<slug>`, or `fix/<slug>` are illustrative only; project branch conventions win.
- **Slice PR**: a GitHub PR from slice branch to base branch. It is created before integration so GitHub captures a reviewable diff UI, comments, commits, and CI history.
- **Aggregate PR**: the final human review PR from base branch to the deployment branch, e.g. `feature/<slug> -> master` or `feature/<slug> -> main`.
- **Integration**: locally fast-forward the base branch to the slice branch, then push the base branch. Do not use GitHub's merge button for slice PRs.

Review mode is **right-sized**. Direct PR mode has one normal human review PR. Sliced mode is **artifact-first**: slice PRs are preserved slice-level history/artifacts, not the final human approval gate. The final human review happens on the aggregate PR. Expected outcome for sliced mode: slice PRs appear as merged/closed on GitHub, the aggregate PR contains the final combined diff, and Git history stays linear until the aggregate PR is merged according to project rules.

## Mandatory first step: discover project contribution rules

Before touching branches, inspect repository guidance and summarize the rules you will follow. Check likely files including:

- `AGENTS.md` and nested agent instruction files relevant to the working directory
- `CONTRIBUTING.md`, `.github/CONTRIBUTING.md`, `docs/contributing.md`
- `README.md` sections about development or contributing
- `.github/PULL_REQUEST_TEMPLATE*`
- issue templates, commitlint config, release/changelog docs, DCO/signoff docs

Also inspect Git state and branch protection assumptions:

```bash
git status --short
git branch --show-current
git remote -v
git remote show origin | sed -n '/HEAD branch/s/.*: //p'
```

Confirm or infer whether agents may push to newly created feature/task branches. The deployment branch is usually protected and should not be pushed to directly. Direct PR branches and sliced-mode base branches are created by this workflow from the deployment branch and are normally unprotected; if repo/org rules protect the chosen working branch in a way that blocks direct pushes, stop and ask for a different branch or workflow adjustment.

Follow this precedence:

1. Explicit user instruction
2. Project contribution guidelines
3. Repo-local agent instructions
4. This skill's defaults

Adapt branch names, commit style, PR title/body, required issue links, tests, CI expectations, signed commits, reviewer/label rules, and deployment branch (`master`, `main`, `develop`, release branch, etc.) to the project. When Jira or another issue tracker is used, preserve story/task identifiers in branch names, commit messages, and PR titles/bodies according to repo convention.

Completion criterion: you have stated the detected deployment branch, contribution files consulted, branch/commit/PR conventions, required checks, selected delivery mode (`direct PR` or `sliced`), selected branch name(s), and push/protection assumptions before branch creation.

## Preflight before planning or implementation

Before doing any new planning, choosing the next feature/task, creating branches, or editing code, run the workflow-state preflight whenever the user asks to implement, continue, resume, or move to the next feature/task.

Do not plan the next feature first. First check whether there is an existing plan/workflow in progress and what GitHub/Git state says about it. Only after reporting the checkpoint and getting the user's direction should you plan or implement the next slice.

## Resume an existing incremental delivery workflow

When the user asks to continue/resume/implement, do not assume the previous session state is complete. Reconstruct the workflow state from Git and GitHub before planning, creating new branches, or editing code.

```bash
git status --short
git fetch origin --prune
git branch --show-current
gh pr list --state all --json number,title,state,baseRefName,headRefName,url
```

Identify, in this order:

- whether there is an existing plan/workflow in progress from the current session, repo docs, issue, branch names, or PRs
- deployment branch
- delivery mode: direct PR or sliced, inferred from branches/PRs and any recorded plan
- direct PR branch/PR, if one exists (`<direct-pr-branch> -> <deployment>`)
- base branch created for the feature/story, if sliced mode was used
- aggregate PR, if one exists (`<base-branch> -> <deployment>`)
- slice PRs targeting the base branch, if sliced mode was used
- local or remote branches without PRs
- uncommitted or unpushed work on the current branch
- planned tasks/phases not started yet, from the plan or user context

Classify each slice:

- **merged artifact**: slice PR is merged/closed because its commits are reachable from base
- **open ready**: slice PR exists and appears ready for the user's review checkpoint
- **open in progress**: slice PR exists but work/checks are not complete
- **local only**: slice branch exists locally/remotely but no PR exists yet
- **planned**: task/phase exists in the plan but no branch exists yet

After reconstruction, report only the workflow checkpoint and enforce the review gate. Keep resume/checkpoint output minimal: state the blocking PR/status and the next action needed. Do not summarize completed implementation work, changed files, commits, or checks unless the user asks for details. Example:

```text
Workflow checkpoint: PR #13 is ready for review: <url>.
Please review #13 and tell me when it is approved/done. Once you get back to me, I will integrate it into <base-branch> and ask whether to move on to the next task/phase/feature.
```

Resume ordering rules:

- If a direct PR is ready/open, stop at that review checkpoint unless the user asks for updates to that PR.
- If any previous slice PR is ready/open and not integrated, stop at that review checkpoint. Do not start planning or implementing the next task/phase/feature.
- If the current branch has uncommitted slice work, finish that slice: run checks, commit using project conventions, push, open/update the slice PR, then wait for review approval.
- If a slice PR was reviewed and the user says approved/done, integrate it automatically, then ask whether to continue with the next task/phase/feature.
- Only start planning or implementing a new planned slice when all earlier ready slices have either been integrated or the user explicitly says to leave that slice open and start another independent parallel slice.

Completion criterion: the user has a minimal workflow checkpoint and the workflow is either waiting at the correct review checkpoint, finishing an in-progress slice, or continuing only after the user chose the next action.

## Scale selection threshold

Before creating branches, choose the delivery mode from the finalized plan and state the decision.

Use **direct PR mode** when all of these are true:

- the plan has one cohesive task or one tightly coupled serial change that reviewers can understand as a single diff
- expected implementation is small enough for a fast review: usually less than 200 net changed lines across no more than 5 files
- no database migrations, broad public API/schema changes, security-sensitive behavior, large refactors, or cross-cutting changes across multiple subsystems
- the work can be fully validated with the repo's normal required checks in one pass
- the user or project rules do not require slice artifacts

Use **sliced mode** when any of these are true:

- the plan naturally has 2 or more independently reviewable tasks or dependent phases
- expected implementation is 200 or more net changed lines or exceeds 5 files
- the plan includes migrations, public API/schema changes, risky behavior changes, broad refactors, or changes across multiple subsystems
- review would likely take more than about 15 minutes as one PR
- the user asks to keep PRs small, preserve slice artifacts, run independent tasks in parallel, or avoid one large risky PR

If the plan is close to the threshold, prefer direct PR for cohesive low-risk work and sliced mode for uncertain or higher-risk work. Do not split just to follow the workflow; use sliced delivery only when it improves review safety.

## Workflow

### 1. Choose direct PR or prepare the base branch

Require a clean worktree unless the user explicitly asks you to handle existing changes.

For **direct PR mode**, create one normal feature/fix branch from the deployment branch, implement the full small plan on that branch, run required checks, commit, push, and open one PR directly to the deployment branch. Do not create a base branch, slice branches, slice PRs, or aggregate PR.

```bash
git status --short
git fetch origin
# replace <deployment> with the detected project deployment branch
git checkout <deployment>
git pull --ff-only origin <deployment>
git checkout -b <direct-pr-branch>
# implement the small plan, run checks, commit
git push -u origin <direct-pr-branch>
gh pr create \
  --base <deployment> \
  --head <direct-pr-branch> \
  --title "<project-compliant title>" \
  --body "<project-compliant body>"
```

For **sliced mode**, create a base branch from the deployment branch before creating slice branches.

```bash
git status --short
git fetch origin
# replace <deployment> with the detected project deployment branch
git checkout <deployment>
git pull --ff-only origin <deployment>
git checkout -b <base-branch>
git push -u origin <base-branch>
```

Choose `<direct-pr-branch>` or `<base-branch>` from project conventions. Prefer the repo's normal feature branch prefix when one exists, e.g. `feature/<story-id>-<slug>` or `feature/<ticket>-<slug>`. Do not hardcode `plan/` unless it fits the repo.

Completion criterion for direct PR mode: `<direct-pr-branch>` exists locally and remotely, starts at current `<deployment>`, contains the complete small change, passes required checks or documents failures, and has one PR targeting `<deployment>`. Completion criterion for sliced mode: `<base-branch>` exists locally and remotely, starts at current `<deployment>`, and is documented as the base branch for the plan.

### 2. Classify increments as independent tasks or serial phases

Skip this step in direct PR mode. In sliced mode, support both execution shapes. Default to serial/sequential execution unless the finalized plan clearly marks independent tasks or the user explicitly asks for parallel work.

**Parallel task shape**: use when tasks are independently solvable from the base branch. Multiple agents may work on different slice branches at the same time only when parallelization is requested or explicitly supported by the finalized plan, but ready slice PRs still wait for user review approval before integration. Do not start extra parallel work on resume if there is a ready/open slice waiting for review unless the user explicitly says to leave it open and start another independent slice.

**Serial phase shape**: use when the feature must be built in dependent phases. Create one phase slice, open its slice PR, wait for user review approval, fast-forward it into base, ask whether to continue, then create the next phase slice from the updated base. Do not start a later dependent phase from an outdated base or before the previous phase is reviewed and integrated.

For each task or phase in the finalized plan:

```bash
git checkout <base-branch>
git pull --ff-only origin <base-branch>
git checkout -b <slice-branch>
```

Choose `<slice-branch>` from project conventions. If Jira or another tracker has separate story/task IDs, include the relevant ID. For example, a base branch might carry the story ID while slice branches carry task IDs, such as `feature/PROJ-123-checkout-flow` for the base and `task/PROJ-456-add-validation` or `feature/PROJ-456-add-validation` for a slice, depending on repo convention. If the repo has no convention, use descriptive names: `task/<slug>` for independent work and ordered names like `phase/1-<slug>`, `phase/2-<slug>` for dependent phases. The number communicates phase order; it is not required when project conventions or tracker IDs already encode order.

Do the task/phase implementation only on its slice branch. Run the project's required checks for that slice. Commit the slice work using project commit conventions before opening the slice PR; do not stop at an uncommitted diff unless blocked or the user explicitly asked for no commit. After pushing anything to a slice branch, expect CI to run or trigger the repo's documented check command if CI is not available.

Completion criterion: each slice branch contains only its intended task/phase commits, has no uncommitted implementation diff, and passes the relevant checks or has clearly documented failures.

### 3. Open the slice PR before integration

Skip this step in direct PR mode. In sliced mode, push the slice branch and open a PR targeting the base branch:

```bash
git push -u origin <slice-branch>
gh pr create \
  --base <base-branch> \
  --head <slice-branch> \
  --title "<project-compliant title>" \
  --body "<project-compliant body>"
```

The slice PR body must follow the same project PR conventions as any other PR. Use the repo PR template when present; otherwise use this skill's default PR body template: `Because`, `This addresses`, `Test Plan`, plus `Ref` only when there is a real issue/ticket reference. If the reference would be `N/A`, omit the `Ref` line/section entirely. Keep the description focused only on the actual independent task change: why it exists, what it changes, and checks run.

Do not mention that this is a slice, that it belongs to a parent/aggregate PR, that it targets a base branch, the linear workflow, artifact explanations, merge-button warnings, or integration mechanics in the slice PR body. Those belong in the agent's internal workflow/status updates, not in reviewer-facing PR copy.

Completion criterion: every completed slice has committed changes, a pushed branch, a GitHub PR URL whose base is `<base-branch>`, a PR body that reads like a normal independent task PR using project conventions, and the user has been told the slice PR is ready and waiting for review approval.

### 4. Offer a slice review checkpoint, then fast-forward

In direct PR mode, stop after the single PR is ready and ask the user to review it according to normal project rules. There is no base integration step.

In sliced mode, when each slice PR is ready, explicitly ask the user to review it and get back to the agent. Keep workflow mechanics in this message, not in the PR body. Example: `Slice PR #12 is ready: <url>. Please review it and tell me when it is approved/done. Once you get back to me, I will integrate it into <base-branch> and ask whether to move on to the next task/phase/feature.`

Pause work on that slice until the user says the review is done/approved. Make the next expected user action clear; do not merely say the workflow is waiting. Do not implement the next serial phase or next non-explicit parallel task while waiting. Once the user says the review is done/approved, automatically integrate that slice into the base branch; do not ask a second time whether to integrate. After integration succeeds, ask whether to continue with the next task/phase/feature.

After the slice PR exists and the slice is ready according to the user's workflow and project rules, integrate it locally. If the base branch has advanced since the slice was created, avoid force-pushing by default: prefer creating a replacement slice from the latest base and cherry-picking the slice commits when the existing PR branch would need history rewriting.

Only one actor may integrate into `<base-branch>`. Parallel agents may work on independent slice branches, but a single base integrator must serialize all fast-forwards to avoid races. In serial phase mode, the base integrator advances the base after each phase before the next phase starts.

```bash
git fetch origin

git checkout <base-branch>
git pull --ff-only origin <base-branch>

git checkout <slice-branch>
git pull --ff-only origin <slice-branch>
# If <slice-branch> is already based on the current <base-branch>:
git checkout <base-branch>
git merge --ff-only <slice-branch>
git push origin <base-branch>
```

If `<slice-branch>` is stale and cannot fast-forward into the latest base without rewriting remote history, create a replacement slice instead of force-pushing:

```bash
git checkout <base-branch>
git pull --ff-only origin <base-branch>
git checkout -b <replacement-slice-branch>
git cherry-pick <slice-commit-range>
git push -u origin <replacement-slice-branch>
gh pr create --base <base-branch> --head <replacement-slice-branch> ...

git checkout <base-branch>
git merge --ff-only <replacement-slice-branch>
git push origin <base-branch>
```

Guardrails:

- At each ready slice PR, ask the user to review it and get back to the agent when approved/done. Do not continue to the next serial phase or next non-explicit parallel task while a previous ready slice is awaiting review. When the user approves/done-signals the slice, integrate it automatically, then ask whether to continue with the next task/phase/feature.
- Use `git merge --ff-only`; never create merge commits for slice integration.
- Do not force-push by default. If a PR branch disallows force-push, do not ask the user to override it; create a replacement slice branch from the latest base instead.
- Use `--force-with-lease`, never plain `--force`, only when the user/project explicitly allows rewriting PR branch history and it is clearly better than a replacement slice.
- If a later slice conflicts with earlier integrated slices, resolve carefully on the replacement/current slice and report any cross-slice decisions made during conflict resolution.
- If `--ff-only` fails, stop and diagnose instead of using a merge commit.
- After pushing a slice/replacement slice or updated base branch, wait for CI or run the documented checks again.
- Do not delete slice branches until the user approves cleanup; they are review artifacts.

Completion criterion: the user had a review checkpoint for the ready slice PR, GitHub shows the slice PR as merged/closed because its commits are reachable from the base branch, the base branch contains the slice commits linearly, and required checks have passed or failures are documented.

### 5. Maintain the aggregate PR

Skip this step in direct PR mode; the direct PR is already the human review PR to the deployment branch.

In sliced mode, open or update the aggregate PR from base branch to deployment branch:

```bash
gh pr create \
  --base <deployment> \
  --head <base-branch> \
  --title "<project-compliant aggregate title>" \
  --body-file <body-file>
```

The aggregate PR body must first satisfy the project's GitHub contribution guidance and PR template exactly: required sections, issue links, test plan, screenshots, risk notes, labels/reviewer conventions, and any other repo-specific fields.

If the project has no PR template or contribution guidance, use these default conventions for every PR. Include `Ref: #<issue-number>` only when there is a real issue/ticket reference; if the value would be `N/A`, omit the `Ref` line entirely.

```md
Ref: #<issue-number> <!-- omit this line if there is no real reference -->

## Because
- <why the change is being made>

## This addresses
- <bullet per meaningful change — what was added/updated/removed>

## Test Plan
- [x] Tests pass
- [x] Linter/formatter clean
```

For the aggregate PR only, append one extra section:

```md
## Slice PRs
- #12
- #13
- #14
```

Keep the aggregate PR's `Slice PRs` section concise: list only the included slice PRs as links or PR numbers, without per-slice commentary unless the project template explicitly requires it. If a slice is replaced or intentionally not shipped, omit it from the aggregate PR body; the aggregate PR should list only slice PRs that are part of the final change.

Never include AI/agent attribution in any PR body.

Update the aggregate PR body after every slice integration.

Completion criterion: the aggregate PR is the only workflow PR targeting the deployment branch, and it links every included slice PR needed to understand the change.

### 6. Handle review feedback

In direct PR mode, handle review feedback on the direct PR branch using the project's normal update flow: commit fixes to the same branch unless the user or project rules require a separate follow-up PR.

In sliced mode, when the aggregate PR receives review feedback, do not amend already integrated task branches unless the user explicitly asks. Create a new review-fix slice from the current base:

```bash
git checkout <base-branch>
git pull --ff-only origin <base-branch>
git checkout -b fix/<fix-slug>
```

Implement the fix, open a slice PR from `fix/<fix-slug>` to `<base-branch>`, then fast-forward it into the base using the same integration process. Update the aggregate PR body or add a comment linking the review-fix PR.

Completion criterion: every review-requested code change is represented by a new linked fix PR that was fast-forwarded into the base branch.

### 7. Final merge

In direct PR mode, when the direct PR is approved and required checks pass, merge it according to the project's contribution rules and GitHub settings.

In sliced mode, when the aggregate PR is approved and required checks pass, merge the aggregate PR according to the project's contribution rules and GitHub settings. A normal merge of the base branch to the deployment branch is acceptable when that is the repo's standard; do not fight project settings unless the user asks.

Completion criterion: the direct PR branch or base branch is merged to the project deployment branch according to project rules, and any branch cleanup is done only with user approval.

## Status report format

Default to minimal checkpoint output. Do not include implementation summaries, file lists, commit lists, or check details unless the user asks. For direct PR mode, use this shape:

```md
Workflow checkpoint: PR #<n> is ready for review: <url>.
Please review PR #<n> and tell me when it is approved/done.

Details available on request:
- delivery mode / deployment branch
- checks
- commits
```

For sliced mode, use this shape:

```md
Workflow checkpoint: PR #<n> is ready for review: <url>.
Please review PR #<n> and tell me when it is approved/done. Once you get back to me, I will integrate it into `<base-branch>` and ask whether to move on to the next task/phase/feature.

Details available on request:
- delivery mode / base branch / deployment branch
- aggregate PR
- slice list
- checks
- commits
```

## Stop conditions

Stop and ask the user before proceeding if:

- the worktree is dirty and the changes are not yours
- the deployment branch is ambiguous
- project contribution rules conflict with this workflow
- direct push to the chosen direct PR branch or base branch is blocked
- another agent/process is currently integrating into the base branch
- a previous ready slice PR is awaiting user review approval and the user has not explicitly asked to start another independent parallel slice
- a stale slice cannot be cleanly cherry-picked onto a replacement branch from the latest base
- conflict resolution would require cross-slice product/design decisions
- `git merge --ff-only` fails
- required checks fail and the failure is not clearly unrelated
