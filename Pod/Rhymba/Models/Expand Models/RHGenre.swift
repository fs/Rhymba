//
//  RHGenre.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHGenre: RHModel {

    public var name: String?
    public var id: NSNumber?
    
    internal class func createGenres(fromDictsArray array: Array<Dictionary<String, AnyObject>>) -> [RHGenre] {
        var geos: [RHGenre] = []
        for dict in array {
            let geo = RHGenre()
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
