import Foundation

func binarySearchLeft(_ array: [String], _ value: String) -> Int {
    let n = array.count
    var (s, e) = (0, n)
    
    while s < e {
        let mid = (s + e) / 2
        if array[mid] < value {
            s = mid + 1
        } else {
            e = mid
        }
    }
    return s
}

func binarySearchRight(_ array: [String], _ value: String) -> Int {
    let n = array.count
    var (s, e) = (0, n)
    
    while s < e {
        let mid = (s + e) / 2
        if array[mid] <= value {
            s = mid + 1
        } else {
            e = mid
        }
    }
    return s
}

func countByRange(_ array: [String], _ leftValue: String, _ rightValue: String) -> Int {
    let leftIndex = binarySearchLeft(array, leftValue)
    let rightIndex = binarySearchRight(array, rightValue)
    return rightIndex - leftIndex
}

func solution(_ words:[String], _ queries:[String]) -> [Int] {
    var array = Array(repeating: Array<String>(), count: 10001)
    var reversedArray = Array(repeating: Array<String>(), count: 10001)
    
    for word in words {
        array[word.count].append(word)
        reversedArray[word.count].append(String(word.reversed()))
    }
    
    for i in 0..<10001 {
        array[i].sort()
        reversedArray[i].sort()
    }
    
    var answer: [Int] = []
    
    for query in queries {
        let n = query.count
        if query.first == "?" {
            let reversed = String(query.reversed())
            let count = countByRange(reversedArray[n], reversed.replacingOccurrences(of: "?", with: "a"), reversed.replacingOccurrences(of: "?", with: "z"))
            answer.append(count)
        } else {
            let count = countByRange(array[n], query.replacingOccurrences(of: "?", with: "a"), query.replacingOccurrences(of: "?", with: "z"))
            answer.append(count)
        }
    }
    
    return answer
}

let words = ["frodo", "front", "frost", "frozen", "frame", "kakao"]
let queries = ["fro??", "????o", "fr???", "fro???", "pro?"]
print(solution(words, queries))
