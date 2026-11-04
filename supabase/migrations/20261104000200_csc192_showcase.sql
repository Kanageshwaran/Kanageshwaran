BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc192' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 192 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b269f05d-df4d-41f1-8f80-866b05726669' AND course_id='csc192') THEN RAISE EXCEPTION 'CSC 192 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Spring 2025. Career Planning: nine distinct expert seminars summarized in one journal, covering career preparation, entrepreneurship, emerging CS roles, technology leadership, startups and corporations, Caltrans, consulting, workplace culture and IT management. Includes combined reflection and original response files.' WHERE id='csc192';
UPDATE public.assignments SET title='Career Seminar Journal', description='One consolidated seminar journal with nine concise summaries and personal takeaways, searchable by speaker or topic. Word/PDF copies, questionnaires, transcripts and helper notes are grouped under their original seminar so each session counts once. Includes source PDFs, response text, a 44-file inventory and documented date/name discrepancies.', assignment_type='Expert seminars / Career reflections', demo_url='/course/csc192/assignment/seminars' WHERE id='b269f05d-df4d-41f1-8f80-866b05726669' AND course_id='csc192';
COMMIT;
