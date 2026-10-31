BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc135' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 135 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='46872389-2555-4c24-9ab7-1ab5333cfaa9' AND course_id='csc135') THEN RAISE EXCEPTION 'CSC 135 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2025. Computability and formal languages coursework: DFA design/minimization/products, NFA and regular expressions, CFG/parse trees/CNF/GNF, PDA stacks, Turing-machine language prompts and pumping-lemma practice. Original handwritten pages sit beside new visual reference models, counterexamples and explicitly limited correctness reviews.' WHERE id='csc135';
UPDATE public.assignments SET title='Visual Automata, Grammars and Computability Lab', description='Explore state traces, reachable NFA subsets, parse trees, grammar membership, cancellation stacks and a tape trace. Preserves correct minimization/product work and shows specific grammar, PDA and pumping-note corrections. Original scans, new solutions, prompt ambiguities and unverified handwritten edges are clearly distinguished. Finite model checks supplement mathematical explanations and do not reconstruct instructor grades.', assignment_type='Formal languages / Visual models / Reviewed work', demo_url='/course/csc135/assignment/dfa' WHERE id='46872389-2555-4c24-9ab7-1ab5333cfaa9' AND course_id='csc135';
COMMIT;
