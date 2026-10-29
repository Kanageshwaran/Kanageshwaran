-- Restore only fields modified by this package, from the provided exports.
-- Run only before subsequent intentional edits to these fields.
BEGIN;
UPDATE public.courses SET description = 'Topics: Algorithm design, top-down, divide-and-conquer, program design, source code.
Methodologies: Top-Down Problem Solving, Divide-and-Conquer, Program Design and Documentation.
Project Example: Algorithm to sort and search large datasets efficiently.
Featured Project: Struct-Based Time Conversion Utility.', updated_at = '2026-06-08 18:50:56.445021+00' WHERE id = 'cisp300' AND subject_id = 'computer_science';
UPDATE public.assignments SET description = 'Implemented algorithmic problem solving using top-down and divide-and-conquer thinking, with clean program design and documentation.', demo_url = NULL, assignment_type = NULL, updated_at = '2026-01-19 05:47:49.604818+00' WHERE id = '532581be-6701-4aac-8aea-0f9c87a515ac' AND course_id = 'cisp300';
COMMIT;
