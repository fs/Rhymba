//
//  RHMedia.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class RHMedia: RHModel {

    internal typealias SelectParam = MediaSelectParams
    
    public var albumArtistName         : String?
    public var geos                    : [RHGeo]?
    public var genre                   : [RHGenre]?
    public var albumArtistId           : NSNumber?
    public var albumId                 : NSNumber?
    public var albumIsExplicit         : NSNumber?
    public var albumLabelId            : NSNumber?
    public var albumLabelName          : String?
    public var albumName               : String?
    public var albumNumberOfTracks     : NSNumber?
    public var albumProviderId         : NSNumber?
    public var albumProviderName       : String?
    public var albumProviderSpecificId : String?
    public var albumReleaseDate        : NSDate?
    public var albumStatusId           : NSNumber?
    public var albumStreetDate         : NSDate?
    public var albumUpc                : String?
    public var albumVolumeNumber       : NSNumber?
    public var artistDateAdded         : NSDate?
    public var artistDateUpdated       : NSDate?
    public var artistId                : NSNumber?
    public var artistName              : String?
    public var baseFile                : String?
    public var bitRate                 : NSNumber?
    public var dateAdded               : NSDate?
    public var dateUpdated             : NSDate?
    public var fileSize                : NSNumber?
    public var formatId                : NSNumber?
    public var id                      : NSNumber?
    public var isExplicit              : NSNumber?
    public var isrc                    : String?
    public var length                  : NSNumber?
    public var providerId              : NSNumber?
    public var providerName            : String?
    public var providerSpecId          : String?
    public var releaseDate             : NSDate?
    public var relevantTitle           : String?
    public var score                   : NSNumber?
    public var statusId                : NSNumber?
    public var streetDate              : NSDate?
    public var title                   : String?
    public var trackNumber             : NSNumber?
    public var volumeNumber            : NSNumber?

    required public init() {
        super.init()
    }
    
    internal override func update(withDictionary dict: [String : AnyObject]) {
        
        for (key, value) in dict {
            if let mediaParam = MediaSelectParams(queryString: key) where self.respondsToSelector(Selector(mediaParam.modelMapKey)) {
                
                var assignValue: AnyObject?
                
                switch mediaParam {
                    case .geos:
                        guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                        assignValue = RHGeo.createGeos(fromDictsArray: dicts)
                    case .genre:
                        guard let dicts = value as? Array<Dictionary<String, AnyObject>> else { break }
                        assignValue = RHGenre.createGenres(fromDictsArray: dicts)
                    case .album_releasedate, .album_streetdate, .artist_dateadded, .artist_dateupdated, .dateadded, .dateupdated, .releasedate, .streetdate:
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