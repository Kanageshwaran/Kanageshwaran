import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { fetchCourseById, fetchAssignmentsByCourse } from '../../../services/portfolioService';
import { convertDays } from './conversion.mjs';
import converter from './originals/HW13.py?raw';
import model1 from './originals/model-1.py?raw';
import model2 from './originals/model-2.py?raw';
import './cisp300.css';

const base = '/course/cisp300';
const topics = [
  ['01', 'Computing & Python foundations', 'Problem solving, input/output, variables, environments and errors.'],
  ['03', 'Decisions & conditions', 'Branching, Boolean logic, comparisons and indentation.'],
  ['06–07', 'Collections & relationships', 'Lists, slicing, sets, dictionaries and nested data.'],
  ['09', 'Searching & sorting', 'Linear and binary search, selection and insertion sort, and algorithm analysis.'],
  ['10–11', 'Files & recursion', 'File input/output, CSV, context managers and recursive functions.'],
  ['13', 'Functions & grouped data', 'Functions, scope, arrays and structs; related Python time-conversion program.'],
];

function Source({ name, code }: { name: string; code: string }) {
  return <details className="c300-source"><summary>View original source · {name}</summary>
    <pre><code>{code}</code></pre>
    <a className="c300-button" href={`data:text/plain;charset=utf-8,${encodeURIComponent(code)}`} download={name}>Download {name}</a>
  </details>;
}

function TimeConverter() {
  const [input, setInput] = useState('15');
  const [result, setResult] = useState(() => convertDays('15'));
  const [error, setError] = useState('');
  const [step, setStep] = useState(0);
  const steps = [
    ['Read input', `totalDays = ${result.total}`],
    ['Create grouped data', 'ElapsedTime() → weeksVal = 0; daysVal = 0'],
    ['Compute full weeks', `${result.total} // 7 = ${result.weeks}`],
    ['Compute remaining days', `${result.total} % 7 = ${result.days}`],
    ['Return and print', result.output],
  ];
  return <>
    <p className="c300-eyebrow">Featured assignment · Python</p>
    <h1>Struct-Based Time Conversion Utility</h1>
    <p className="c300-lead">One integer becomes a small, structured result. Explore how a reusable function separates full weeks from remaining days.</p>
    <div className="c300-grid">
      <section className="c300-card">
        <h2>Try the conversion</h2>
        <p>Browser demonstration based on the original Python program.</p>
        <form onSubmit={e => { e.preventDefault(); try { setResult(convertDays(input)); setError(''); setStep(0); } catch (err) { setError((err as Error).message); } }}>
          <label htmlFor="c300-days">Total days</label>
          <input id="c300-days" type="text" inputMode="numeric" value={input} onChange={e => setInput(e.target.value)} aria-describedby={error ? 'c300-error' : 'c300-hint'} aria-invalid={!!error} />
          <p id="c300-hint">Use a nonnegative whole number.</p>
          <button className="c300-button c300-primary" type="submit">Convert days</button>
          {error && <p id="c300-error" role="alert">{error}</p>}
        </form>
      </section>
      <section className="c300-card" aria-live="polite" aria-atomic="true">
        <h2>ElapsedTime object</h2>
        <div className="c300-result"><div><strong>{result.weeks.toLocaleString()}</strong><span>weeksVal</span></div><div><strong>{result.days}</strong><span>daysVal</span></div></div>
        <p>Exact original output</p><pre>{result.output}</pre>
        <p>The original program always prints “weeks” and “days,” including when a value is 1.</p>
      </section>
    </div>
    <section className="c300-card c300-section">
      <h2>Follow the execution</h2>
      <div className="c300-steps" aria-label="Execution steps">{steps.map(([title], i) => <button key={title} onClick={() => setStep(i)} aria-pressed={step === i}>{i + 1}. {title}</button>)}</div>
      <div className="c300-trace" aria-live="polite"><h3>{steps[step][0]}</h3><code>{steps[step][1]}</code></div>
    </section>
    <section className="c300-section"><h2>The submitted approach</h2><p><code>ElapsedTime</code> groups two values in a Python class. <code>ConvertToWeeksAndDays</code> computes integer division and remainder, then returns that object. <code>main</code> handles console input and formatted output. This is modular arithmetic and functional decomposition; the program does not use recursive divide-and-conquer.</p>
      <Source name="HW13.py" code={converter} />
    </section>
    <section className="c300-section"><h2>Examples & boundaries</h2><div className="c300-table"><table><thead><tr><th>Input</th><th>Original output / behavior</th></tr></thead><tbody>{['0', '6', '7', '15', '365'].map(n => <tr key={n}><td>{n}</td><td><code>{convertDays(n).output}</code></td></tr>)}<tr><td>-1</td><td>Original: -1 weeks 6 days. Demo rejects negative values.</td></tr><tr><td>Text or decimals</td><td>Original raises ValueError. Demo explains the validation error.</td></tr></tbody></table></div><p>The browser adds input validation and limits values to JavaScript safe integers. The Python submission is preserved unchanged.</p></section>
  </>;
}

function Basics() {
  const [example, setExample] = useState(0);
  const [ran, setRan] = useState(false);
  return <><p className="c300-eyebrow">Original programs · Foundations</p><h1>Python Output Basics</h1><p className="c300-lead">Two small scripts explore literal output, variables, separators and newlines.</p>
    <div className="c300-steps">{['Hello world', 'Variables & formatting'].map((name, i) => <button key={name} aria-pressed={example === i} onClick={() => {setExample(i); setRan(false);}}>{name}</button>)}</div>
    <Source name={example ? 'model 2.py' : 'model 1.py'} code={example ? model2 : model1} />
    <section className="c300-card c300-section"><h2>Output preview</h2><p>This preview displays verified output; it does not execute Python in your browser.</p><button className="c300-button c300-primary" onClick={() => setRan(true)}>Show verified output</button><pre aria-live="polite">{ran ? (example ? 'number  21 \nhi\n' : 'hello world\n') : 'Select “Show verified output” to begin.'}</pre><p>{example ? 'num stores 21. print adds its default separator after the string’s existing space. end adds a trailing space; the next print creates a newline. The final print writes hi.' : 'print writes the literal string hello world, followed by its default newline.'}</p></section>
    <p>The files are grouped by their introductory content. Their filenames do not establish an official assignment number.</p></>;
}

export function Cisp300() {
  const { assignmentSlug } = useParams();
  const [state, setState] = useState<{ loading: boolean; error: string; course: any; assignments: any[] }>({ loading: true, error: '', course: null, assignments: [] });
  const [retry, setRetry] = useState(0);
  useEffect(() => {
    let active = true;
    setState(s => ({...s, loading: true, error: ''}));
    (async () => {
      try {
        const [course, assignments] = await Promise.all([fetchCourseById('cisp300'), fetchAssignmentsByCourse('cisp300')]);
        if (course.error) throw course.error;
        if (assignments.error) throw assignments.error;
        if (!course.data?.is_visible) throw new Error('This course is not available.');
        if (active) setState({ loading: false, error: '', course: course.data, assignments: assignments.data ?? [] });
      } catch (err) { if (active) setState({ loading: false, error: (err as Error).message || 'Unable to load course.', course: null, assignments: [] }); }
    })();
    return () => {active = false;};
  }, [retry]);
  const title = assignmentSlug === 'time-conversion' ? 'Time Conversion' : assignmentSlug === 'python-output-basics' ? 'Python Output Basics' : 'CISP 300';
  useEffect(() => { const before = document.title; document.title = `${title} | Academic Portfolio`; window.scrollTo(0, 0); return () => {document.title = before;}; }, [title]);
  const current = state.assignments.find(a => a.id === '532581be-6701-4aac-8aea-0f9c87a515ac');
  return <article className="c300">
    <nav className="c300-breadcrumb" aria-label="Course navigation"><Link to="/subject/computer_science">← Computer Science</Link>{assignmentSlug && <Link to={base}>CISP 300 overview</Link>}</nav>
    {state.loading ? <p role="status">Loading CISP 300…</p> : state.error ? <section role="alert" className="c300-card"><h1>Course unavailable</h1><p>{state.error}</p><button className="c300-button" onClick={() => setRetry(n => n + 1)}>Try again</button></section> : assignmentSlug ? assignmentSlug === 'time-conversion' ? current ? <><TimeConverter />{(current.github_link || current.github_url) && <a className="c300-button" href={current.github_link || current.github_url} target="_blank" rel="noopener noreferrer">View original repository ↗</a>}</> : <h1>Assignment unavailable</h1> : assignmentSlug === 'python-output-basics' ? <Basics /> : <><h1>Assignment not found</h1><Link to={base}>Return to course</Link></> : <>
      <header><p className="c300-eyebrow">American River College · {state.course.term || 'Fall 2019'} · Python</p><h1>From a problem<br />to a working program.</h1><p className="c300-lead">{state.course.name}</p><p>Explore the decisions, data and small reusable steps behind my introductory programming work.</p><a className="c300-button c300-primary" href="#c300-work">Explore my work ↓</a></header>
      <section id="c300-work" className="c300-section"><p className="c300-eyebrow">The work</p><h2>Small programs. Visible thinking.</h2><div className="c300-grid">{current && <Link className="c300-card c300-work" to={`${base}/assignment/time-conversion`}><span className="c300-tag">Featured · Interactive demo</span><h3>{current.title}</h3><p>A total-day input becomes weeks and remaining days. Inspect the grouped result and trace each calculation.</p><span>Explore the utility →</span></Link>}<Link className="c300-card c300-work" to={`${base}/assignment/python-output-basics`}><span className="c300-tag">Two original scripts</span><h3>Python Output Basics</h3><p>Start with hello world, then inspect variables, spaces and newlines through verified console output.</p><span>Open the walkthrough →</span></Link></div></section>
      <section className="c300-section"><p className="c300-eyebrow">Course coverage</p><h2>A learning journey</h2><p>Topics summarized from the readable course materials. These are learning topics, not a claim that every textbook exercise is a completed project.</p><ol className="c300-journey">{topics.map(([num, heading, text]) => <li key={num}><span>{num}</span><div><h3>{heading}</h3><p>{text}</p></div></li>)}</ol></section>
      <section className="c300-card c300-section"><h2>Concepts in context</h2><p>The supporting comparison workbook covers 14 concepts: recursion, functions, lists, dictionaries, binary search, sets, structs, tuples, selection sort, insertion sort, linear search, CSV files, context managers and factorial.</p><p>The course archive also includes lesson exports and a software-development roles reference. They inform these original summaries and are kept separate from the program submissions.</p></section>
    </>}
  </article>;
}
