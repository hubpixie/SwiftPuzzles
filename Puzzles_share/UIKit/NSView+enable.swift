//
//  NSView+enable.swift
//  SwiftPuzzles_macos
//
//  Created by venus.janne on 2017/10/31.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Cocoa
extension NSView {
    func disableSubViews(target:NSViewController?) {
        setSubViewsEnabled(false, target)
    }
    
    func enableSubViews(target:NSViewController?) {
        setSubViewsEnabled(true, target)
    }
    
    func setSubViewsEnabled(_ enabled: Bool, _ target: AnyObject?) {
        var ctl: NSControl? = nil
        for currentView in self.subviews {
            if currentView.responds(to: #selector(setter: NSCell.isEnabled)) {
                ctl = currentView as? NSControl
                ctl?.isEnabled = enabled
                ctl?.target = target
            }
            currentView.setSubViewsEnabled(enabled, target)
            currentView.display()
        }
    }
    
}

