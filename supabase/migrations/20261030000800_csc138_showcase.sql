BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc138' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 138 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b5906c95-59a0-4d8c-a0f7-1aa3dfb347f4' AND course_id='csc138') THEN RAISE EXCEPTION 'CSC 138 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2024. Computer Networking Fundamentals: Java xargs command construction, threaded TCP client/server chat, HTTP/HTTPS server variants, packet-capture analysis, addressing and network performance. Original source and assignment briefs accompany new browser models, anonymized capture metadata and explicit review notes.' WHERE id='csc138';
UPDATE public.assignments SET title='Java Networking and Packet Observatory', description='Explore three Java project families through argument batching, virtual client-handler message routing and an HTTP request desk. Inspect anonymized metadata from both original captures, read all eight Java files, and compare archived implementation details with labeled reference repairs. Includes new addressing/delay explainers and a complete source inventory.', assignment_type='Java / TCP chat / HTTP / Packet analysis', demo_url='/course/csc138/assignment/chat' WHERE id='b5906c95-59a0-4d8c-a0f7-1aa3dfb347f4' AND course_id='csc138';
COMMIT;
