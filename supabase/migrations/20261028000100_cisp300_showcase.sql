-- Targeted metadata update only. Run in Supabase SQL Editor after review.
BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id = 'cisp300' AND subject_id = 'computer_science') THEN
  RAISE EXCEPTION 'Expected CISP 300 course missing or moved; no changes applied';
 END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id = '532581be-6701-4aac-8aea-0f9c87a515ac' AND course_id = 'cisp300') THEN
  RAISE EXCEPTION 'Expected time-conversion assignment missing; no changes applied';
 END IF;
END $$;
UPDATE public.courses
 SET description = 'American River College, Fall 2019. Programming foundations, decisions, collections, searching and sorting, files, recursion, functions and grouped data. Featured work: a Python weeks-and-days converter and introductory console programs.', updated_at = now()
 WHERE id = 'cisp300' AND subject_id = 'computer_science';
UPDATE public.assignments
 SET description = 'Implemented a Python time-conversion utility using a struct-like class, a reusable conversion function, integer division and remainder, with console input and formatted output.', demo_url = '/course/cisp300/assignment/time-conversion', assignment_type = 'Programming assignment', updated_at = now()
 WHERE id = '532581be-6701-4aac-8aea-0f9c87a515ac' AND course_id = 'cisp300';
COMMIT;
-- The two basics files are grouped in the course UI; no invented assignment rows.
-- Existing counts, IDs, repository links, RLS policies and views remain unchanged.
