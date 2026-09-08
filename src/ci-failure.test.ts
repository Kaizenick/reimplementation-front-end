import { expect, test } from 'vitest';

test('CI rejects a failing frontend test', () => {
  expect(true).toBe(false);
});
