struct SafetyAcc {
  let isIncreasing: Bool?
  let allSafe: Bool
}

struct Day02: AdventDay {
  let data: String

  func getData() -> [[Int]] {
    return data.split(separator: "\n")
      .map({ line in line.split(separator: /\s+/).map({ Int($0)! }) })
  }

  func safetyReducer(acc: SafetyAcc, values: (Int, Int)) -> SafetyAcc {
    let (fst, snd) = values

    let isIncreasing = fst < snd
    let difference = abs(fst - snd)
    let isSafe =
      0 < difference && difference <= 3
      && (acc.isIncreasing ?? isIncreasing) == isIncreasing

    return SafetyAcc(
      isIncreasing: acc.isIncreasing ?? isIncreasing,
      allSafe: acc.allSafe && isSafe
    )
  }

  func part1() -> Int {
    let reports = getData()
    return reports.map(isSafe)
      .count(where: { $0 })
  }

  func isSafe(report: [Int]) -> Bool {
    report.adjacentPairs()
      .reduce(
        SafetyAcc(
          isIncreasing: nil, allSafe: true),
        safetyReducer
      )
      .allSafe
  }

  func part2() -> Int {
    let reports = getData()
    return reports.map({
      report in
      guard !isSafe(report: report) else { return true }

      for i in 0..<report.count {
        var report = report
        report.remove(at: i)
        guard !isSafe(report: report) else { return true }
      }

      return false
    })
    .count(where: { $0 })
  }
}
