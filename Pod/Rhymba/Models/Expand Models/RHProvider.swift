//
//  RHInfluence.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHProvider: RHModel {

    public var name: String?
    public var id: NSNumber?
    
    internal class func createProviders(fromDictsArray array: Array<Dictionary<String, AnyObject>>) -> [RHProvider] {
        var geos: [RHProvider] = []
        for dict in array {
            let geo = RHProvider()
            geo.update(withDictionary: dict)
            geos.append(geo)
        }
        return geos
    }
    
    internal override func update(withDictionary dict: [String : AnyObject]) {
        for (key, value) in dict {
            if self.respondsToSelector(Selector(key)) {
                self.setValue(value, forKey: key)
            }
        }
    }
}
