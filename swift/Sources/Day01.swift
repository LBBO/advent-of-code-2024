extension Collection where Self.Iterator.Element: RandomAccessCollection {
  // PRECONDITION: `self` must be rectangular, i.e. every row has equal size.
  func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
    guard let firstRow = self.first else { return [] }
    return firstRow.indices.map { index in
      self.map { $0[index] }
    }
  }
}

struct Day01: AdventDay {
  var data: String
  
  func getTransposedLists() -> ([Int], [Int]) {
    let lists = data.split(separator: "\n")
      .map({ line in line.split(separator: /\s+/).compactMap({ Int($0) }) })
      .transposed()
    let a = lists[0]
    let b = lists[1]
    return (a, b)
  }
  
  func getSortedLists() -> ([Int], [Int]) {
    let (a, b) = getTransposedLists()
    let sortedA = a.sorted()
    let sortedB = b.sorted()
    return (sortedA, sortedB)
  }

  func part1() throws -> Int {
    let (a, b) = getSortedLists()
    return a.enumerated()
      .map({ (index, value) in abs(value - b[index])})
      .reduce(0, +)
  }
  
  func part2() throws -> Int {
    let (a, b) = getTransposedLists()
    return a.map({ x in b.count(where: { y in x == y }) * x })
      .reduce(0, +)
  }
}
