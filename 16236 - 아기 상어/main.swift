//
//  main.swift
//  16236
//
//  Created by MoonGoon on 6/25/24.
//

import Foundation

typealias position = (y: Int, x: Int)

let dy = [-1, 0, 1, 0]
let dx = [0, -1, 0, 1]
let inf = Int(1e9)

let n = Int(readLine()!)!
var graph = Array<[Int]>()
var nowX = 0
var nowY = 0
var nowSize = 2
var ate = 0

for i in 0..<n {
    var line = readLine()!.components(separatedBy: " ").map { Int($0)! }
    for j in 0..<n {
        if line[j] == 9 {
            nowY = i
            nowX = j
            line[j] = 0
        }
    }
    graph.append(line)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < n
}

func bfs() -> [[Int]] {
    var dist = Array(repeating: Array(repeating: -1, count: n), count: n)
    dist[nowY][nowX] = 0
    var queue = Array<(Int, Int)>()
    queue.append((nowY, nowX))
    
    while !queue.isEmpty {
        let (y, x) = queue.removeFirst()
        for i in 0..<4 {
            let (ny, nx) = (y + dy[i], x + dx[i])
            guard check(ny, nx) else { continue }
            if dist[ny][nx] == -1 && graph[ny][nx] <= nowSize {
                dist[ny][nx] = dist[y][x] + 1
                queue.append((ny, nx))
            }
        }
    }
    return dist
}

func find(_ dist: [[Int]]) -> position? {
    var (y, x) = (0, 0)
    var minDist = inf
    
    for i in 0..<n {
        for j in 0..<n {
            if dist[i][j] != -1 && graph[i][j] > 0 && graph[i][j] < nowSize {
                if dist[i][j] < minDist {
                    minDist = dist[i][j]
                    (y, x) = (i, j)
                }
            }
        }
    }
    if minDist == inf {
        return nil
    } else {
        return (y, x)
    }
}

var result = 0

while true {
    let dist = bfs()
    let value = find(dist)

    guard let value = value else {
        print(result)
        break
    }
    
    nowY = value.y
    nowX = value.x
    graph[value.y][value.x] = 0
    ate += 1
    result += dist[nowY][nowX]
    
    if ate >= nowSize {
        nowSize += 1
        ate = 0
    }
}

func solutionA() {
    let dy: [Int] = [-1, 1, 0, 0]
    let dx: [Int] = [0, 0, -1, 1]
    
    let n = Int(readLine()!)!
    var graph: [[Int]] = []
    
    
    for _ in 0..<n {
        let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
        graph.append(line)
    }
    
    
    func getBabySharkPosition() -> (Int, Int)? {
        for row in 0..<n {
            for col in 0..<n {
                if graph[row][col] == 9 {
                    graph[row][col] = 0 // 아기 상어 위치 초기화
                    return (row, col)
                }
            }
        }
        return nil
    }
    
    func check(_ y: Int, _ x: Int) -> Bool {
        return 0 <= y && y < n && 0 <= x && x < n
    }
    
    func bfs(sharkPosition: (Int, Int), sharkSize: Int) -> ((Int, Int), Int) {
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: n)
        var distance: [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
        visited[sharkPosition.0][sharkPosition.1] = true
        distance[sharkPosition.0][sharkPosition.1] = 0
        var queue: [(Int, Int)] = [sharkPosition]
        var eatableFishPosition: [(Int, Int)] = []
        var minDistance: Int = Int.max
        
        while !queue.isEmpty {
            let now = queue.removeFirst()
            let y = now.0
            let x = now.1
            
            for i in 0..<4 {
                let ny = y + dy[i]
                let nx = x + dx[i]
                if check(ny, nx) && !visited[ny][nx] && graph[ny][nx] <= sharkSize {
                    if distance[ny][nx] >= distance[y][x] + 1 {
                        distance[ny][nx] = distance[y][x] + 1
                        if graph[ny][nx] > 0 && graph[ny][nx] < sharkSize {
                            if distance[ny][nx] < minDistance {
                                eatableFishPosition.append((ny, nx)) // 중복이 될 수도 있을 것 같음
                                minDistance = distance[ny][nx]
                            } else if distance[ny][nx] == minDistance {
                                eatableFishPosition.append((ny, nx))
                            }
                        }
                        queue.append((ny, nx))
                        visited[ny][nx] = true
                    }
                    
                }
            }
        }
        
        if eatableFishPosition.isEmpty { return ((Int.max, Int.max), Int.max) }
        
        eatableFishPosition.sort { $0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0 }
        
        return (eatableFishPosition[0], minDistance)
    }
    
    func solution() {
        let sharkPosition = getBabySharkPosition()!
        var sharkSize = 2
        var swallowedFish = 0
        var count = 0
        
        var (nextPosition, distance) = bfs(sharkPosition: sharkPosition, sharkSize: sharkSize)
        
        while nextPosition != (Int.max, Int.max) {
            swallowedFish += 1
            graph[nextPosition.0][nextPosition.1] = 0
            count += distance
            if swallowedFish == sharkSize {
                sharkSize += 1
                swallowedFish = 0
            }
            (nextPosition, distance) = bfs(sharkPosition: nextPosition, sharkSize: sharkSize)
        }
        print(count)
    }
    
    solution()
}

