import { run, bench } from 'mitata';

let test = '{"user_id":"cnpTcksoUFZIOzc6bkNDW3Yl","trace_id":"cnpTcksoUFZIOzc6bkNDW3Yl","properties":{"method":"GET","path":"/free_cookies"},"host":"myagent1","service":"cookies"}';
let dump = JSON.parse(test);

bench('JSON.stringify', () => JSON.stringify(dump));
bench('JSON.parse', () => JSON.parse(test));

await run();