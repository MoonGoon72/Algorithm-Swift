//
//  main.swift
//  10825 - 국영수
//

import Foundation

let n = Int(readLine()!)!

var students: [(String, Int, Int, Int)] = []

for _ in 0..<n {
    let input = readLine()!.components(separatedBy: " ")
    let student = (input[0], Int(input[1])!, Int(input[2])!, Int(input[3])!)
    students.append(student)
}

students.sort { (-$0.1, $0.2, -$0.3, $0.0) < (-$1.1, $1.2, -$1.3, $1.0) }

for i in 0..<n {
    print(students[i].0)
}
