-- Targeted metadata only. Review and run in the portfolio Supabase SQL Editor.
BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp360' AND subject_id='computer_science') THEN RAISE EXCEPTION 'Expected CISP 360 course missing'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='2a4e9ad5-c066-4764-a932-b7ac9d5920da' AND course_id='cisp360') THEN RAISE EXCEPTION 'Expected vehicle assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Spring 2020. Structured C++ programming with input/output, selection, loops, functions, arrays, pointers, records and file-processing exercises. Featured archive: vehicle collection, array statistics and character-based digit summation.',updated_at=now() WHERE id='cisp360' AND subject_id='computer_science';
UPDATE public.assignments SET description='Archived C++ vehicle-data collection program using a fixed array of vehicleData structs. The input loop runs on tested samples; separate validation/display helpers are incomplete. The portfolio adds a browser reconstruction with validation and a table.',assignment_type='Structured C++ programming',demo_url='/course/cisp360/assignment/vehicles',updated_at=now() WHERE id='2a4e9ad5-c066-4764-a932-b7ac9d5920da' AND course_id='cisp360';
COMMIT;
-- No rows added, counts unchanged, GitHub links and other courses preserved.
