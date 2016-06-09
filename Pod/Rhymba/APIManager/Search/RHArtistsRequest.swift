//
//  RHArtistsRequest.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public enum ArtistsExpandParams: Int, Queryable {
    
    case influences
    case genres
    case media_genres
    case media_providers
    
    internal var queryString: String {
        switch self {
            case .influences      : return "influences"
            case .genres          : return "genres"
            case .media_genres    : return "media_genres"
            case .media_providers : return "media_providers"
        }
    }
    
    internal init?(queryString: String) {
        for artistCase in ArtistsExpandParams.allCases {
            if queryString == artistCase.queryString {
                self = artistCase
            }
        }
        return nil
    }
}


public enum ArtistsSelectParams: Int, Queryable, Mappable {

    case description
    case genres
    case id
    case influences
    case language
    case media_genres
    case media_providers
    case name
    case plain_text_name
    case score
    
    internal var queryString: String {
        switch self {
            case .description     : return "description"
            case .genres          : return "genres"
            case .id              : return "id"
            case .influences      : return "influences"
            case .language        : return "language"
            case .media_genres    : return "media_genres"
            case .media_providers : return "media_providers"
            case .name            : return "name"
            case .plain_text_name : return "plain_text_name"
            case .score           : return "score"
        }
    }
    
    internal var modelMapKey: String {
        switch self {
        case .description     : return "artistDescription"
        case .genres          : return "genres"
        case .id              : return "id"
        case .influences      : return "influences"
        case .language        : return "language"
        case .media_genres    : return "mediaGenres"
        case .media_providers : return "mediaProviders"
        case .name            : return "name"
        case .plain_text_name : return "plainTextName"
        case .score           : return "score"
        }
    }
    
    internal init?(queryString: String) {
        for artistCase in ArtistsSelectParams.allCases {
            if queryString == artistCase.queryString {
                self = artistCase
                return
            }
        }
        return nil
    }
}

internal class _RHArtistsRequest: RHRequest {
    
    internal typealias RequestType         = _RHArtistsRequest
    internal typealias SelectRequestParams = ArtistsSelectParams
    internal typealias ExpandRequestParams = ArtistsExpandParams
    internal typealias ResponseModel       = RHArtist
    
    internal func select(values: [ArtistsSelectParams]) -> _RHArtistsRequest {
        self.requestParams.updateValue(values.map { String($0.queryString) }.joinWithSeparator(","), forKey: RequestQuery.select.key)
        return self
    }
    
    internal func expand(values: [ArtistsExpandParams]) -> _RHArtistsRequest {
        self.requestParams.updateValue(values.map {$0.queryString}.joinWithSeparator(","), forKey: RequestQuery.expand.key)
        return self
    }
    
    internal func start(completionBlock: ((totalCount: Int?, result: [RHArtist]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try super.start(ResponseModel.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
}

public class RHArtistsRequest {
    
    private var request: _RHArtistsRequest = _RHArtistsRequest()
    
    internal init(session: NSURLSession?, baseURL: NSURL) {
        self.request = _RHArtistsRequest(session: session, baseURL: baseURL)
    }
    
    internal init() {}
    
    public func select(values: [ArtistsSelectParams]) -> RHArtistsRequest {
        self.request.select(values)
        return self
    }
    
    public func expand(values: [ArtistsExpandParams]) -> RHArtistsRequest {
        self.request.expand(values)
        return self
    }
    
    public func start(completionBlock: ((totalCount: Int?, result: [RHArtist]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        return try self.request.start(RHArtist.self, completionBlock: completionBlock, failureBlock: failureBlock)
    }
    
    public func filter(value: Filter)  -> RHArtistsRequest {
        self.request.filter(value)
        return self
    }
    
    public func format(value: ResponseFormat) -> RHArtistsRequest {
        self.request.format(value)
        return self
    }
    
    public func inlinecount(value: Bool) -> RHArtistsRequest {
        self.request.inlinecount(value)
        return self
    }
    
    public func keyword(value: String) -> RHArtistsRequest {
        self.request.keyword(value)
        return self
    }
    
    public func skip(value: Int) -> RHArtistsRequest {
        self.request.skip(value)
        return self
    }
    
    public func top(value: Int) -> RHArtistsRequest {
        self.request.top(value)
        return self
    }
    
    public func idCdl(values: [Int]) -> RHArtistsRequest {
        self.request.idCdl(values)
        return self
    }
}