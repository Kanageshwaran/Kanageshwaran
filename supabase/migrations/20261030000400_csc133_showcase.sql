BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc133' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 133 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='78f62b3b-e98c-406d-ae69-fa47f41df6e0' AND course_id='csc133') THEN RAISE EXCEPTION 'CSC 133 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Spring 2025. Nine Java/IntelliJ coursework stages: OpenGL setup, board input, I/O separation, machine opponent, singleton window manager, reusable rendering, ping-pong arrays, binary arrays/tests and Conway Game of Life. Original source is paired with clearly labeled browser teaching models; native graphics execution is not claimed.' WHERE id='csc133';
UPDATE public.assignments SET title='Java Graphics and Game of Life Studio', description='Final coursework combines a toroidal Game of Life data model with window, renderer and geometry classes. The showcase also includes all eight earlier assignments, original Java files, fixtures, helper/variant records, double-buffer visualization and new deterministic browser checks. Simulations do not compile Java or connect to IntelliJ.', assignment_type='Java / OOP / Computer graphics', demo_url='/course/csc133/assignment/game-of-life' WHERE id='78f62b3b-e98c-406d-ae69-fa47f41df6e0' AND course_id='csc133';
COMMIT;
