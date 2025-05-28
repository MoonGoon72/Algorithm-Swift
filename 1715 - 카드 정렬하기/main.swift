//
//  main.swift
//  1715 - 카드 정렬하기
//

import Foundation

let n = Int(readLine()!)!
var heap = Heap<Int>(sort: <)

for _ in 0..<n {
    let input = Int(readLine()!)!
    heap.push(input)
}

var answer = 0

while heap.count != 1 {
    guard let first = heap.pop(), let second = heap.pop() else { break }
    
    let summation = first + second
    heap.push(summation)
    answer += summation
}

print(answer)

struct Heap<Element: Comparable> {
    private var elements: [Element] = []
    private let isHighPriority: (Element, Element) -> Bool
    var count: Int { elements.count }
    
    init(sort: @escaping (Element, Element) -> Bool ) {
        isHighPriority = sort
    }
    
    mutating func push(_ value: Element) {
        elements.append(value)
        shiftUp(from: elements.count - 1)
    }
    
    mutating func pop() -> Element? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        shiftDown(from: 0)
        return value
    }
    
    private mutating func shiftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && isHighPriority(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    private mutating func shiftDown(from index: Int) {
        var parent = index
        while true {
            let left = parent * 2 + 1
            let right = parent * 2 + 2
            var candidate = parent
            
            if left < elements.count && isHighPriority(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < elements.count && isHighPriority(elements[right], elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent { return }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
