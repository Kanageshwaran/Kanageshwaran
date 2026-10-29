BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp440' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CISP 440 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='c8a46bff-69e6-4246-ae32-da210403ab31' AND course_id='cisp440') THEN RAISE EXCEPTION 'CISP 440 featured assignment missing'; END IF;
END $$;
-- Snapshot rollback: use before later intentional metadata edits.
UPDATE public.courses SET description='Topics: Sets, logic, proofs, counting, graphs, trees, discrete probability.
Methodologies: Logic/Proof Techniques, Graph/Tree Theory, Discrete Probability and Combinatorics.
Project Example: Network optimization / shortest path using graph theory.
Featured Project: A* Heuristic Design and Algorithm Trace Analysis.' WHERE id='cisp440';
UPDATE public.assignments SET title='A* Heuristic Design and Algorithm Trace Analysis', description='Worked with discrete math foundations (proofs, graphs, combinatorics) and applied them to heuristic search reasoning and algorithm tracing.', assignment_type='', demo_url='' WHERE id='c8a46bff-69e6-4246-ae32-da210403ab31' AND course_id='cisp440';
COMMIT;
