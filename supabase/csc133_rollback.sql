BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc133' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 133 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='78f62b3b-e98c-406d-ae69-fa47f41df6e0' AND course_id='csc133') THEN RAISE EXCEPTION 'CSC 133 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='2D graphics, OOP, mobile development, GUIs, and design patterns.' WHERE id='csc133';
UPDATE public.assignments SET title='Project Example', description='Created a mobile app with GUI using object-oriented design patterns.', assignment_type='', demo_url='' WHERE id='78f62b3b-e98c-406d-ae69-fa47f41df6e0' AND course_id='csc133';
COMMIT;
