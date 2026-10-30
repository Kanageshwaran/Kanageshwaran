BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc131' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 131 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='562dbae8-16ce-4506-a0f9-b5ba500aea60' AND course_id='csc131') THEN RAISE EXCEPTION 'CSC 131 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Spring 2024. Hornet Helpers team volunteer-management project: requirements, sprint planning, interface revisions, Java/MySQL experiments and later Node/Express/MongoDB snapshots. The showcase documents integration difficulties, final coursework delivery and lessons learned, with a clearly labeled new browser reconstruction.' WHERE id='csc131';
UPDATE public.assignments SET title='Hornet Helpers: Website Development Journey', description='Team volunteer-management coursework for the Sacramento State Career Center context. Follow initialization, implementation, integration failures, learning, final prototype and lessons learned. DK contribution notes cover planning/retrospectives, registration/login backend, main page and volunteer dashboard. New browser demo illustrates intended workflows; production deployment and complete acceptance testing are not established by the archive.', assignment_type='Team web project / SDLC', demo_url='/course/csc131/assignment/hornet-helpers' WHERE id='562dbae8-16ce-4506-a0f9-b5ba500aea60' AND course_id='csc131';
COMMIT;
