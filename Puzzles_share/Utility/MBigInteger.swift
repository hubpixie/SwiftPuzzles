//
//  MBigInteger.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/08/21.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

typealias MBigInteger = BigInteger

extension MBigInteger {
//    public func =(lhs: Int)
//    {
//        return BigInteger.create(fromLong: lhs)
//    }
    static public func +=(lhs: inout BigInteger, rhs: BigInteger)
    {
        lhs = lhs.add(rhs)
    }
    
    static public func +(lhs: BigInteger, rhs: BigInteger) -> BigInteger
    {
        return lhs.add(rhs)
    }

    static public func *(lhs: BigInteger, rhs: BigInteger) -> BigInteger
    {
        return lhs.multiply(rhs)
    }
    static public func *(lhs: Int, rhs: BigInteger) -> BigInteger
    {
        return BigInteger.create(fromLong: lhs).multiply(rhs)
    }
    static public func *(lhs: BigInteger, rhs: Int) -> BigInteger
    {
        return lhs.multiply(BigInteger.create(fromLong: rhs))
    }
//    static public func *(lhs: Int, rhs: Int) -> BigInteger
//    {
//        return BigInteger.create(fromLong: lhs).multiply(BigInteger.create(fromLong: rhs))
//    }
    
    static public func +(lhs: Int, rhs: BigInteger) -> BigInteger { return BigInteger.create(fromLong: lhs) + rhs }
    static public func +(lhs: BigInteger, rhs: Int) -> BigInteger { return lhs + BigInteger.create(fromLong: rhs) }
    
    static public func +=(lhs: inout Int, rhs: BigInteger) { lhs += (BigInteger.create(fromLong: lhs) + rhs) }
    static public func +=(lhs: inout BigInteger, rhs: Int) { lhs +=  BigInteger.create(fromLong: rhs) }
    
}
