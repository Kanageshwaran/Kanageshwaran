-- Restore supplied CSV snapshot fields; review against newer live edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='stat50' AND subject_id='statistics') THEN RAISE EXCEPTION 'STAT 50 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='cce1bc01-b19b-457b-9d9b-d227c64c4be6' AND course_id='stat50') THEN RAISE EXCEPTION 'STAT 50 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Probability distributions and statistical inference with applied analysis.' WHERE id='stat50';
UPDATE public.assignments SET title='Project Example', description='Analyzed probability distributions in a real-world dataset.', assignment_type='', demo_url='' WHERE id='cce1bc01-b19b-457b-9d9b-d227c64c4be6' AND course_id='stat50';
COMMIT;
