//
//  RHAlbumsRequest.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public enum AlbumExpandParams: Int, Queryable {
    
    case geos
    case genre
    
    internal var queryString: String {
        switch self {
        case .geos  : return "geos"
        case .genre : return "genres"
        }
    }
    
    internal init?(queryString: String) {
        for albumCase in AlbumExpandParams.allCases {
            if queryString == albumCase.queryString {
                self = albumCase
            }
        }
        return nil
    }
}

public enum AlbumSelectParams: Int, Queryable, Mappable {
    
    case artist_dateadded
    case artist_dateupdated
    case artist_id
    case artist_name
    case coverdeposited
    case geos
    case genres
    case id
    case isexplicit
    case label_id
    case label_name
    case length
    case name
    case numberoftracks
    case original_release_date
    case provider_id
    case provider_name
    case providerspecificid
    case releasedate
    case relevant_title
    case score
    case status_id
    case streetdate
    case upc
    case volumenumber
    
    internal var queryString: String {
        switch self {
        case .artist_dateadded        : return "artist_dateadded"
        case .artist_dateupdated      : return "artist_dateupdated"
        case .artist_id               : return "artist_id"
        case .artist_name             : return "artist_name"
        case .coverdeposited          : return "coverdeposited"
        case .geos                    : return "geos"
        case .genres                  : return "genres"
        case .id                      : return "id"
        case .isexplicit              : return "isexplicit"
        case .label_id                : return "label_id"
        case .label_name              : return "label_name"
        case .length                  : return "length"
        case .name                    : return "name"
        case .numberoftracks          : return "numberoftracks"
        case .original_release_date   : return "original_release_date"
        case .provider_id             : return "provider_id"
        case .provider_name           : return "provider_name"
        case .providerspecificid      : return "providerspecificid"
        case .releasedate             : return "releasedate"
        case .relevant_title          : return "relevant_title"
        case .score                   : return "score"
        case .status_id               : return "status_id"
        case .streetdate              : return "streetdate"
        case .upc                     : return "upc"
        case .volumenumber            : return "volumenumber"
        }
    }
    
    internal var modelMapKey: String {
        switch self {
        case .artist_dateadded        : return "artistDateAdded"
        case .artist_dateupdated      : return "artistDateUpdated"
        case .artist_id               : return "artistId"
        case .artist_name             : return "artistName"
        case .coverdeposited          : return "coverDeposited"
        case .geos                    : return "geos"
        case .genres                  : return "genres"
        case .id                      : return "id"
        case .isexplicit              : return "isExplicit"
        case .label_id                : return "labelId"
        case .label_name              : return "labelName"
        case .length                  : return "length"
        case .name                    : return "name"
        case .numberoftracks          : return "numberOfTracks"
        case .original_release_date   : return "originalReleaseDate"
        case .provider_id             : return "providerId"
        case .provider_name           : return "providerName"
        case .providerspecificid      : return "providerSpecificId"
        case .releasedate             : return "releaseDate"
        case .relevant_title          : return "relevantTitle"
        case .score                   : return "score"
        case .status_id               : return "statusId"
        case .streetdate              : return "streetDate"
        case .upc                     : return "upc"
        case .volumenumber            : return "volumeNumber"
        }
    }
    
    internal init?(queryString: String) {
        for albumCase in AlbumSelectParams.allCases {
            if queryString == albumCase.queryString {
                self = albumCase
                return
            }
        }
        return nil
    }
}

internal class _RHAlbumsRequest: RHRequest {
    
    internal typealias RequestType         = _RHAlbumsRequest
    internal typealias SelectRequestParams = AlbumSelectParams
    internal typealias ExpandRequestParams = AlbumExpandParams
    internal typealias ResponseModel       = RHAlbum
    
    internal func select(values: [AlbumSelectParams]) -> _RHAlbumsRequest {
        self.requestParams.updateValue(values.map { String($0.queryString) }.joinWithSeparator(","), forKey: RequestQuery.select.key)
        return self
    }
    
    internal func expand(values: [AlbumExpandParams]) -> _RHAlbumsRequest {
        self.requestParams.updateValue(values.map { $0.queryString }.joinWithSeparator(","), forKey: RequestQuery.expand.key)
        return self
    }
    
    internal func start(completionBlock: ((totalCount: Int?, result: [RHAlbum]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try super.start(ResponseModel.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
}

public class RHAlbumsRequest {
    
    private var request: _RHAlbumsRequest = _RHAlbumsRequest()
    
    internal init(session: NSURLSession?, baseURL: NSURL) {
        self.request = _RHAlbumsRequest(session: session, baseURL: baseURL)
    }
    
    internal init() {}
    
    public func select(values: [AlbumSelectParams]) -> RHAlbumsRequest {
        self.request.select(values)
        return self
    }
    
    public func expand(values: [AlbumExpandParams]) -> RHAlbumsRequest {
        self.request.expand(values)
        return self
    }
    
    public func start(completionBlock: ((totalCount: Int?, result: [RHAlbum]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try self.request.start(RHAlbum.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
    
    public func filter(value: Filter)  -> RHAlbumsRequest {
        self.request.filter(value)
        return self
    }
    
    public func format(value: ResponseFormat) -> RHAlbumsRequest {
        self.request.format(value)
        return self
    }
    
    public func inlinecount(value: Bool) -> RHAlbumsRequest {
        self.request.inlinecount(value)
        return self
    }
    
    public func keyword(value: String) -> RHAlbumsRequest {
        self.request.keyword(value)
        return self
    }
    
    public func skip(value: Int) -> RHAlbumsRequest {
        self.request.skip(value)
        return self
    }
    
    public func top(value: Int) -> RHAlbumsRequest {
        self.request.top(value)
        return self
    }
    
    public func idCdl(values: [Int]) -> RHAlbumsRequest {
        self.request.idCdl(values)
        return self
    }
}