BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc154' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 154 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='951d86ba-92b4-44cc-846e-8af4b7402d66' AND course_id='csc154') THEN RAISE EXCEPTION 'CSC 154 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Summer 2025. Computer System Attacks and Countermeasures: a group Flask employee portal with SQLAlchemy, PostgreSQL, Jinja, Docker and Nginx; PKI/HTTPS, SQL injection and prepared statements, XSS/CSP, access control and cryptographic reasoning. Original source views, lab code screenshots, bounded verification and reviewed corrections explain what the code does, how and why.' WHERE id='csc154';
UPDATE public.assignments SET title='Security Implementation Studio', description='Explore eight visual security studio pages: employee/admin access, Docker request flow, certificate trust, SQL code/data boundaries, XSS/CSP decisions, UNIX permissions and toy RSA, annotated Python/HTML/configuration walkthroughs, and source/evidence review. Includes 72 source records, 336-file inventory and 28 bounded Flask route checks. Browser demonstrations use synthetic data; archived private keys are omitted.', assignment_type='Python / Flask / Docker / PKI / Web security', demo_url='/course/csc154/assignment/portal' WHERE id='951d86ba-92b4-44cc-846e-8af4b7402d66' AND course_id='csc154';
COMMIT;
