-- Restore only fields changed here from the provided snapshot.
-- Use before later intentional metadata edits.
BEGIN;
UPDATE public.courses SET name='CISP 401 - Object Oriented Programming with C++', description='Topics: C++ language, OOP, encapsulation, inheritance, polymorphism, templates, Linux/UNIX.
Methodologies: Object-Oriented Design, Encapsulation/Overloading, Linux/UNIX environment.
Project Example: Banking system with account management and inheritance for account types.
Featured Project: Java Swing Desktop Calculator.', updated_at='2026-06-08 18:50:56.445021+00' WHERE id='cisp401' AND subject_id='computer_science';
UPDATE public.assignments SET description='Applied object-oriented concepts (encapsulation, inheritance, polymorphism) and development workflows in a Unix/Linux environment.', assignment_type=NULL, demo_url=NULL, updated_at='2026-01-19 05:47:49.604818+00' WHERE id='b96b83d1-2745-4cd3-b85e-e3600d59e120' AND course_id='cisp401';
UPDATE public.course_tools SET tool='C++' WHERE id='15aead95-618c-428f-86ce-45c6230c78c6' AND course_id='cisp401';
COMMIT;
