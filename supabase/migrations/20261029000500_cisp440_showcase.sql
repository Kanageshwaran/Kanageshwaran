BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp440' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CISP 440 course missing or wrong subject'; END IF;
 IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='c8a46bff-69e6-4246-ae32-da210403ab31' AND course_id='cisp440') THEN RAISE EXCEPTION 'CISP 440 featured assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Discrete structures coursework at American River College, Fall 2023: Boolean logic, sets, quantifiers, counting and graph reasoning. Archived A* worksheets record path-cost and predecessor updates, including a reopened vertex. C++ counting variants provide an enumeration example with documented undercounts in some categories. Browser models distinguish original evidence from new explanatory reconstructions.' WHERE id='cisp440';
UPDATE public.assignments SET title='A* Heuristic Design and Algorithm Trace Analysis', description='Analyzed A* worksheet values for open sets, g/f costs and predecessors. The supplied trace revisits c after a cheaper path is found and lowers the goal cost from 10 to 8 to 7. The browser model reconstructs the observed directed transitions, explains heuristic inconsistency and reopening, and preserves both original workbooks. It is a new explanatory model, not an archived complete A* implementation.', assignment_type='Worksheet / Heuristic search trace', demo_url='/course/cisp440/assignment/astar' WHERE id='c8a46bff-69e6-4246-ae32-da210403ab31' AND course_id='cisp440';
COMMIT;
