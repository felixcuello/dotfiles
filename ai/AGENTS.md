# AGENTS.md

This file has to be taken into consideration for any planning, design, or implementation of any agent. It contains rules
and guidelines that must be followed to ensure consistency and quality across all agents.

## Model usage

- When in ask mode. Before asking a question check if MAX mode is enabled and if it is, tell the user to disable it
  (/max-mode).

- When in plan mode. Before creating a plan check if MAX mode is enabled and if it is, tell the user to enable it
  (/max-mode), and use a good model for planning (e.g. opus or above)

- When in agent mode. Before executing a build with an agent check if MAX mode is enabled and if it is, tell the user to
  enable it (/max-mode), and use a reasonable good model for building (e.g. grok)


## General rules

- Do not make assumptions about the requirements.

- Do not build anything that is not explicitly required. However the requirements may be incomplete or vague, in such
  cases do not hesitate to ask if something should be added.


## Database Usage

- If you create a query, be sure you're using indices. If the indices are not there, ask if they should be created. If
  you are not sure, ask for help.

- Never create indices or migrations without asking specifically for them. Altering the database schema is a big deal
  and should be done with care.

- Do not repeat small queries that can be cached.

- If you're going to update or delete a big number of rows, consider doing it in batches to avoid locking the table for too long.

- Always consider the performance implications of your queries, especially when working with large datasets. Use EXPLAIN
  to analyze query plans and optimize them as needed.

- When using an ORM or an abstraction layer be careful not to fall into the N+1 query problem. Always check the
  generated SQL queries to make sure they are efficient and do not cause performance issues.

## When writing texts, technical documents, or code comments
- Never us the em dash (—) or the en dash (–). Always use the common dash (-).

- Prefer ASCII diagrams over mermaid diagrams if possible, bec  ause they are easier to read and edit in plain text. If
  you must use mermaid diagrams, make sure to include a text description of the diagram in the Markdown file.

- Do not use the word "should" in the code or comments. Use "must" instead.

- Do not make up links in the comments, if you need a reference link make sure it is a real link that points to a real
  resource. If you cannot find a reference link, ask first before making up a link.


## Git rules
- When writing commit messages, NEVER auto-add your agent name as co-author.

- Never commit. The user must always be the one to commit. The most you can do is to suggest a commit message. The
  suggested commit message must be semantically correct and follow the conventional commit format. 


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
