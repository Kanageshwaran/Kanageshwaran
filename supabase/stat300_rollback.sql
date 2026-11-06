-- Restore supplied CSV snapshot fields; review against newer live edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='stat300' AND subject_id='mathematics') THEN RAISE EXCEPTION 'STAT 300 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='a783e203-2085-45f9-9143-e784ad6f6fd2' AND course_id='stat300') THEN RAISE EXCEPTION 'STAT 300 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Descriptive statistics, probability principles, hypothesis testing, regression, and ANOVA.' WHERE id='stat300';
UPDATE public.assignments SET title='Project Example: Survey Data Analysis', description='Summarizing data, probability analysis, and statistical inference. Project: Conducting statistical analysis of survey data.', assignment_type='', demo_url='' WHERE id='a783e203-2085-45f9-9143-e784ad6f6fd2' AND course_id='stat300';
COMMIT;
