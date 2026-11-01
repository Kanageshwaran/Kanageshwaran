BEGIN;
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='csc148' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CSC 148 course missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM public.assignments WHERE id='b44037e3-dfcd-46dc-ae72-b176ee103c48' AND course_id='csc148') THEN RAISE EXCEPTION 'CSC 148 assignment missing'; END IF;
END $$;
UPDATE public.courses SET description='Sacramento State, Fall 2025. Modeling and Experimental Design: discrete-event GPSS queue and parallel-server models, traffic observations and Poisson distribution fitting, and SimPy inventory/restocking with interrupts and shared events. Original model source, 21 saved histograms, captured Python execution graphs and explicit statistical review accompany new bounded browser explainers.' WHERE id='csc148';
UPDATE public.assignments SET title='Simulation and Experimental Design Studio', description='Explore three labs and five homework sequences through event timelines, seeded histograms, queue comparisons, recorded server-capacity experiments, a 253-vehicle traffic study, five-site inventory drawdown and a ten-site restocking replay. Inspect original GPSS/Python files, eleven saved reports and the complete 1212-file inventory; recorded results and new interpretations are labeled.', assignment_type='GPSS / Python / SimPy / Statistical modeling', demo_url='/course/csc148/assignment/events' WHERE id='b44037e3-dfcd-46dc-ae72-b176ee103c48' AND course_id='csc148';
COMMIT;
