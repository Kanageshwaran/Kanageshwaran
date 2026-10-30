BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc131' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 131 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='562dbae8-16ce-4506-a0f9-b5ba500aea60' AND course_id='csc131') THEN RAISE EXCEPTION 'CSC 131 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='SDLC, software design, and project management.' WHERE id='csc131';
UPDATE public.assignments SET title='Project Example', description='Developed a task management application using SDLC and collaborative workflows.', assignment_type='', demo_url='' WHERE id='562dbae8-16ce-4506-a0f9-b5ba500aea60' AND course_id='csc131';
COMMIT;
