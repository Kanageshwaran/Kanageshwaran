BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc135' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 135 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='46872389-2555-4c24-9ab7-1ab5333cfaa9' AND course_id='csc135') THEN RAISE EXCEPTION 'CSC 135 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Automata, grammars, Turing machines, and computability limits.' WHERE id='csc135';
UPDATE public.assignments SET title='Project Example', description='Built and analyzed automata, grammars, and Turing machine models.', assignment_type='', demo_url='' WHERE id='46872389-2555-4c24-9ab7-1ab5333cfaa9' AND course_id='csc135';
COMMIT;
