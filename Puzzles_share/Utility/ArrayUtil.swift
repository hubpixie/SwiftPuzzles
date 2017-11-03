//
//  ArrayUtil.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/06/14.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation
extension Array {
    func eachConsecutive(_ n: Int) -> Array<ArraySlice<Iterator.Element>> {
        return (0..<self.count-n+1).map({ i in
            return ArraySlice(self[i..<i+n])
        })
    }
    func uniqStringArray(keyRangeStart: Int, keyRangeEnd: Int) -> [String] {
        var retArr: [String] = []
        var distincts: [String] = []
        
        for item in self  {
            if let str: String = item as? String {
                let key: String = str.substring(with: str.range(location: keyRangeStart, length: keyRangeEnd))
                if !distincts.contains(key) {
                    distincts.append(key)
                    retArr.append(str)
                }
            }
        }
        return retArr
    }
}

//: Permutations
//  but updated for Swift 3.0 (Xcode 8.0)
class ArrayUtil {
    func permutations<T>(arr: [T], limit: Int,  _ i: Int ) -> [[T]] {
        let retArray: [[T]] = []
        _perm(retArrs: retArray, arr: arr, limit: limit, i, options: nil)
        return retArray
    }
    func permutations<T>(arr: [T], limit: Int,  _ i: Int, options: (([T]) -> ())? ) -> [[T]] {
        let retArray: [[T]] = []
        _perm(retArrs: retArray, arr: arr, limit: limit, i, options: options)
        return retArray
    }
    private func _perm<T>(retArrs: [[T]], arr: [T], limit: Int,  _ i: Int, options: (([T]) -> ())? ) {
        var retArrs = retArrs
        
        if (i >= limit - 1)  {
            if options != nil {
                options?(arr)
            }
            retArrs.append(arr)
        }
        else {
            var arr = arr
            _perm(retArrs: retArrs, arr: arr, limit: limit, i + 1, options: options)
            for j in i + 1 ..< limit {
                var tmp: T = arr[i]
                arr[i] = arr[j]
                arr[j] = tmp
                _perm(retArrs: retArrs, arr: arr, limit: limit, i + 1, options: options)
                tmp = arr[i];
                arr[i] = arr[j];
                arr[j] = tmp;
            }
        }
    }
}
