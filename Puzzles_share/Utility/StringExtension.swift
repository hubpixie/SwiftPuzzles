//
//  StringExtension.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/08/30.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

extension String {
    func range(location: Int, length: Int) -> Range<String.Index> {
        let si = self.index(startIndex, offsetBy: location)
        let ei = self.index(startIndex, offsetBy: location + length)
        
        return si..<ei
    }
}
