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

- When asking questions always provide me a tradeoff analysis of the different options you are considering, so I can
  leverage on your options and make a better decision. If you are not sure about something, say so.

## Metrics and Datadog

- Think about the metrics you want to collect. If there's a metric that has to be added ASK for it.

- Never modify metrics without asking.

- When adding new metrics have special care to not break existing metrics.

- When adding new metrics have special care to check the cardinality of the metric. If the cardinality is too high, it
  can cause a huge increase costs.

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
- Never use the em dash (—) or the en dash (–). Always use the common dash (-).

- Never use the (×) symbol, use either (x) or (*) or the word "by", "times" or "multiplied by" depending if it's in a
  formula, a comment, or a text.

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


## Coding

### General rules for coding

- Name and parameters must be self explanatory.

- When writing new functions add 1 up to 4 lines of comments explaining the purpose of the function.

- When adding new parameters to any function be careful to not break existing code. If you need to add a new parameter,
  make sure it has a default value and is optional.
    - If you do, the default value must be a safe value that replicates the previous behavior of the function. If you
      are not sure, ask for help.
    - If you can't do it safely, ask for help.

- Always try to lint your code.

- Make sure all tests related to the code you are working on pass.

- Do not introduce flakiness in tests. If you see a flaky test, ask if it should be fixed, and if so, fix it.

### When working on a bug

Working on a bug can be tricky because you have to first differentiate if the bug is how the system is supposed to work
(because some users can complain about a feature that is actually working as intended) or if it is a real bug.

- If it is NOT a bug, explain why it is not a bug and provide a brief explanation on how the system is supposed to work
  and (if possible) why the user is experiencing it differently. If you're unsure about the behavior, ask for help.

- If it is a bug then follow these steps:
    - Reproduce the bug and make sure you understand it.
    - Write a test that reproduces the bug.
    - Fix the bug following the coding rules and best practices written in this document.
    - Make sure all tests pass.


## Technical Decisions

- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.

- When doing bug fixes, always start with reproducing the bug aligned with how an end user would experience it.
  This makes sure you find the real problem so your fix will actually solve it.

## UI / UX
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.


## When planning

- If you need to ask questions tell me what are the tradeoffs of the different options you are considering. For
  simplicity I would like you to provide your personal opinion on what you think is the best option as the default
  option, but also provide the other options and their tradeoffs.

- When you are working on a plan ask as many questions as you need to clarify the requirements. There are no big or
  small questions. The more questions you ask in the plan the better the plan will be, and it's simpler to ask rather
  than refactor.

## When ask mode
- When you are in ask mode try to be concise, use bullet points and diagrams to make your answers easier to read and
  understand. Avoid long paragraphs of text. Highlight things that might be important in bold and make clear if
  something is risky or uncertain. If you are not sure about something, say so.
