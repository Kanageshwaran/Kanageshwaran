-- Restore only edited fields to the supplied CSV snapshot. Review newer live edits first.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math400' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 400 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='474a7677-3eae-4e36-b6f3-adb5993ed1eb' AND course_id='math400') THEN RAISE EXCEPTION 'MATH 400 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Limits, continuity, differentiation, and integration of various functions.' WHERE id='math400';
UPDATE public.assignments SET title='Project Example: Motion Modeling', description='Evaluating limits and applying differentiation/integration techniques. Project: Modeling motion with derivatives and integrals.', assignment_type='', demo_url='' WHERE id='474a7677-3eae-4e36-b6f3-adb5993ed1eb' AND course_id='math400';
COMMIT;
