//
//  main.swift
//  11279
//
//  Created by MoonGoon on 6/28/24.
//

import Foundation

var n: Int = Int(readLine()!)!
var heap = Heap()
for _ in 0..<n {
    let x = Int(readLine()!)!
    if x == 0 {
        print(heap.pop())
    } else {
        heap.push(x)
    }
}


struct Heap {
    enum MoveStatus { case none, left, right }

    var heap: [Int] = []

    init() {
        heap.append(Int.max)
    }
    init(_ data: Int) {
        heap.append(Int.max)
        heap.append(data)
    }

    mutating func push(_ data: Int) {
        if heap.count == 0 {
            heap.append(data)
            heap.append(data)
            return
        }

        heap.append(data)
        
        func isMoveUp(_ insertIndex:Int) -> Bool {
            if insertIndex <= 1 {
                return false
            }

            let parentIndex = insertIndex / 2
            return heap[parentIndex] < heap[insertIndex]
        }

        var insertIndex: Int = heap.count - 1

        while isMoveUp(insertIndex) {
            let parentIndex = insertIndex / 2
            heap.swapAt(parentIndex, insertIndex)
            insertIndex = parentIndex
        }
    }

    mutating func pop() -> Int {
        if heap.count <= 1 {
            return 0
        }

        let returnValue = heap[1]
        
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()

        var poppedIndex = 1

        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnValue
            case .left:
                let leftChildIndex = poppedIndex * 2
                heap.swapAt(poppedIndex, leftChildIndex)
                poppedIndex = leftChildIndex
            case .right:
                let rightChildIndex = poppedIndex * 2 + 1
                heap.swapAt(poppedIndex, rightChildIndex)
                poppedIndex = rightChildIndex
            }
        }

        func moveDown(_ poppedIndex: Int) -> MoveStatus {
            let leftChildIndex = poppedIndex * 2
            let rightChildIndex = poppedIndex * 2 + 1

            if leftChildIndex >= heap.count {  // 자식 노드 없음
                return .none
            }

            if rightChildIndex >= heap.count {  // left child만 존재
                return heap[leftChildIndex] > heap[poppedIndex] ? .left : .none
            }
            // left, right 둘 다 크다
            if heap[leftChildIndex] > heap[poppedIndex] && heap[rightChildIndex] > heap[poppedIndex] {
                return heap[leftChildIndex] > heap[rightChildIndex] ? .left : .right
            }
            if heap[leftChildIndex] > heap[poppedIndex] { return .left }
            if heap[rightChildIndex] > heap[poppedIndex] { return .right }
            return .none
        }
    }
}
