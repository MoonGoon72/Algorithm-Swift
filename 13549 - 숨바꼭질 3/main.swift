//
//  main.swift
//  13549 - 숨바꼭질 3
//

import Foundation
typealias Element = (Int, Int)

struct Heap {
    private var elements: [Element] = []
    private let isHighPriority: ((Element, Element) -> Bool)
    var count: Int { elements.count }

    init(sorted: @escaping ((Element, Element) -> Bool)) {
        isHighPriority = sorted
    }

    mutating func push(_ element: (Int, Int)) {
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

            if parent == candidate {
                return
            }

            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }
}

let input = readLine()!.split(separator: " ").compactMap { Int($0) }
let (n, k) = (input[0], input[1])

func dijkstra(_ n: Int) -> Int {
    var heap = Heap(sorted: { $0.0 < $1.0 })
    var distance = Array(repeating: Int(1e9), count: 100_001)
    heap.push((0, n))
    distance[n] = 0

    while let (acc, now) = heap.pop() {
        if distance[now] < acc { continue }

        if now - 1 >= 0 && distance[now - 1] > acc + 1 {
            distance[now - 1] = acc + 1
            heap.push((acc + 1, now - 1))
        }

        if now + 1 <= 100_000 && distance[now + 1] > acc + 1 {
            distance[now + 1] = acc + 1
            heap.push((acc + 1, now + 1))
        }

        if now * 2 <= 100_000 && distance[now * 2] > acc {
            distance[now * 2] = acc
            heap.push((acc, now * 2))
        }
    }

    return distance[k]
}


let answer = dijkstra(n)

print(answer)
