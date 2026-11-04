-- Restore supplied CSV snapshot fields; review against newer live edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc192' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 192 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b269f05d-df4d-41f1-8f80-866b05726669' AND course_id='csc192') THEN RAISE EXCEPTION 'CSC 192 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Resume, job search, career goals, and industry trends.' WHERE id='csc192';
UPDATE public.assignments SET title='Project Example', description='Developed a resume and long-term career plan aligned with industry goals.', assignment_type='', demo_url='' WHERE id='b269f05d-df4d-41f1-8f80-866b05726669' AND course_id='csc192';
COMMIT;
