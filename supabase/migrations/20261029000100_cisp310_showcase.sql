-- Metadata only; review and run in Supabase SQL Editor.
BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp310' AND subject_id='computer_science') THEN RAISE EXCEPTION 'Expected course missing'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='7dd9f7fe-c099-41be-9d4a-296781038b49' AND course_id='cisp310') THEN RAISE EXCEPTION 'Expected assignment missing'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.course_tools WHERE id='2a452389-beea-4ad6-bfb8-279c2c83716a' AND course_id='cisp310') THEN RAISE EXCEPTION 'Expected course tool missing'; END IF;
END $$;
UPDATE public.courses SET description='American River College, Fall 2022. Assembly-language programming, eight-bit data representation, digital logic, processor organization, stack frames and pointer-based programs using Tak''s Toy Processor (TTP) in Logisim. Includes an annotated recursive linked-list insertion exercise.',updated_at=now() WHERE id='cisp310' AND subject_id='computer_science';
UPDATE public.assignments SET description='Archived recursive sorted-list insertion exercise with supplied C reference code, TTP assembly and debugging annotations. The portfolio adds a semantic pointer walkthrough; assembly execution and full authorship are not independently verified.', assignment_type='Assembly debugging exercise',demo_url='/course/cisp310/assignment/linked-list',updated_at=now() WHERE id='7dd9f7fe-c099-41be-9d4a-296781038b49' AND course_id='cisp310';
UPDATE public.course_tools SET tool='Tak''s Toy Processor (TTP) / Logisim' WHERE id='2a452389-beea-4ad6-bfb8-279c2c83716a' AND course_id='cisp310';
COMMIT;
-- No new rows, tables, policies or views. Existing GitHub links and counts retained.
