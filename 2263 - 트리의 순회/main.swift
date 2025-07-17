//
//  main.swift
//  2263 - 트리의 순회
//

import Foundation

let n = Int(readLine()!)!
let inorder = readLine()!.components(separatedBy: " ").map { Int($0)! }
let postorder = readLine()!.components(separatedBy: " ").map { Int($0)! }
var idxDict = Dictionary<Int, Int>()
inorder.enumerated().forEach { idxDict[$1] = $0 }

func buildPreorder(_ inStart: Int, _ inEnd: Int, _ postStart: Int, _ postEnd: Int) {
    
    if (inStart > inEnd) || (postStart > postEnd) { return }
    
    let root = postorder[postEnd]
    print(root, terminator: " ")
    
    let inRootIndex = idxDict[root]!
    let leftSize = inRootIndex - inStart
    
    buildPreorder(
        inStart,
        inRootIndex - 1,
        postStart,
        postStart + leftSize - 1
    )
    
    buildPreorder(
        inRootIndex + 1,
        inEnd,
        postStart + leftSize,
        postEnd - 1
    )
}

buildPreorder(0, n - 1, 0, n - 1)
