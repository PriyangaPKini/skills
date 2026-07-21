# Test quality guidance

Good tests verify externally observable behavior through public seams.

## Good tests

- read like a small specification
- use expected values from an independent source of truth
- survive refactors that preserve behavior
- fail when the behavior is broken

## Bad tests

- assert private implementation details
- duplicate the implementation logic in the assertion
- depend on incidental file structure or internal call order
- overuse snapshots for behavior that should be explicit

## Choosing seams

A seam is the public boundary where behavior can be observed. Examples:

- a CLI command
- an HTTP endpoint
- a public function exported by a module
- a user-visible workflow

Prefer testing the highest-level seam that gives useful feedback without making the test slow or brittle.
