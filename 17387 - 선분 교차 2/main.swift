//
//  main.swift
//  17387 - 선분 교차 2
//

import Foundation

typealias Point = (x: Int, y: Int)
let l1 = readLine()!.split(separator: " ").compactMap { Int($0) }
let l2 = readLine()!.split(separator: " ").compactMap { Int($0) }
let (x1, y1, x2, y2) = (l1[0], l1[1], l1[2], l1[3])
let (x3, y3, x4, y4) = (l2[0], l2[1], l2[2], l2[3])

func directionVector(_ a: Point, _ b: Point) -> Point {
    return (b.x - a.x, b.y - a.y)
}

func ccw(_ a: Point, _ b: Point, _ c: Point) -> Int {
    let u = directionVector(a, b)
    let v = directionVector(b, c)
    let calc = u.x * v.y - u.y * v.x

    return calc == 0 ? 0 : calc > 0 ? 1 : -1
}

func isCross(_ l1: [Int], _ l2: [Int]) -> Bool {
    let (x1, y1, x2, y2) = (l1[0], l1[1], l1[2], l1[3])
    let (x3, y3, x4, y4) = (l2[0], l2[1], l2[2], l2[3])

    let aX1 = min(x1, x2)
    let aX2 = max(x1, x2)
    let bX1 = min(x3, x4)
    let bX2 = max(x3, x4)
    let aY1 = min(y1, y2)
    let aY2 = max(y1, y2)
    let bY1 = min(y3, y4)
    let bY2 = max(y3, y4)

    if (max(aX1, bX1) - min(aX2, bX2) <= 0) && (max(aY1, bY1) - min(aY2, bY2) <= 0) {
        return true
    }
    return false
}

let a: Point = (x1, y1)
let b: Point = (x2, y2)
let c: Point = (x3, y3)
let d: Point = (x4, y4)

let tmp1 = ccw(a, b, c)
let tmp2 = ccw(a, b, d)
let tmp3 = ccw(c, d, a)
let tmp4 = ccw(c, d, b)

if tmp1 * tmp2 <= 0 && tmp3 * tmp4 <= 0 {
    if tmp1 == 0 && tmp3 == 0 {
        if isCross(l1, l2) {
            print(1)
        } else {
            print(0)
        }
    } else {
        print(1)
    }
} else {
    print(0)
}
