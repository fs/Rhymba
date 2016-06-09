//
//  Filter.swift
//  Rhymba
//
//  Created by Aynur Galiev on 07.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

internal enum FilterOption: String {
    case equal          = "eq"
    case greaterThan    = "gt"
    case lessThan       = "lt"
    case endsWith       = "endswith"
    case startsWith     = "startswith"
    case substringOf    = "substringof"
}

internal struct FilterItem {
    
    var key: String
    var filterOption: FilterOption
    var value: AnyObject
    
    init(key: String, filterOption: FilterOption, value: AnyObject) {
        self.key          = key
        self.filterOption = filterOption
        self.value        = value
    }
    
    func getFilterItemString() -> String {
        
        var stringValue: String = ""
        if let lValue = self.value as? String {
            stringValue = "'\(lValue)'"
        } else {
            stringValue = "\(self.value)"
        }
        
        switch self.filterOption {
            case .endsWith, .startsWith : stringValue = "\(self.filterOption.rawValue)(\(key), \(stringValue))"
            case .substringOf           : stringValue = "\(self.filterOption.rawValue)(\(stringValue), \(key))"
            default                     : stringValue = "\(key) \(filterOption.rawValue) \(stringValue)"
        }
        return stringValue
    }
}

public class Filter {

    private var params: [FilterItem] = []
    
    internal init() { }
    
    public class func newInstance() -> Filter {
        return Filter()
    }
    
    private func updateParams(param: FilterItem) {
        let index = self.params.indexOf { $0.key == param.key }
        if let lIndex = index {
            self.params[lIndex] = param
        } else {
            self.params.append(param)
        }
    }
    
    public func equalTo(key: String, value: AnyObject) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .equal, value: value))
        return self
    }
    
    public func greaterThan(key: String, value: AnyObject) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .greaterThan, value: value))
        return self
    }
    
    public func lessThan(key: String, value: AnyObject) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .lessThan, value: value))
        return self
    }
    
    public func endsWith(key: String, value: String) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .endsWith, value: value))
        return self
    }
    
    public func startsWith(key: String, value: String) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .startsWith, value: value))
        return self
    }
    
    public func substringOf(key: String, value: String) -> Filter {
        self.updateParams(FilterItem(key: key, filterOption: .substringOf, value: value))
        return self
    }
    
    internal func getFormattedString() -> String? {
        var formattedString: [String] = []
        for param in self.params {
            formattedString.append(param.getFilterItemString())
        }
        guard formattedString.count != 0 else { return nil }
        return formattedString.joinWithSeparator(" and ")
    }
}
