//
//  main.swift
//  13460 - 구슬 탈출 2
//

import Foundation

typealias Pos = (y: Int, x: Int)
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])
var board: [[Character]] = []
var hole: Pos = (0, 0)
var red: Pos = (0, 0)
var blue: Pos = (0, 0)

for i in 0..<n {
    var line = Array(readLine()!)
    for j in 0..<m {
        if line[j] == "O" {
            hole = (i, j)
        } else if line[j] == "R" {
            red = (i, j)
            line[j] = "."
        } else if line[j] == "B" {
            blue = (i, j)
            line[j] = "."
        }
    }
    board.append(line)
}

func check(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < m
}

func roll(_ start: Pos, _ d: Int) -> (ny: Int, nx: Int, steps: Int, inHole: Bool) {
    var y = start.y
    var x = start.x
    var s = 0
    while true {
        let ny = y + dy[d]
        let nx = x + dx[d]
        if board[ny][nx] == "#" {
            break
        }
        y = ny
        x = nx
        s += 1
        if board[y][x] == "O" {
            return (y, x, s, true)
        }
    }
    return (y, x, s, false)
}

func bfs(red: Pos, blue: Pos) -> Int {
    var visited = Array(
        repeating: Array(
            repeating: Array(
                repeating: Array(repeating: false, count: m),
                count: n),
            count: m),
        count: n)
    var queue: [(ry: Int, rx: Int, by: Int, bx: Int, depth: Int)] = []
    var head = 0
    
    visited[red.y][red.x][blue.y][blue.x] = true
    queue.append((red.y, red.x, blue.y, blue.x, 0))
    
    while head < queue.count {
        let cur = queue[head]
        head += 1
        
        if cur.depth >= 10 { continue }
        
        for d in 0..<4 {
            let nr = roll((cur.ry, cur.rx), d)
            let nb = roll((cur.by, cur.bx), d)
            
            if nb.inHole { continue }
            if nr.inHole { return cur.depth + 1 }
            
            var nry = nr.ny; var nrx = nr.nx
            var nby = nb.ny; var nbx = nb.nx
            
            if nry == nby && nrx == nbx {
                if nr.steps > nb.steps {
                    nry -= dy[d]
                    nrx -= dx[d]
                } else {
                    nby -= dy[d]
                    nbx -= dx[d]
                }
            }
            queue.append((nry, nrx, nby, nbx, cur.depth + 1))
        }
    }
    
    return -1
}

let answer = bfs(red: red, blue: blue)
print(answer)
