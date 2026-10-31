BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc134' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 134 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='8e351830-7b4a-46a0-94de-e780f22ffd27' AND course_id='csc134') THEN RAISE EXCEPTION 'CSC 134 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='ER models, SQL, normalization, and indexing.' WHERE id='csc134';
UPDATE public.assignments SET title='Project Example', description='Designed and queried a relational database using ER modeling and SQL.', assignment_type='', demo_url='' WHERE id='8e351830-7b4a-46a0-94de-e780f22ffd27' AND course_id='csc134';
COMMIT;
