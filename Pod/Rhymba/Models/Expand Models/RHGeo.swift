//
//  Geo.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHGeo: RHModel {

    public var id               : String?
    public var country_id       : NSNumber?
    public var country_name     : String?
    public var country_code     : String?
    public var currency         : String?
    public var statusid         : NSNumber?
    public var domainsum        : NSNumber?
    public var pricecodeid      : NSNumber?
    public var streetdate       : NSDate?
    public var releasedate      : NSDate?
    public var pricecode        : String?
    public var price            : NSNumber?
    public var maxretailprice   : NSNumber?
    public var surcharge        : NSNumber?
    public var currencycode     : String?
    
    internal class func createGeos(fromDictsArray array: Array<Dictionary<String, AnyObject>>) -> [RHGeo] {
        var geos: [RHGeo] = []
        for dict in array {
            let geo = RHGeo()
            geo.update(withDictionary: dict)
            geos.append(geo)
        }
        return geos
    }
    
    internal override func update(withDictionary dict: [String : AnyObject]) {
        for (key, value) in dict {
            if self.respondsToSelector(Selector(key)) {
                
                if let lValue = value as? String where key == "streetdate" || key == "releasedate" {
                    if let lDate = ISO_8601_Accurate.dateFromString(lValue) {
                        self.setValue(lDate, forKey: key)
                    } else {
                        self.setValue(ISO_8601.dateFromString(lValue), forKey: key)
                    }
                } else {
                    self.setValue(value, forKey: key)
                }
            }
        }
    }
}