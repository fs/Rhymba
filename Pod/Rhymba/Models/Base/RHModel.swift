//
//  ViewController.swift
//  Rhymba
//
//  Created by Galiev Aynur on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

internal protocol Updateable {
    func update(withDictionary dict: [String : AnyObject])
}

public class RHModel: NSObject, Updateable, Initializable {
    
    internal func update(withDictionary dict: [String : AnyObject]) { }
    override required public init() { }
    
    public override func setValue(value: AnyObject?, forKey key: String) {
        guard value != nil else { super.setValue(nil, forKey: key); return }
        guard let lValue = value where !lValue.isKindOfClass(NSNull.self) else { return }
        super.setValue(lValue, forKey: key)
    }
}