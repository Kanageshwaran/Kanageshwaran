BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc137' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 137 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='2355a108-bb83-4e2c-ae8a-6c4b8280a7a7' AND course_id='csc137') THEN RAISE EXCEPTION 'CSC 137 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2024. Computer Organization coursework spanning custom floating point, Boolean/NAND logic, full adders and multiplexers, Logisim latch/flip-flop experiments, sequence recognizers, critical paths, pipelining, NRZI, memory bandwidth, an accumulator CPU datapath and a group quantum-computing presentation. Original homework pages and explanations accompany new bounded interactive models and qualified review notes.' WHERE id='csc137';
UPDATE public.assignments SET title='Circuit and Computer Organization Workbench', description='Explore eight homework sets through live gate diagrams, source-based Logisim wiring views, state traces, waveform histories, pipeline schedules, bandwidth calculations and a reference CPU bench. Read original handwritten component explanations and compare assumptions or corrections with the submitted pages. Includes original .circ downloads and clearly separated presentation/AI-exploration material.', assignment_type='Digital logic / Logisim / Computer organization', demo_url='/course/csc137/assignment/storage' WHERE id='2355a108-bb83-4e2c-ae8a-6c4b8280a7a7' AND course_id='csc137';
COMMIT;
