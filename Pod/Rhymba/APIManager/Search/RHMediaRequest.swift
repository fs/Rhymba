//
//  RHMediaRequest.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public enum MediaExpandParams: Int, Queryable {
    
    case geos
    case genre
    
    internal var queryString: String {
        switch self {
            case .geos  : return "geos"
            case .genre : return "genre"
        }
    }
    
    internal init?(queryString: String) {
        for mediaCase in MediaExpandParams.allCases {
            if queryString == mediaCase.queryString {
                self = mediaCase
            }
        }
        return nil
    }
}

public enum MediaSelectParams: Int, Queryable, Mappable {
    
    case album_artist_name = 0
    case geos
    case genre
    case album_artistid
    case album_id
    case album_isexplicit
    case album_label_id
    case album_label_name
    case album_name
    case album_numberoftracks
    case album_provider_id
    case album_provider_name
    case album_providerspecificid
    case album_releasedate
    case album_status_id
    case album_streetdate
    case album_upc
    case album_volumenumber
    case artist_dateadded
    case artist_dateupdated
    case artist_id
    case artist_name
    case basefile
    case bitrate
    case dateadded
    case dateupdated
    case filesize
    case format_id
    case id
    case isexplicit
    case isrc
    case length
    case provider_id
    case provider_name
    case providerspecid
    case releasedate
    case relevant_title
    case score
    case statusid
    case streetdate
    case title
    case tracknumber
    case volumenumber
    
    internal var queryString: String {
        switch self {
        case album_artist_name          : return "album_artist_name"
        case album_artistid             : return "album_artistid"
        case album_id                   : return "album_id"
        case album_isexplicit           : return "album_isexplicit"
        case album_label_id             : return "album_label_id"
        case album_label_name           : return "album_label_name"
        case album_name                 : return "album_name"
        case album_numberoftracks       : return "album_numberoftracks"
        case album_provider_id          : return "album_provider_id"
        case album_provider_name        : return "album_provider_name"
        case album_providerspecificid   : return "album_providerspecificid"
        case album_releasedate          : return "album_releasedate"
        case album_status_id            : return "album_status_id"
        case album_streetdate           : return "album_streetdate"
        case album_upc                  : return "album_upc"
        case album_volumenumber         : return "album_volumenumber"
        case artist_dateadded           : return "artist_dateadded"
        case artist_dateupdated         : return "artist_dateupdated"
        case artist_id                  : return "artist_id"
        case artist_name                : return "artist_name"
        case basefile                   : return "basefile"
        case bitrate                    : return "bitrate"
        case dateadded                  : return "dateadded"
        case dateupdated                : return "dateupdated"
        case filesize                   : return "filesize"
        case format_id                  : return "format_id"
        case geos                       : return "geos"
        case genre                      : return "genre"
        case id                         : return "id"
        case isexplicit                 : return "isexplicit"
        case isrc                       : return "isrc"
        case length                     : return "length"
        case provider_id                : return "provider_id"
        case provider_name              : return "provider_name"
        case providerspecid             : return "providerspecid"
        case releasedate                : return "releasedate"
        case relevant_title             : return "relevant_title"
        case score                      : return "score"
        case statusid                   : return "statusid"
        case streetdate                 : return "streetdate"
        case title                      : return "title"
        case tracknumber                : return "tracknumber"
        case volumenumber               : return "volumenumber"
        }
    }
    
    internal var modelMapKey: String {
        switch self {
        case album_artist_name          : return "albumArtistName"
        case album_artistid             : return "albumArtistId"
        case album_id                   : return "albumId"
        case album_isexplicit           : return "albumIsExplicit"
        case album_label_id             : return "albumLabelId"
        case album_label_name           : return "albumLabelName"
        case album_name                 : return "albumName"
        case album_numberoftracks       : return "albumNumberOfTracks"
        case album_provider_id          : return "albumProviderId"
        case album_provider_name        : return "albumProviderName"
        case album_providerspecificid   : return "albumProviderSpecificId"
        case album_releasedate          : return "albumReleaseDate"
        case album_status_id            : return "albumStatusId"
        case .album_streetdate          : return "albumStreetDate"
        case album_upc                  : return "albumUpc"
        case album_volumenumber         : return "albumVolumeNumber"
        case artist_dateadded           : return "artistDateAdded"
        case artist_dateupdated         : return "artistDateUpdated"
        case artist_id                  : return "artistId"
        case artist_name                : return "artistName"
        case basefile                   : return "baseFile"
        case bitrate                    : return "bitRate"
        case dateadded                  : return "dateAdded"
        case dateupdated                : return "dateUpdated"
        case filesize                   : return "fileSize"
        case format_id                  : return "formatId"
        case geos                       : return "geos"
        case genre                      : return "genre"
        case id                         : return "id"
        case isexplicit                 : return "isExplicit"
        case isrc                       : return "isrc"
        case length                     : return "length"
        case provider_id                : return "providerId"
        case provider_name              : return "providerName"
        case providerspecid             : return "providerSpecId"
        case releasedate                : return "releaseDate"
        case relevant_title             : return "relevantTitle"
        case score                      : return "score"
        case statusid                   : return "statusId"
        case streetdate                 : return "streetDate"
        case title                      : return "title"
        case tracknumber                : return "trackNumber"
        case volumenumber               : return "volumeNumber"
        }
    }
    
    internal init?(queryString: String) {
        for mediaCase in MediaSelectParams.allCases {
            if queryString == mediaCase.queryString {
                self = mediaCase
                return
            }
        }
        return nil
    }
}

internal class _RHMediaRequest: RHRequest {
    
    internal typealias RequestType         = _RHMediaRequest
    internal typealias SelectRequestParams = MediaSelectParams
    internal typealias ExpandRequestParams = MediaExpandParams
    internal typealias ResponseModel       = RHMedia
    
    internal func select(values: [MediaSelectParams]) -> _RHMediaRequest {
        self.requestParams.updateValue(values.map { String($0.queryString) }.joinWithSeparator(","), forKey: RequestQuery.select.key)
        return self
    }
    
    internal func expand(values: [MediaExpandParams]) -> _RHMediaRequest {
        self.requestParams.updateValue(values.map { $0.queryString }.joinWithSeparator(","), forKey: RequestQuery.expand.key)
        return self
    }

    internal func start(completionBlock: ((totalCount: Int?, result: [RHMedia]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try super.start(ResponseModel.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
    
}

public class RHMediaRequest {
    
    private var request: _RHMediaRequest = _RHMediaRequest()
    
    internal init(session: NSURLSession?, baseURL: NSURL) {
        self.request = _RHMediaRequest(session: session, baseURL: baseURL)
    }
    
    internal init() {}
    
    public func select(values: [MediaSelectParams]) -> RHMediaRequest {
        self.request.select(values)
        return self
    }
    
    public func expand(values: [MediaExpandParams]) -> RHMediaRequest {
        self.request.expand(values)
        return self
    }
    
    public func start(completionBlock: ((totalCount: Int?, result: [RHMedia]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try self.request.start(RHMedia.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
    
    public func filter(value: Filter)  -> RHMediaRequest {
        self.request.filter(value)
        return self
    }
    
    public func format(value: ResponseFormat) -> RHMediaRequest {
        self.request.format(value)
        return self
    }
    
    public func inlinecount(value: Bool) -> RHMediaRequest {
        self.request.inlinecount(value)
        return self
    }
    
    public func keyword(value: String) -> RHMediaRequest {
        self.request.keyword(value)
        return self
    }
    
    public func skip(value: Int) -> RHMediaRequest {
        self.request.skip(value)
        return self
    }
    
    public func top(value: Int) -> RHMediaRequest {
        self.request.top(value)
        return self
    }
    
    public func idCdl(values: [Int]) -> RHMediaRequest {
        self.request.idCdl(values)
        return self
    }
    
}

