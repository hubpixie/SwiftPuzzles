//
//  SStack.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/08/26.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

public struct SStack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

extension SStack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { 
            return curr.pop()
        }
    }
}
