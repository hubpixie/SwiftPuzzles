//
//  StringUtil.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/06/15.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

class StringUtil {
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
            var retValues: [String] = []
            var sIndex = text.startIndex
            var eIndex = sIndex
            var offset: Int = 0
            for em in results {
                eIndex = text.index(sIndex, offsetBy: em.range.location - offset)
                retValues.append(text.substring(with: sIndex..<eIndex))
                sIndex = text.index(eIndex, offsetBy: em.range.length)
                offset = em.range.location + em.range.length
            }
            eIndex = text.index(sIndex, offsetBy: text.count - offset)
            retValues.append(text.substring(with: sIndex..<eIndex))
            return retValues
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
