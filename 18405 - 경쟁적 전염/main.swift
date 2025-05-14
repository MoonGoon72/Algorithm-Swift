import Foundation

let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

let nk = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (n, k) = (nk[0], nk[1])
var board: [[Int]] = []
var virus: [(Int, Int, Int, Int)] = []

for i in 0..<n {
    board.append(readLine()!.components(separatedBy: " ").map { Int($0)! })
    for j in 0..<n {
        if board[i][j] != 0 {
            virus.append((board[i][j], 0, i, j))
        }
    }
}
var queue = virus.sorted { $0.0 < $1.0 }

let sxy = readLine()!.components(separatedBy: " ").map { Int($0)! }
let (s, x, y) = (sxy[0], sxy[1] - 1, sxy[2] - 1)

func solution() {
    while !queue.isEmpty {
        let (v, t, x, y) = queue.removeFirst()
        guard t != s else { break }
        
        for i in 0..<4 {
            let (nx, ny) = (x + dx[i], y + dy[i])
            guard check(nx, ny), board[nx][ny] == 0 else { continue }
            
            board[nx][ny] = v
            queue.append((v, t + 1, nx, ny))
        }
    }
    
    print(board[x][y])
}

func check(_ x: Int, _ y: Int) -> Bool {
    return 0 <= x && x < n && 0 <= y && y < n
}

solution()
