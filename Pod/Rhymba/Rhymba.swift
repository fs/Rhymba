//
//  Rhymba.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

internal enum RequestQuery {
    
    case expand
    case filter
    case format
    case inlinecount
    case keyword
    case select
    case skip
    case top
    case id_cdl
    
    var key: String {
        switch self {
        case .expand      : return "$expand"
        case .filter      : return "$filter"
        case .format      : return "$format"
        case .id_cdl      : return "id_cdl"
        case .inlinecount : return "$inlinecount"
        case .keyword     : return "keyword"
        case .select      : return "$select"
        case .skip        : return "$skip"
        case .top         : return "$top"
        }
    }
}

public enum ResponseFormat: String {
    case JSON = "json"
}

internal enum Credential: String {
    case token     = "access_token"
    case secretKey = ""
}

public enum APIRequestError: ErrorType {
    
    case InitializeError
    case WrongResponseFormat
    case SerializationFailed
    
    public func getError() -> NSError {
        return NSError(domain: self.domain, code: 0, userInfo: self.userInfo)
    }
    
    internal var domain: String { return "com.Rhymba.API_Error" }
    
    internal var userInfo: [String : AnyObject] {
        switch self {
            case .InitializeError     : return [NSLocalizedDescriptionKey: "Wrong URL"]
            case .WrongResponseFormat : return [NSLocalizedDescriptionKey: "Response has wrong format"]
            case .SerializationFailed : return [NSLocalizedDescriptionKey: "Response serialization failed"]
        }
    }
}

public enum RHLoggingLevel: Int {
    case Silent
    case Verbose
}

internal func RHLog(format: String, args: CVarArgType) {
    if Rhymba.loggingLevel == .Verbose { NSLog(format, args) }
}

public class Rhymba: NSObject {

    internal static var token        : String = ""
    internal static var secretKey    : String = ""
    public   static var loggingLevel : RHLoggingLevel = .Silent
    
    public static func initialize(accessToken token: String, secretKey key: String) {
        self.secretKey  = key
        self.token      = token
    }
    
    internal static func getQueryItemForToken() -> NSURLQueryItem {
        return NSURLQueryItem(name: "access_token", value: self.token)
    }
    
    internal static func getQueryItemForSecretKey() -> NSURLQueryItem {
        return NSURLQueryItem(name: "secret_key", value: self.secretKey)
    }
    
    //API Managers
    public static var Search: APISearchManager { return APISearchManager.sharedInstance }
}

