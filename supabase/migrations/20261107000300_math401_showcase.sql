BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math401' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 401 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='642442f5-23e6-4b77-bb68-fbc5326f660e' AND course_id='math401') THEN RAISE EXCEPTION 'MATH 401 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Spring 2021. Calculus II: integration applications and techniques, improper integrals, parametric and polar curves, sequences and infinite series. A 24-exhibit visual journey grounded in the supplied quizzes, homework and exams.' WHERE id='math401';
UPDATE public.assignments SET title='Small Pieces, Infinite Possibilities', description='Small Pieces, Infinite Possibilities: 24 interactive reconstructions across six visual chapters. Moving slices, washers, shells, antiderivatives, a substitution triangle, traced curves, term bars and power polynomials connect the work. Includes source downloads, three-step calculations and selected review corrections. All 53 files inventoried; 48 unique public source files, two exact copies and three administrative files kept inventory-only.', assignment_type='Calculus II / Interactive Visual Journey', demo_url='/course/math401/assignment/explore' WHERE id='642442f5-23e6-4b77-bb68-fbc5326f660e' AND course_id='math401';
COMMIT;
