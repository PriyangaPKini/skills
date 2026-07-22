# Incremental Delivery Workflow

Quickstart:

```bash
npx skills add PriyangaPKini/skills --skill=incremental-delivery-workflow
```

Source: [`skills/engineering/incremental-delivery-workflow`](https://github.com/PriyangaPKini/skills/tree/main/skills/engineering/incremental-delivery-workflow)

## What it does

The Incremental Delivery Workflow skill guides the agent through delivering a finalized implementation plan at the right PR scale.

For small, cohesive, low-risk plans, it uses one normal branch and one PR directly to the project's deployment branch. For larger or riskier work, it creates one base branch from the deployment branch, then creates focused task, phase, or review-fix slice branches with PRs targeting that base branch. Approved slices are integrated into the base branch with fast-forward Git history, and one aggregate PR carries the combined change to the deployment branch.

## When to reach for it

This is a model-invoked skill. Let the agent reach for it automatically when you ask it to implement or resume a finalized plan, choose between one PR and sliced delivery, keep changes reviewable, avoid one large risky PR, preserve linear Git history, create slice PR artifacts, continue the next phase, or coordinate independent parallel task branches.

Reach for it when the plan is already decided and the remaining challenge is safe delivery through reviewable increments.

## How it works

The workflow starts by discovering project contribution rules and reconstructing any existing Git/GitHub workflow state. It then chooses the delivery mode from the finalized plan.

Use direct PR mode when the plan is one cohesive, low-risk task that is usually less than 200 net changed lines across no more than 5 files, has no migrations or broad API/schema/refactor risk, and can be reviewed in about 15 minutes. In that mode, the agent opens one PR to the deployment branch.

Use sliced mode when the plan naturally has multiple reviewable tasks/phases, exceeds that size threshold, crosses multiple subsystems, includes migrations or risky API/schema changes, or when the user asks to keep PRs small. Serial phases are implemented and reviewed one at a time. Independent tasks may be implemented on separate slice branches in parallel when the user requests parallelization or the finalized plan clearly supports it. Integration into the base branch remains serialized by one actor to avoid races.

Each completed slice gets a PR to the base branch, a user review checkpoint, and fast-forward integration after approval. The aggregate PR to the deployment branch is kept updated with the included slice PRs.

## It's working if

- The agent checks contribution rules and existing workflow state before coding.
- Small low-risk work is delivered through one normal PR.
- Larger work is delivered through small, focused slice branches and PRs.
- Dependent work runs sequentially from the updated base branch.
- Independent work is parallelized only when requested or explicitly supported by the plan.
- Only one actor integrates into the base branch.
- Slice integration uses fast-forward Git history and avoids force-pushes by default.
- In sliced mode, the aggregate PR contains the final combined diff and references included slice PRs.

## Where it fits

Use this after planning and before or during implementation. Use `tdd` inside a direct PR or individual slices when behavior should be built test-first, `diagnosing-bugs` when the cause of a failure is unknown, and `code-review` to review a direct, slice, or aggregate diff.
