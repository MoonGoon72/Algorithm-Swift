//
//  main.swift
//  이코테 - 숨바꼭질
//

import Foundation

let inf = Int(1e9)
let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
var board = Array(repeating: Array<Int>(), count: n + 1)

func dijkstra(_ value: Int) -> (Int, Int, Int) {
    var heap = Heap<Int>(sort: <)
    var distance = Array(repeating: inf, count: n + 1)
    distance[start] = 0
    heap.push((0, start))
    
    while heap.count > 0 {
        guard let (cost, now) = heap.pop() else { return (-1, -1, -1) }
        
        guard distance[now] >= cost else { continue }
        
        for nextNode in board[now] {
            let nextCost = cost + 1
            if distance[nextNode] > nextCost {
                distance[nextNode] = nextCost
                heap.push((nextCost, nextNode))
            }
        }
    }
    
    var answerDistance = 0
    var barns: [Int] = []
    
    for i in 1..<n + 1 {
        if distance[i] > answerDistance {
            answerDistance = distance[i]
            barns = [i]
        } else if distance[i] == answerDistance {
            barns.append(i)
        }
    }
    
    return (barns[0], answerDistance, barns.count)
}

for _ in 0..<m {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let (a, b) = (input[0], input[1])
    board[a].append(b)
    board[b].append(a)
}

let start = 1
let (barnNum, distance, barnCount) = dijkstra(start)
print(barnNum, distance, barnCount)

struct Heap<Element: Comparable> {
    private var elements: [(Element, Element)] = []
    private let isHighPriority: (Element, Element) -> Bool
    var count: Int { elements.count }
    
    init(sort: @escaping (Element, Element) -> Bool) {
        isHighPriority = sort
    }
    
    mutating func push(_ value: (Element, Element)) {
        elements.append(value)
        shiftUp(from: elements.count - 1)
    }
    
    mutating func pop() -> (Element, Element)? {
        guard elements.count > 0 else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        shiftDown(from: 0)
        return value
    }
    
    private mutating func shiftUp(from index: Int) {
        var child = index
        var parent = (index - 1) / 2
        
        while child > 0 && isHighPriority(elements[child].0, elements[parent].0) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    private mutating func shiftDown(from index: Int) {
        var parent = index
        
        while true {
            let leftChild = (parent + 1) * 2
            let rightChild = (parent + 1) * 2 + 1
            var candidate = parent
            
            if leftChild < elements.count - 1 && isHighPriority(elements[leftChild].0, elements[candidate].0) {
                candidate = leftChild
            }
            
            if rightChild < elements.count - 1 && isHighPriority(elements[rightChild].0, elements[candidate].0) {
                candidate = rightChild
            }
            
            if candidate == parent { return }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

/*
6 7
3 6
4 3
3 2
1 3
1 2
2 4
5 2
 --- result ---
 4 2 3
 */
