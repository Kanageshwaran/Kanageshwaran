-- Restore the supplied CSV snapshot values; review against any newer edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc137' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 137 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='2355a108-bb83-4e2c-ae8a-6c4b8280a7a7' AND course_id='csc137') THEN RAISE EXCEPTION 'CSC 137 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='CPU, memory, I/O, interrupts, bus, and multithreading concepts.' WHERE id='csc137';
UPDATE public.assignments SET title='Project Example', description='Simulated CPU and memory components using digital logic modeling tools.', assignment_type='', demo_url='' WHERE id='2355a108-bb83-4e2c-ae8a-6c4b8280a7a7' AND course_id='csc137';
COMMIT;
