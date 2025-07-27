//
//  main.swift
//  이코테 - 문자열 재정렬
//

import Foundation

var summation = 0
var stringData = Array(readLine()!)

stringData.sort(by: <)
stringData.forEach {
    if let value = $0.wholeNumberValue {
        summation += value
    } else {
        print($0, terminator: "")
    }
}

if summation != 0 {
    print(summation)
}
