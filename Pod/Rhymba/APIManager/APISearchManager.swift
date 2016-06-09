//
//  APISearchManager.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

public class APISearchManager: NSObject {
    
    private override init() { super.init() }
    
    private var session: NSURLSession = NSURLSession.sharedSession()
    private let baseURL: NSURL = NSURL(string: "https://search.mcnemanager.com/current/content.odata")!
    
    public class var sharedInstance: APISearchManager {
        struct Static {
            static var instance: APISearchManager = APISearchManager()
        }
        return Static.instance
    }
    
    public func getMediaRequest() -> RHMediaRequest {
        return RHMediaRequest(session: self.session, baseURL: self.baseURL.URLByAppendingPathComponent(ContentType.Media.path))
    }
    
    public func getAlbumsRequest() -> RHAlbumsRequest {
        return RHAlbumsRequest(session: self.session, baseURL: self.baseURL.URLByAppendingPathComponent(ContentType.Albums.path))
    }
    
    public func getArtistsRequest() -> RHArtistsRequest {
        return RHArtistsRequest(session: self.session, baseURL: self.baseURL.URLByAppendingPathComponent(ContentType.Artists.path))
    }
}

public enum ContentType {
    
    case Media
    case Albums
    case Artists
    
    var path: String {
        switch self {
        case .Media   : return "Media()"
        case .Albums  : return "Albums()"
        case .Artists : return "Artists()"
        }
    }
}