import { join } from "@std/path";
import _ from "lodash";
import { z } from "zod";

const input = (
  await Deno.readTextFile(
    // join(import.meta.dirname, "../../../inputs/01/testInput.txt"),
    join(import.meta.dirname, "../../../inputs/01/input.txt"),
  )
).trim();

const sortedNumbersSchema = z
  .array(z.coerce.number())
  .transform((list) => list.toSorted((a, b) => a - b));

const add = (a: number, b: number) => a + b;

const listsSchema = z
  .string()
  .transform((input) =>
    _.zip(...input.split("\n").map((line) => line.split(/\s+/))),
  )
  .pipe(z.array(sortedNumbersSchema));

const task1Schema = listsSchema.transform(([a, b]) => {
  const differences = _.zip(a, b).map(([a, b]) => Math.abs(a - b));
  return differences.reduce(add, 0);
});

const task2Schema = listsSchema.transform(([a, b]) => {
  return a
    .map((x) => {
      const firstIndex = b.indexOf(x);
      if (firstIndex === -1) {
        return 0;
      }

      const lastIndex = b.lastIndexOf(x);

      return x * (lastIndex - firstIndex + 1);
    })
    .reduce(add, 0);
});

// console.log(task1Schema.parse(input));
console.log(task2Schema.parse(input));
