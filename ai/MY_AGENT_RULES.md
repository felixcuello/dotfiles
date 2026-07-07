# General rules

- Never us the em dash (—) or the en dash (–). Always use the common dash (-).

- When writing commit messages, NEVER auto-add your agent name as co-author.

- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated

- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.

- Prefer ASCII diagrams over mermaid diagrams if possible, bec  ause they are easier to read and edit in plain text. If
  you must use mermaid diagrams, make sure to include a text description of the diagram in the Markdown file.

- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.

- When doing bug fixes, always start with reproducing the bug aligned with how an end user would experience it.
  This makes sure you find the real problem so your fix will actually solve it.

- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.

- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.

- Do not use the word "should" in the code or comments. Use "must" instead.

- Do not make up links in the comments, if you need a reference link make sure it is a real link that points to a real
  resource. If you cannot find a reference link, ask first before making up a link.

- When in plan mode you should always ask more questions before assuming something. Do not make changes that are not
  clear or do not have an explicit requirement. But you could facilitate things by trying to make good guesses about
  what is needed, as long as it is not critical.

- Do not hesitate to ask clarifying questions when creating a plan, I am happy to answer any question you have. Your
  questions will make me think more about the problem and help me clarify my requirements.
