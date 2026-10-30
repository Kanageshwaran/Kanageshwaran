BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc130' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 130 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='10cea3f6-8318-41be-b1a5-37377b551f40' AND course_id='csc130') THEN RAISE EXCEPTION 'CSC 130 featured assignment missing'; END IF;
END $$;
-- CSV snapshot rollback of changed fields only; not a backup of newer live edits.
UPDATE public.courses SET description='Advanced data structures, algorithm design/analysis, and graph algorithms.' WHERE id='csc130';
UPDATE public.assignments SET title='Project Example', description='Built a pathfinding system using graph algorithms and optimized data structures.', assignment_type='', demo_url='' WHERE id='10cea3f6-8318-41be-b1a5-37377b551f40' AND course_id='csc130';
COMMIT;
