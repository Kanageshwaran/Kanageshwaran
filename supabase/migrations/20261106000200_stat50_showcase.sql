BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='stat50' AND subject_id='statistics') THEN RAISE EXCEPTION 'STAT 50 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='cce1bc01-b19b-457b-9d9b-d227c64c4be6' AND course_id='stat50') THEN RAISE EXCEPTION 'STAT 50 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State University, Spring 2024. Introduction to Probability and Statistics. Interactive visual replays of handwritten sample spaces, binomial probabilities, sampling distributions and chi-square goodness-of-fit work. Includes original coursework downloads and concise review notes.' WHERE id='stat50';
UPDATE public.assignments SET title='Probability Studio', description='Probability Studio: four focused visual explorations with outcome tiles, a binomial chance slider, a sample-size curve and an observed-versus-expected chart. Original scans and calculations are expandable. All 36 source files are inventoried; 20 completed coursework PDFs are available unchanged. A significance-threshold correction is explained separately from the preserved original answer.', assignment_type='Probability / Distributions / Statistical inference', demo_url='/course/stat50/assignment/explore' WHERE id='cce1bc01-b19b-457b-9d9b-d227c64c4be6' AND course_id='stat50';
COMMIT;
