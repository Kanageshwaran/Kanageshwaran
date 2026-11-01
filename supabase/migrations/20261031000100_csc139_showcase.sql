BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc139' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 139 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b94cf096-fa77-4632-8b12-e2877af1a345' AND course_id='csc139') THEN RAISE EXCEPTION 'CSC 139 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2025. Operating System Principles: CPU scheduling, MLFQ/lottery exercises, managed memory and first-fit allocation, block Huffman signatures, fork/pipe orchestration, pthread synchronization, allocator optimization and virtual-memory/persistence concepts. Original project source, scheduling traces and experimental evidence accompany bounded visual models and explicit review limits.' WHERE id='csc139';
UPDATE public.assignments SET title='Operating Systems Visual Workbench', description='Explore the C scheduler, faux-file-hasher and threaded allocator project progression through dispatch timelines, ready queues, heap diagrams, Huffman trees, controlled interleavings and recorded performance comparisons. Read all eight code files and eleven answer records, inspect native check results and distinguish archived failures from new reference simulations.', assignment_type='C / Scheduling / Managed memory / Concurrency', demo_url='/course/csc139/assignment/scheduling' WHERE id='b94cf096-fa77-4632-8b12-e2877af1a345' AND course_id='csc139';
COMMIT;
