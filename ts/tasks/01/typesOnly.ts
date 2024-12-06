import { Number } from 'ts-toolbelt'

/**
 * First off, some explanations:
 * 
 * Use `infer` to extract a specific sub-type out of a larger type
 * [1, true] extends [infer A, infer B] ? { first: A, second: B} : never
 * => { first: 1, second: true }
 * 'My name is Michael' extends `My name is ${infer Name}` ? Name : never
 * => 'Michael'
 * 
 * Sometimes, we want something like `const x = f(myValue); doSomething(x)`.
 * This allows you to use the result of a function in multiple places.
 * In type-land, we do that like this:
 * SomeGeneric<MyType> extends infer Result ? AnotherGeneric<Result, Result> : never
 * 
 * However, the `extends infer X` will then result in an X with no extra information,
 * meaning you can only use X as an `unknown`. To fix this, we just add the type information
 * we already know about X:
 * 
 * type SomeGeneric<MyType> = [something that extends number]
 * -> SomeGeneric<MyType> extends (infer Result extends number) ? ... : never
 * (technically this adds an extra assertion, namely that SomeGeneric<MyType> extends number,
 * but if that's a given, it's fine)
 */


// Convert input to the two list of numbers, so [number[], number[]]
type InferNumbers<S extends string> =
  // Base case -> return two empty lists
  S extends ''
  ? [[], []]
  // get A and B, rest (which will start with \n except for the last time)
  // -> compute recursive result, then prepend A and B to their lists
  : (S extends `${infer A extends number}   ${infer B extends number}\n${infer Rest}`
    // const [As, Bs] = InferNumbers<Rest>
    ? (InferNumbers<Rest> extends [infer As extends number[], infer Bs extends number[]]
      // add current result to recursive result
      ? [[A, ...As], [B, ...Bs]]
      // should never occur since we're just deconstructing in the extends check
      : never
    )
    : [[], []]
  )

// Bubble Sort as types
type Min<A extends number, B extends number> = Number.Lower<A, B> extends 1 ? A : B

// Get minimum of entire array
type MinOfArr<Arr extends number[]> =
  // If we have >= 2 items, return min(first, min(rest))
  Arr extends [infer A extends number, infer B extends number, ...infer Rest extends number[]]
  ? Min<A, MinOfArr<[B, ...Rest]>>
  : (
    // only 1 item -> minimum
    Arr extends [infer A extends number] ? A : never
  )

// Return all of Arr without the first occurrence of Target
type DeleteFirst<Target, Arr extends unknown[]> =
  Arr extends [infer Curr, ...infer Rest]
  // if curr === target -> return rest
  ? (Curr extends Target
    ? Rest
    // delete first target in rest, then prepend curr again
    : [Curr, ...DeleteFirst<Target, Rest>]
  )
  // Base case -> return []
  : []

// Find the min and return both it and the array except for the (first) minimum
type DeleteMin<Arr extends number[]> =
  // const Min: number = MinOfArr<Arr>
  MinOfArr<Arr> extends (infer Min extends number)
  ? [Min, DeleteFirst<Min, Arr>]
  : []

type BubbleSort<Arr extends number[]> =
  // Base case -> []
  Arr extends []
  ? []
  // const [min, rest] = DeleteMin<Arr>
  : (
    DeleteMin<Arr> extends [infer min extends number, infer rest extends number[]]
    ? [min, ...BubbleSort<rest>]
    : never
  )

// Final assembly
type AddDifferences<As extends number[], Bs extends number[]> =
  // const [[A, ...As], [B, ...Bs]] = Input
  [As, Bs] extends [[infer A extends number, ...infer As extends number[]], [infer B extends number, ...infer Bs extends number[]]]
  // Math.abs(A - B) + AddDifferences([As, Bs])
  ? Number.Add<Number.Absolute<Number.Sub<A, B>>, AddDifferences<As, Bs>>
  // No first elements -> base case of sum is 0
  : 0

type Input = `3   4
4   3
2   5
1   3
3   9
3   3
`

type Numbers = InferNumbers<Input>
type Sorted = [BubbleSort<Numbers[0]>, BubbleSort<Numbers[1]>]

type Result = AddDifferences<Sorted[0], Sorted[1]>
