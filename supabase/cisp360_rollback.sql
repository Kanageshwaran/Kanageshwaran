-- Restore only metadata changed by this package from the supplied snapshot.
-- Use before later intentional edits to these fields.
BEGIN;
UPDATE public.courses SET description='Topics: Structured programming, OOP concepts, control structures, functions, arrays, pointers.
Methodologies: Structured Programming, OOP, Debugging and Testing.
Project Example: File management system using functions, arrays, and classes.
Featured Project: Vehicle Data Collection Console Program.', updated_at='2026-06-08 18:50:56.445021+00' WHERE id='cisp360' AND subject_id='computer_science';
UPDATE public.assignments SET description='Created a structured console program with functions, arrays, and class fundamentals emphasizing debugging and modular design.', assignment_type=NULL, demo_url=NULL, updated_at='2026-01-19 05:47:49.604818+00' WHERE id='2a4e9ad5-c066-4764-a932-b7ac9d5920da' AND course_id='cisp360';
COMMIT;
