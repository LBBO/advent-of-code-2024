import Testing

@testable import AdventOfCode

struct Day02Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    
    """

  @Test func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: try challenge.part1()) == "2")
  }

  @Test func testFirstDeleteableInc() async throws {
    let challenge = Day02(data: "1 5 6 7 8")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testFirstDeleteableDec() async throws {
    let challenge = Day02(data: "9 4 3 2 1")
    #expect(String(describing: try challenge.part2()) == "1")
  }

  @Test func testLastDeleteableInc() async throws {
    let challenge = Day02(data: "1 2 3 4 9")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testLastDeleteableDec() async throws {
    let challenge = Day02(data: "9 8 7 6 1")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testMultipleIssues() async throws {
    let challenge = Day02(data: "1 2 7 8 9")
    #expect(String(describing: try challenge.part2()) == "0")
  }
  
  @Test func testDeleteFirstChangeOrder() async throws {
    let challenge = Day02(data: "1 9 8 7 6")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testDeleteSecondChangeOrder() async throws {
    let challenge = Day02(data: "5 6 4 3 2")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testDeleteLastChangeOrder() async throws {
    let challenge = Day02(data: "1 2 3 4 5 4")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func testDeleteSecondToLastChangeOrder() async throws {
    let challenge = Day02(data: "1 2 3 4 5 4 6")
    #expect(String(describing: try challenge.part2()) == "1")
  }
  
  @Test func someTestCase() async throws {
    let challenge = Day02(data: "8 7 7 10 11 15")
    #expect(String(describing: try challenge.part2()) == "0")
  }

  @Test func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: try challenge.part2()) == "4")
  }
}
