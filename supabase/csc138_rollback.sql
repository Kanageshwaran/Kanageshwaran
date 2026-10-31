-- Restore the supplied CSV snapshot values; review against any newer edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc138' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 138 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b5906c95-59a0-4d8c-a0f7-1aa3dfb347f4' AND course_id='csc138') THEN RAISE EXCEPTION 'CSC 138 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='TCP/IP, routing, switching, DNS/HTTP, and security basics.' WHERE id='csc138';
UPDATE public.assignments SET title='Project Example', description='Created a basic network and simulated data transfer using protocol tools.', assignment_type='', demo_url='' WHERE id='b5906c95-59a0-4d8c-a0f7-1aa3dfb347f4' AND course_id='csc138';
COMMIT;
