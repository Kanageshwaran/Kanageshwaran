BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc163' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 163 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='26907786-0bfa-4d09-a6bb-29d5df874d43' AND course_id='csc163') THEN RAISE EXCEPTION 'CSC 163 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2025. Parallel Programming with GPUs: CUDA tiled RGB convolution, thread and shared-memory mapping, vector/matrix patterns, inclusive scan, saturated histograms and OpenCL host lifecycle. Original submission, supplied scaffolds, five archived runs and new CPU reference checks are clearly distinguished.' WHERE id='csc163';
UPDATE public.assignments SET title='Parallel GPU Studio', description='Eight interactive GPU studio pages show real convolution image fixtures and pixel products, 20x20 thread blocks and 16x16 outputs, shared-memory reuse, matrix/vector models, scan and histogram stages, OpenCL lifecycle, recorded timings and original source review. No live GPU service is required.', assignment_type='CUDA / C++ / OpenCL / Parallel algorithms', demo_url='/course/csc163/assignment/convolution' WHERE id='26907786-0bfa-4d09-a6bb-29d5df874d43' AND course_id='csc163';
COMMIT;
