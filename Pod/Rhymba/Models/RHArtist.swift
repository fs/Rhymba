//
//  RHArtist.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHArtist: RHModel {

    internal typealias SelectParam = ArtistsSelectParams
    
    public var artistDescription    : String?
    public var genres               : [String]?
    public var id                   : NSNumber?
    public var influences           : [String]?
    public var language             : String?
    public var mediaGenres          : [RHGenre]?
    public var mediaProviders       : [RHProvider]?
    public var name                 : String?
    public var plainTextName        : String?
    public var score                : NSNumber?
    
    public required init() {
        super.init()
    }
    
    internal override func update(withDictionary dict: [String : AnyObject]) {
        
        for (key, value) in dict {
            
            if let artistParam = ArtistsSelectParams(queryString: key) where self.respondsToSelector(Selector(artistParam.modelMapKey)) {
                
                var assignValue: AnyObject?
                
                switch artistParam {
                case .media_providers:
                    guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                    assignValue = RHProvider.createProviders(fromDictsArray: dicts)
                case .media_genres:
                    guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                    assignValue = RHGenre.createGenres(fromDictsArray: dicts)
                default:
                    assignValue = value
                }
                
                self.setValue(assignValue, forKey: artistParam.modelMapKey)
            }
        }
    }
}