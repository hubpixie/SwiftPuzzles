//
//  DateUtil.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/07/06.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Foundation

class DateUtil {
    func elapsedTimeString(startTime: Date, endTime: Date) -> String {
        let time = endTime.timeIntervalSince(startTime)
        let hh = Int(time / 3600)
        let mm = Int((time - Double(hh * 3600)) / 60)
        let ss = Int(time - Double(hh * 3600 + mm * 60))
        let ff = time - Double(hh * 3600 + mm * 60 + ss)
        return String(format: "%02d:%02d:%02d.%@", hh, mm, ss, String(format: "%.7f",ff).replacingOccurrences(of: "0.", with: ""))
    }
}
