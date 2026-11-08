BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math400' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 400 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='474a7677-3eae-4e36-b6f3-adb5993ed1eb' AND course_id='math400') THEN RAISE EXCEPTION 'MATH 400 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Fall 2020. Calculus I. A recorded cubic extrema example becomes an interactive study of a curve, secant-to-tangent slopes, endpoint comparisons and a clearly labeled new accumulation connection. Optional labs revisit an algebraic limit, signed area and rectangle optimization. Completed work and instructor references remain distinct.' WHERE id='math400';
UPDATE public.assignments SET title='A Curve, a Closer Look', description='A Curve, a Closer Look: four linked views of f(x)=x^3-6x^2+5, with a moving point, shrinking secant, checked extrema and Riemann rectangles. Three optional labs show a removable discontinuity, signed versus geometric area and the maximum-area rectangle under 2^(-x). All 43 source files are inventoried, including four exact extra copies; 39 unique originals are available unchanged. Includes selected graph-limit corrections.', assignment_type='Limits / Derivatives / Applications / Integrals', demo_url='/course/math400/assignment/explore' WHERE id='474a7677-3eae-4e36-b6f3-adb5993ed1eb' AND course_id='math400';
COMMIT;
