-- Based on the supplied Spring 2023 syllabus: Java, not the CV/database's C++ label.
BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp401' AND subject_id='computer_science') THEN RAISE EXCEPTION 'Expected CISP 401 course missing'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b96b83d1-2745-4cd3-b85e-e3600d59e120' AND course_id='cisp401') THEN RAISE EXCEPTION 'Expected calculator assignment missing'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.course_tools WHERE id='15aead95-618c-428f-86ce-45c6230c78c6' AND course_id='cisp401') THEN RAISE EXCEPTION 'Expected tool record missing'; END IF;
END $$;
UPDATE public.courses SET name='CISP 401 - Object Oriented Programming using Java',description='American River College, Spring 2023. Java objects, inheritance, polymorphism, abstract classes, exceptions and Swing interfaces. Archive includes calculator variants, an employee hierarchy and a bank-array scaffold. Browser adaptations explain tested methods and distinguish incomplete drafts.',updated_at=now() WHERE id='cisp401' AND subject_id='computer_science';
UPDATE public.assignments SET description='Archived Java Swing calculator variants. SimpleCalc.java compiled and its panel passed selected arithmetic, validation and clear checks. The portfolio provides a browser adaptation and preserves incomplete keypad drafts separately.',assignment_type='Java Swing GUI',demo_url='/course/cisp401/assignment/calculator',updated_at=now() WHERE id='b96b83d1-2745-4cd3-b85e-e3600d59e120' AND course_id='cisp401';
UPDATE public.course_tools SET tool='Java / Swing' WHERE id='15aead95-618c-428f-86ce-45c6230c78c6' AND course_id='cisp401';
COMMIT;
-- IDs, counts, term, sort order and GitHub links retained; no rows/tables added.
