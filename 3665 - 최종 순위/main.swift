//
//  main.swift
//  3665 - 최종 순위
//

import Foundation

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let n = Int(readLine()!)!
    var graph = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
    let scores = readLine()!.split(separator: " ").map { Int($0)! }
    var indegree = Array(repeating: 0, count: n + 1)
    
    for i in 0..<n - 1 {
        let teamA = scores[i]
        for j in i + 1..<n {
            let teamB = scores[j]
            graph[teamA][teamB] = true
            indegree[teamB] += 1
        }
    }
    
    let m = Int(readLine()!)!
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (input[0], input[1])
        if graph[a][b] {
            indegree[b] -= 1
            indegree[a] += 1
            
            graph[a][b] = false
            graph[b][a] = true
        } else {
            indegree[a] -= 1
            indegree[b] += 1
            
            graph[b][a] = false
            graph[a][b] = true
        }
    }
    
    var queue = Array<Int>()
    for i in 1..<n + 1 {
        if indegree[i] == 0 {
            queue.append(i)
        }
    }
    
    var answer = Array<Int>()
    var flag = true
    for _ in 0..<n {
        if queue.isEmpty {
            print("IMPOSSIBLE")
            flag = false
            break
        } else if queue.count > 1 {
            print("?")
            flag = false
            break
        }
        
        let now = queue.removeFirst()
        answer.append(now)
        
        for i in 1..<n + 1 {
            if graph[now][i] {
                indegree[i] -= 1
                if indegree[i] == 0 {
                    queue.append(i)
                }
            }
        }
    }
    
    if flag {
        for a in answer {
            print(a, terminator: " ")
        }
    }
}
