//
//  main.swift
//  이코테 - 화성 탐사
//

import Foundation

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let inf = Int(1e9)

let t = Int(readLine()!)!

func check(_ y: Int, _ x: Int, _ n: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < n
}

func dijkstra(_ board: [[Int]], _ n: Int) -> Int {
    var distance: [[Int]] = Array(repeating: Array(repeating: inf, count: n), count: n)
    distance[0][0] = board[0][0]
    var heap = Heap<Int>(sort: <)
    heap.push((board[0][0], 0, 0))
    
    while heap.count > 0 {
        guard let (cost, y, x) = heap.pop() else { return -1 }
        guard distance[y][x] >= cost else { continue }
        
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            guard check(ny, nx, n) else { continue }
            
            let nextCost = board[ny][nx] + cost
            if distance[ny][nx] > nextCost {
                distance[ny][nx] = nextCost
                heap.push((nextCost, ny, nx))
            }
        }
    }
    return distance[n - 1][n - 1]
}

for _ in 0..<t {
    let n = Int(readLine()!)!
    var board: [[Int]] = []
    
    for _ in 0..<n {
        let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
        board.append(line)
    }
    let answer = dijkstra(board, n)
    print(answer)
}

struct Heap<Element: Comparable> {
    private var elements: [(Element, Element, Element)] = []
    private let isHighPriority: (Element, Element) -> Bool
    var count: Int { elements.count }
    
    init(sort: @escaping (Element, Element) -> Bool) {
        isHighPriority = sort
    }
    
    mutating func push(_ value: (Element, Element, Element)) {
        elements.append(value)
        shiftUp(from: elements.count - 1)
    }
    
    mutating func pop() -> (Element, Element, Element)? {
        guard !elements.isEmpty else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        shiftDown(from: 0)
        return value
    }
    
    private mutating func shiftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        
        while child > 0 && isHighPriority(elements[child].0, elements[parent].0) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    private mutating func shiftDown(from index: Int) {
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
            
            if candidate == parent { return }
            elements.swapAt(candidate, parent)
            parent = candidate
        }
    }
}

/*
3
3
5 5 4
3 9 1
3 2 7
5
3 7 2 0 1
2 8 0 9 1
1 2 1 8 1
9 8 9 2 0
3 6 5 1 5
7
9 0 5 1 1 5 3
4 1 2 1 6 5 3
0 7 6 1 6 8 5
1 1 7 8 3 2 3
9 4 0 7 6 4 1
5 8 3 2 4 8 3
7 4 8 4 8 3 4
--- 출력 ---
20
19
36
 */
