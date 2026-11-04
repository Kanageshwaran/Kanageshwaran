-- Restore supplied CSV snapshot fields; review against newer live edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc193a' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 193A course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='680954f5-6cf8-4c29-9d4e-c6f0936494f6' AND course_id='csc193a') THEN RAISE EXCEPTION 'CSC 193A assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Client-server architecture, HTML/CSS/JS, AJAX, services, and databases.' WHERE id='csc193a';
UPDATE public.assignments SET title='Project Example', description='Built interactive web applications with database connectivity.', assignment_type='', demo_url='' WHERE id='680954f5-6cf8-4c29-9d4e-c6f0936494f6' AND course_id='csc193a';
COMMIT;
