BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='math372' AND subject_id='mathematics') THEN RAISE EXCEPTION 'MATH 372 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='1d23bc32-f594-460d-9c27-b81932a35569' AND course_id='math372') THEN RAISE EXCEPTION 'MATH 372 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Spring 2020. College Algebra for Calculus. One handwritten ellipse-and-string example becomes a six-step visual journey through coordinates, equations, radicals, distances and a new matrix-rotation connection. Systems, matrices, conics and sequences remain available in the page-by-page coursework archive.' WHERE id='math372';
UPDATE public.assignments SET title='One Ellipse, Many Connections', description='One Ellipse, Many Connections: an interactive graph with progressively revealed formulas, lower-level explanations, live string distances, vector components, a rotation matrix and a final construction answer. Includes all seven source files in a 36-page index, 35 public page images, an optional sequence plot and independently checked review notes. Completed work is distinguished from instructor references.', assignment_type='Algebra / Matrices / Conics / Sequences', demo_url='/course/math372/assignment/explore' WHERE id='1d23bc32-f594-460d-9c27-b81932a35569' AND course_id='math372';
COMMIT;
