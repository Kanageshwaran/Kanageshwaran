-- Snapshot rollback: review against any newer edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc163' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 163 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='26907786-0bfa-4d09-a6bb-29d5df874d43' AND course_id='csc163') THEN RAISE EXCEPTION 'CSC 163 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='GPU architecture, CUDA programming, parallel patterns, and optimization.' WHERE id='csc163';
UPDATE public.assignments SET title='Project Example', description='Implemented and optimized CUDA kernels for parallel computation tasks.', assignment_type='', demo_url='' WHERE id='26907786-0bfa-4d09-a6bb-29d5df874d43' AND course_id='csc163';
COMMIT;
