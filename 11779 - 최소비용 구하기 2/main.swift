//
//  main.swift
//  11779 - 최소비용 구하기 2
//

import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!

var graph = Array(repeating: Array<(Int, Int)>(), count: n + 1)
for _ in 0..<m {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    graph[input[0]].append((input[2], input[1]))
}
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (start, end) = (input[0], input[1])

func dijkstra(start: Int, end: Int) {
    var distance = Array(repeating: Int(1e9), count: n + 1)
    var heap = Heap(sorted: <)
    heap.push((0, start))
    distance[start] = 0
    var path = Array(repeating: -1, count: n + 1)

    while let (acc, node) = heap.pop() {
        if acc > distance[node] { continue }
        
        for (cost, nxt) in graph[node] {
            let nextCost = cost + acc
            if distance[nxt] > nextCost {
                distance[nxt] = nextCost
                heap.push((nextCost, nxt))
                path[nxt] = node
            }
        }
    }
    
    var routes = [end]
    while routes[routes.count - 1] != start {
        routes.append(path[routes.last!])
    }
    routes.reverse()
    
    print(distance[end])
    print(routes.count)
    print(routes.map { String($0) }.joined(separator: " "))
}

dijkstra(start: start, end: end)

struct Heap {
    private var elements: [(Int, Int)] = []
    private let isHighPriority: ((Int, Int) -> Bool)
    var isEmpty: Bool { elements.isEmpty }
    
    init(sorted: @escaping ((Int, Int) -> Bool)) {
        isHighPriority = sorted
    }
    
    mutating func push(_ value: (Int, Int)) {
        elements.append(value)
        shiftUp(from: elements.count - 1)
    }
    
    mutating func pop() -> (Int, Int)? {
        guard let value = elements.first else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        elements.removeLast()
        shiftDown(from: 0)
        return value
    }
    
    mutating private func shiftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        
        while child > 0 && isHighPriority(elements[child].0, elements[parent].0) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    mutating private func shiftDown(from index: Int) {
        var parent = index
        
        while true {
            let leftChild = parent * 2 + 1
            let rightChild = parent * 2 + 2
            var candidate = parent
            
            if leftChild < elements.count && isHighPriority(elements[leftChild].0, elements[candidate].0) {
                candidate = leftChild
            }
            if rightChild < elements.count && isHighPriority(elements[rightChild].0, elements[candidate].0) {
                candidate = rightChild
            }
            
            if parent == candidate {
                break
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
