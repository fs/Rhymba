//
//  Extensions.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

extension RawRepresentable where Self.RawValue == Int {
    
    //For Int from 0
    static var allCases: [Self] {
        return self.allCases(0)
    }
    
    static func allCases(startIndex: Int) -> [Self] {
        var i = startIndex
        return Array( AnyGenerator {
            let instance = self.init(rawValue: i)
            i += 1
            return instance
            })
    }
}

internal extension SequenceType where Generator.Element == Int {
    
    func stringValue() -> String {
        return "\'\(self.map { String($0) }.joinWithSeparator(","))\'"
    }
}

internal extension Bool {
    
    func stringValue() -> String {
        return self ? "true" : "false"
    }
}

public var ISO_8601_Accurate: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.locale = enUSPosixLocale
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    return dateFormatter
}()

public var ISO_8601: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.locale = enUSPosixLocale
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return dateFormatter
}()