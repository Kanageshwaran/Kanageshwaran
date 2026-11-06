BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='stat300' AND subject_id='mathematics') THEN RAISE EXCEPTION 'STAT 300 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='a783e203-2085-45f9-9143-e784ad6f6fd2' AND course_id='stat300') THEN RAISE EXCEPTION 'STAT 300 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Spring 2023. Introduction to Probability and Statistics. A compact visual portfolio presents grouped frequency data, a handwritten five-number summary, paired before-and-after measurements and height/weight relationships. Original spreadsheets and recorded answers are distinguished from new reference calculations.' WHERE id='stat300';
UPDATE public.assignments SET title='Statistics Visual Portfolio', description='Four simple visual stories: selectable frequency bars, an annotated five-number summary, paired measurement plots and a scatterplot with an optional fitted line. Original data and formulas stay in expandable sections, with unchanged workbook downloads and the original answer-page image. Includes a 42-file inventory and independent checks of 68 saved numeric values.', assignment_type='Descriptive statistics / Paired data / Correlation', demo_url='/course/stat300/assignment/explore' WHERE id='a783e203-2085-45f9-9143-e784ad6f6fd2' AND course_id='stat300';
COMMIT;
