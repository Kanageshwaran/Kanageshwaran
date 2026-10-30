BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc60' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 60 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='7c04a42c-f9aa-421c-9b7d-b96bd7664d1a' AND course_id='csc60') THEN RAISE EXCEPTION 'CSC 60 featured assignment ID missing'; END IF;
END $$;
-- Restores only changed fields from the supplied CSV snapshot, not newer live changes.
UPDATE public.courses SET description='System calls, file handling, and dynamic memory/pointers in C.' WHERE id='csc60';
UPDATE public.assignments SET title='Project Example', description='Developed a custom shell using system calls and process management in C.', assignment_type='', demo_url='' WHERE id='7c04a42c-f9aa-421c-9b7d-b96bd7664d1a' AND course_id='csc60';
COMMIT;
