BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc134' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 134 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='8e351830-7b4a-46a0-94de-e780f22ffd27' AND course_id='csc134') THEN RAISE EXCEPTION 'CSC 134 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2024. Retail ER design and relational mapping, relational algebra, an eight-table MySQL academic schema and eight submitted SQL queries, plus a team DynamoDB research presentation. The showcase pairs prepared query code with local result tables and credits DK as presentation opener (user-supplied role) and supported-data-models presenter (slide attribution).' WHERE id='csc134';
UPDATE public.assignments SET title='SQL Workbench and DynamoDB Team Presentation', description='Explore individual relational database coursework and the Dynamites team presentation. Original SQL and archived sample data are preserved; offline SQLite validation and new local browser query models power side-by-side results. Optional expanded fixtures are explicitly new. Includes group presentation evidence and DK opening/data-model contributions; no live MySQL, AWS or general SQL execution service is claimed.', assignment_type='Database design / SQL / Team research', demo_url='/course/csc134/assignment/sql-studio' WHERE id='8e351830-7b4a-46a0-94de-e780f22ffd27' AND course_id='csc134';
COMMIT;
