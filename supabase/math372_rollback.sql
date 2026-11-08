-- Restore only edited fields to the supplied CSV snapshot. Review newer live edits first.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math372' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 372 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='1d23bc32-f594-460d-9c27-b81932a35569' AND course_id='math372') THEN RAISE EXCEPTION 'MATH 372 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Polynomial, rational, exponential functions, sequences, and series.' WHERE id='math372';
UPDATE public.assignments SET title='Project Example: Polynomial Scenario Modeling', description='Understanding algebraic structures and applications. Project: Modeling a real-world scenario using polynomial functions.', assignment_type='', demo_url='' WHERE id='1d23bc32-f594-460d-9c27-b81932a35569' AND course_id='math372';
COMMIT;
