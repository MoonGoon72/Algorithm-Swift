//
//  main.swift
//  1927 - 최소 힙
//
//  Created by MoonGoon on 6/28/24.
//

import Foundation

var n = Int(readLine()!)!

var heap = Heap()

for _ in 0..<n {
    var x = Int(readLine()!)!
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
        heap.append(0)
    }

    init(_ data: Int) {
        heap.append(0)
        heap.append(data)
    }
    
    mutating func push(_ data:Int) {
        if heap.count == 1 {
            heap.append(data)
            return
        }

        heap.append(data)
        
        var insertIndex: Int = heap.count - 1

        while isMoveUp(insertIndex) {
            let parentIndex = insertIndex / 2
            heap.swapAt(parentIndex, insertIndex)
            insertIndex = parentIndex
        }

        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 { return false }
            let parentIndex = insertIndex / 2

            return heap[insertIndex] < heap[parentIndex]
        }
    }

    mutating func pop() -> Int {
        if heap.count <= 1 { return 0 }

        let returnData = heap[1]
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()

        var poppedIndex: Int = 1
        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnData
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

            if leftChildIndex >= heap.count { return .none }

            if rightChildIndex >= heap.count {
                return heap[leftChildIndex] < heap[poppedIndex] ? .left : .none
            }
            
            if heap[leftChildIndex] > heap[poppedIndex] && heap[rightChildIndex] > heap[poppedIndex] { return .none }

            if heap[leftChildIndex] < heap[poppedIndex] && heap[rightChildIndex] < heap[poppedIndex] {
                return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
            }

            return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
        }
    }

}
