//
//  main.swift
//  1916 - 최소비용 구하기
//

import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!

var graph = Array(repeating: Array<(Int, Int)>(), count: n + 1)

for _ in 0..<m {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (s, e, c) = (input[0], input[1], input[2])
    graph[s].append((c, e))
}

for i in 1..<n + 1 {
    graph[i].sort(by: <)
}

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (s, e) = (input[0], input[1])

func dijkstra(from s: Int, to e: Int) -> Int {
    var distance = Array(repeating: Int(1e9), count: n + 1)
    distance[s] = 0
    var heap = Heap { $0.0 < $1.0 }
    heap.push(element: (0, s))

    while let (acc, value) = heap.pop() {
        if distance[value] < acc { continue }

        for (cost, nxt) in graph[value] {
            if distance[nxt] > acc + cost {
                distance[nxt] = acc + cost
                heap.push(element: (acc + cost, nxt))
            }
        }
    }
    return distance[e]
}

let answer = dijkstra(from: s, to: e)
print(answer)

struct Heap {
    private var elements: [(cost: Int, num: Int)] = []
    private let isHighPriority: ((Int, Int), (Int, Int)) -> Bool
    var count: Int { elements.count }

    init(by: @escaping ((Int, Int), (Int, Int)) -> Bool) {
        isHighPriority = by
    }

    mutating func push(element: (Int, Int)) {
        elements.append(element)
        shiftUp(from: elements.count - 1)
    }

    mutating func pop() -> (Int, Int)? {
        guard !elements.isEmpty else { return nil }

        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        shiftDown(from: 0)
        return value
    }

    private mutating func shiftUp(from idx: Int) {
        var child = idx

        while child > 0 {
            let parent = (child - 1) / 2
            if isHighPriority(elements[child], elements[parent]) {
                elements.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }

    private mutating func shiftDown(from idx: Int) {
        var parent = idx

        while true {
            var candidate = parent

            let leftChild = parent * 2 + 1
            let rightChild = parent * 2 + 2

            if leftChild < elements.count && isHighPriority(elements[leftChild], elements[candidate]) {
                candidate = leftChild
            }

            if rightChild < elements.count && isHighPriority(elements[rightChild], elements[candidate]) {
                candidate = rightChild
            }

            if parent == candidate { return }

            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
