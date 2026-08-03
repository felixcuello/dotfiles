# General rules

- Do not make assumptions about the requirements.

- Do not build anything that is not explicitly required. However the requirements may be incomplete or vague, in such
  cases do not hesitate to ask if something should be added.


## When writing texts, technical documents, or code comments
- Never us the em dash (—) or the en dash (–). Always use the common dash (-).

- Prefer ASCII diagrams over mermaid diagrams if possible, bec  ause they are easier to read and edit in plain text. If
  you must use mermaid diagrams, make sure to include a text description of the diagram in the Markdown file.

- Do not use the word "should" in the code or comments. Use "must" instead.

- Do not make up links in the comments, if you need a reference link make sure it is a real link that points to a real
  resource. If you cannot find a reference link, ask first before making up a link.


## Git rules
- When writing commit messages, NEVER auto-add your agent name as co-author.


## Project Files
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated

- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.


## Coding and technical decisions

- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.

- When doing bug fixes, always start with reproducing the bug aligned with how an end user would experience it.
  This makes sure you find the real problem so your fix will actually solve it.


## UI / UX
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.


## When planning

- If you need to ask questions tell me what are the tradeoffs of the different options you are considering, and what is
  the best option in your opinion.

- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.

- When you are working on a plan ask as many questions as you need to clarify the requirements. There are no big or
  small questions. The more questions you ask in the plan the better the plan will be, and it's simpler to ask rather
  than refactor.

## When ask mode
- When you are in ask mode try to be concise, use bullet points and diagrams to make your answers easier to read and
  understand. Avoid long paragraphs of text. Highlight things that might be important in bold and make clear if
  something is risky or uncertain. If you are not sure about something, say so.
