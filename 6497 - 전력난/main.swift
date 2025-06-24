//
//  main.swift
//  6497 - 전력난
//

import Foundation
let file = FileIO()

while true {
    let m = file.readInt()
    let n = file.readInt()
    
    guard m != 0 && n != 0 else { break }
    
    var edges = Array<(Int, Int, Int)>()
    var parents = Array<Int>()
    
    for i in 0..<m {
        parents.append(i)
    }
    
    for _ in 0..<n {
        let x = file.readInt()
        let y = file.readInt()
        let weight = file.readInt()
        edges.append((weight, x, y))
    }
    edges.sort(by: <)
    
    var total = 0
    var answer = 0
    
    for edge in edges {
        let (weight, x, y) = edge
        total += weight
        let (px, py) = (find(&parents, x), find(&parents, y))
        
        guard px != py else { continue }
        
        union(&parents, x, y)
        answer += weight
    }
    print(total - answer)
}

func find(_ parents: inout [Int], _ x: Int) -> Int {
    if parents[x] != x {
        parents[x] = find(&parents, parents[x])
    }
    return parents[x]
}

func union(_ parents: inout [Int], _ x: Int, _ y: Int) {
    let (px, py) = (find(&parents, x), find(&parents, y))
    
    if px < py {
        parents[py] = px
    } else {
        parents[px] = py
    }
}

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(try! fileHandle.readToEnd()!) + [UInt8(0)]
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isNegative = false

        while now == 10 || now == 32 { now = read() }

        if now == 45 {
            isNegative = true
            now = read()
        }

        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now - 48)
            now = read()
        }

        return sum * (isNegative ? -1 : 1)
    }
}
