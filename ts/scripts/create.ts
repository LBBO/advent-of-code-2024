import { parseArgs } from "@std/cli";
import { z } from "zod";

const rawArgs = parseArgs(Deno.args);
const argsSchema = z.object({
  _: z.coerce.number(),
});
const args = argsSchema.parse(rawArgs);
