-- Restore only fields changed by this package from supplied exports.
-- Use before later intentional metadata edits.
BEGIN;
UPDATE public.courses SET description='Topics: Assembly language, machine instructions, data type representation, numerical computation.
Methodologies: Assembly Programming, High-Level to Low-Level Translation, Data Representation and Computation.
Project Example: Assembly program for arithmetic operations and data structure manipulation.
Featured Project: Recursive Sorted Linked-List Insertion.', updated_at='2026-06-08 18:50:56.445021+00' WHERE id='cisp310' AND subject_id='computer_science';
UPDATE public.assignments SET description='Built an assembly-level solution focused on data representation and machine-level execution, reinforcing how higher-level logic maps to instructions.', assignment_type=NULL, demo_url=NULL, updated_at='2026-01-19 05:47:49.604818+00' WHERE id='7dd9f7fe-c099-41be-9d4a-296781038b49' AND course_id='cisp310';
UPDATE public.course_tools SET tool='MIPS Assembly Simulator (Logisim)' WHERE id='2a452389-beea-4ad6-bfb8-279c2c83716a' AND course_id='cisp310';
COMMIT;
