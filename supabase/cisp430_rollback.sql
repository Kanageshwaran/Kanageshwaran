BEGIN;
DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM public.courses WHERE id='cisp430' AND subject_id='computer_science') THEN RAISE EXCEPTION 'CISP 430 course missing or wrong subject'; END IF;
 IF (SELECT count(*) FROM public.assignments WHERE course_id='cisp430' AND id IN ('7c7ddad2-e6cb-41a9-975e-bcf9f509a8a0','dc6859c4-de0c-4247-82d4-b8abe6fbbceb'))<>2 THEN RAISE EXCEPTION 'Expected CISP 430 assignment IDs missing'; END IF;
END $$;
-- Restores only fields changed by this package from the supplied CSV snapshot.
UPDATE public.courses SET description='Topics: Abstraction, stacks, queues, trees, graphs, sorting/searching, Big-O.
Methodologies: OOP Problem Solving, Algorithm Analysis, Data Structure Implementation.
Project Example: Library management using trees/hash tables for tracking and searching.
Featured Projects: Sorted Doubly Linked List Manager; Dijkstra’s Shortest Path.' WHERE id='cisp430';
UPDATE public.assignments SET title='Sorted Doubly Linked List Manager', description='Designed and implemented core data structures with algorithm analysis (Big-O) and practical operations like insert/delete/search.', assignment_type='', demo_url='' WHERE id='7c7ddad2-e6cb-41a9-975e-bcf9f509a8a0' AND course_id='cisp430';
UPDATE public.assignments SET title='Dijkstra’s Shortest Path Algorithm Implementation', description='Implemented shortest-path logic using graph structures and algorithmic reasoning, emphasizing correctness and efficiency.', assignment_type='', demo_url='' WHERE id='dc6859c4-de0c-4247-82d4-b8abe6fbbceb' AND course_id='cisp430';
COMMIT;
