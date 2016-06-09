//
//  RHAlbum.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHAlbum: RHModel {

    internal typealias SelectParam = AlbumSelectParams
    
    public var artistDateAdded       : NSDate?
    public var artistDateUpdated     : NSDate?
    public var artistId              : NSNumber?
    public var artistName            : String?
    public var coverDeposited        : NSNumber?
    public var geos                  : [RHGeo]?
    public var genres                : [RHGenre]?
    public var id                    : NSNumber?
    public var isExplicit            : NSNumber?
    public var labelId               : NSNumber?
    public var labelName             : String?
    public var length                : NSNumber?
    public var name                  : String?
    public var numberOfTracks        : NSNumber?
    public var originalReleaseDate   : NSDate?
    public var providerId            : NSNumber?
    public var providerName          : String?
    public var providerSpecificId    : NSNumber?
    public var releaseDate           : NSDate?
    public var relevantTitle         : String?
    public var score                 : NSNumber?
    public var statusId              : NSNumber?
    public var streetDate            : NSDate?
    public var upc                   : String?
    public var volumeNumber          : NSNumber?
    
    public required init() {
        super.init()
    }
    
    internal override func update(withDictionary dict: [String : AnyObject]) {
        
        for (key, value) in dict {
            
            if let mediaParam = AlbumSelectParams(queryString: key) where self.respondsToSelector(Selector(mediaParam.modelMapKey)) {
                
                var assignValue: AnyObject?
                
                switch mediaParam {
                    case .geos:
                        guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                        assignValue = RHGeo.createGeos(fromDictsArray: dicts)
                    case .genres:
                        guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                        assignValue = RHGenre.createGenres(fromDictsArray: dicts)
                    case .artist_dateadded, .artist_dateupdated, .original_release_date, .releasedate, .streetdate:
                        guard let dateString = value as? String else { break }
                        if let lDate = ISO_8601_Accurate.dateFromString(dateString) {
                            assignValue = lDate
                        } else {
                            assignValue = ISO_8601.dateFromString(dateString)
                    }
                    default:
                        assignValue = value
                }
                self.setValue(assignValue, forKey: mediaParam.modelMapKey)
            }
        }
    }
}