export function convertDays(raw) {
  const text = String(raw).trim();
  if (!/^\d+$/.test(text)) throw new Error('Enter a whole number of days, zero or greater.');
  const total = Number(text);
  if (!Number.isSafeInteger(total)) throw new Error('Enter a number no larger than 9,007,199,254,740,991.');
  const weeks = Math.floor(total / 7);
  const days = total % 7;
  return { total, weeks, days, output: `${weeks} weeks ${days} days` };
}
