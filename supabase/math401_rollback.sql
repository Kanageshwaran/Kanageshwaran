-- Review newer live edits before restoring this historical CSV snapshot.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math401' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 401 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='642442f5-23e6-4b77-bb68-fbc5326f660e' AND course_id='math401') THEN RAISE EXCEPTION 'MATH 401 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Improper integrals, sequences, infinite series, polar coordinates, and vector calculus topics.' WHERE id='math401';
UPDATE public.assignments SET title='Project Example: Physical System Modeling', description='Analyzing convergence and applying theorems. Project: Modeling a physical system using differential equations.', assignment_type='', demo_url='' WHERE id='642442f5-23e6-4b77-bb68-fbc5326f660e' AND course_id='math401';
COMMIT;
