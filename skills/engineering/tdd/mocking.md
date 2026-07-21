# Mocking guidance

Mocks are useful when they isolate your code from slow, flaky, expensive, or external systems.

Use mocks for:

- network calls
- payment providers
- email/SMS delivery
- time
- randomness
- filesystem or process boundaries when needed

Avoid mocks for:

- internal collaborators that are part of the behavior under test
- private functions
- data transformations that can be tested directly

A mock should make the test clearer. If it makes the test mostly about implementation wiring, test at a better seam.
