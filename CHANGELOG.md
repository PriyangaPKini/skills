# Changelog

All notable changes to this skills repository are documented here.

This project uses a lightweight manual changelog. Add entries under `Unreleased` as changes are merged, then move them under a version heading when cutting a release.

## Unreleased

- Updated `incremental-delivery-workflow` to choose direct single-PR delivery for small low-risk plans and sliced delivery for larger work.
- Added `incremental-delivery-workflow` for delivering finalized plans through small reviewable Git/GitHub PR slices.

## 0.1.0 - 2026-07-21

- Initial promoted engineering and productivity skill catalog.
- Skill authoring templates and promotion documentation.
- Installation docs for Pi, Claude Code, and Codex.
- Validation scripts and GitHub Actions validation workflow.
- Claude Code plugin metadata for promoted skills.

## Release process

1. Make sure `main` is up to date.
2. Choose the next version using semantic versioning.
3. Update `package.json` and `.claude-plugin/plugin.json` to the same version.
4. Move relevant `Unreleased` entries under a new `## <version> - YYYY-MM-DD` heading.
5. Run `npm run validate`.
6. Commit the release update and tag it as `v<version>`.
7. Push the commit and tag.

GitHub Actions validates release tags before publishing release notes.
