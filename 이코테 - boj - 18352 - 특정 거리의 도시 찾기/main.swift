import Foundation

// 1) 입력
let first = readLine()!.split(separator: " ").map { Int($0)! }
let N = first[0], M = first[1], K = first[2], X = first[3]

// 2) 그래프 & 거리 초기화
let INF = Int.max
var distance = [Int](repeating: INF, count: N + 1)
distance[X] = 0

var graph = [[Int]](repeating: [], count: N + 1)
for _ in 0..<M {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let a = edge[0], b = edge[1]
    graph[a].append(b)
}

// 3) BFS
// 정적 배열 큐 (ring buffer)
var queue = [Int](repeating: 0, count: N + 1)
var head = 0, tail = 0

// 시작점 enque
queue[tail] = X
tail += 1

while head < tail {
    let now = queue[head]
    head += 1

    for next in graph[now] {
        // 아직 방문 전(=거리 무한)이면
        if distance[next] > distance[now] + 1 {
            distance[next] = distance[now] + 1
            queue[tail] = next
            tail += 1
        }
    }
}

// 4) 출력
var found = false
for city in 1...N {
    if distance[city] == K {
        print(city)
        found = true
    }
}
if !found {
    print(-1)
}
