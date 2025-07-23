//
//  main.swift
//  이코테 - boj - 1439 - 뒤집기
//

import Foundation

let input = Array(readLine()!)

var zeroGroup = 0
var oneGroup = 0
var last = input[0]
last == "0" ? (zeroGroup = 1) : (oneGroup = 1)

for v in input {
    guard v != last else { continue }
    
    v == "0" ? (zeroGroup += 1) : (oneGroup += 1)
    last = v
}

if zeroGroup == 0 || oneGroup == 0 {
    print(0)
} else {
    print(min(zeroGroup, oneGroup))
}
