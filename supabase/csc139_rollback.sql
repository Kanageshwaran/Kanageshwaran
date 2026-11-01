-- Restore the supplied CSV snapshot values; review against any newer edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc139' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 139 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b94cf096-fa77-4632-8b12-e2877af1a345' AND course_id='csc139') THEN RAISE EXCEPTION 'CSC 139 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Processes, scheduling, synchronization, memory, file systems, and security.' WHERE id='csc139';
UPDATE public.assignments SET title='Project Example', description='Implemented and analyzed scheduling and synchronization concepts in C.', assignment_type='', demo_url='' WHERE id='b94cf096-fa77-4632-8b12-e2877af1a345' AND course_id='csc139';
COMMIT;
