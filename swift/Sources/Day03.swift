struct Day03: AdventDay {
  let data: String

  func count(input: String) -> Int {
    let matches = input.matches(of: /mul\((\d{1,3}),(\d{1,3})\)/)
    return matches.map({ match in Int(match.output.1)! * Int(match.output.2)! })
      .reduce(0, +)
  }

  func part1() -> Int {
    count(input: data)
  }

  // 129_087_088 too high
  func part2() -> Int {
    var data = data
    data.replace(/don't\(\)[\s\S]*?do\(\)/, with: "")
    data.replace(/don't\(\)[\s\S]*?$/, with: "")
    return count(input: data)
  }
}
