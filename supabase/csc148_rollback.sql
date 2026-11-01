-- Restore supplied CSV snapshot values; review against newer database edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc148' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 148 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b44037e3-dfcd-46dc-ae72-b176ee103c48' AND course_id='csc148') THEN RAISE EXCEPTION 'CSC 148 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Simulation modeling, Monte Carlo, queuing theory, and experimental design.' WHERE id='csc148';
UPDATE public.assignments SET title='Project Example', description='Built and analyzed simulation models to evaluate system performance.', assignment_type='', demo_url='' WHERE id='b44037e3-dfcd-46dc-ae72-b176ee103c48' AND course_id='csc148';
COMMIT;
