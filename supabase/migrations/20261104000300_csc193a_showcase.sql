BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc193a' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 193A course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='680954f5-6cf8-4c29-9d4e-c6f0936494f6' AND course_id='csc193a') THEN RAISE EXCEPTION 'CSC 193A assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2025. Web Programming: HTML and CSS, DOM events and string transformations, a shift cipher, a supplied AJAX pet-gallery reference, Express routes and SOL Church App contribution evidence. Code/result workbenches distinguish saved implementations, supplied examples and new browser reconstructions.' WHERE id='csc193a';
UPDATE public.assignments SET title='Web Programming Studio', description='Six visual workbenches pair original code or screenshots with HTML output, text formatting, cipher character mapping, pet-gallery request replay, circle/greeting route responses and SOL state examples. Includes 18 source records, 34 bounded JavaScript checks, a 1353-file inventory and reviewed wiring/validation issues.', assignment_type='HTML / CSS / JavaScript / Express / App state', demo_url='/course/csc193a/assignment/fancify' WHERE id='680954f5-6cf8-4c29-9d4e-c6f0936494f6' AND course_id='csc193a';
COMMIT;
