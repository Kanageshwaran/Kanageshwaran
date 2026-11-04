-- Restore supplied CSV snapshot fields; review against any newer live edits before use.
BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc154' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 154 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='951d86ba-92b4-44cc-846e-8af4b7402d66' AND course_id='csc154') THEN RAISE EXCEPTION 'CSC 154 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Intrusion, malware, DDoS, buffer overflow, and secure defenses.' WHERE id='csc154';
UPDATE public.assignments SET title='Project Example', description='Exploited a vulnerable web application and implemented defenses.', assignment_type='', demo_url='' WHERE id='951d86ba-92b4-44cc-846e-8af4b7402d66' AND course_id='csc154';
COMMIT;
