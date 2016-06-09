//
//  RHRequest.swift
//  Rhymba
//
//  Created by Aynur Galiev on 31.05.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

internal protocol Queryable: RawRepresentable {
    var queryString: String { get }
    init?(queryString: String)
}

internal protocol Mappable {
    var modelMapKey: String { get }
}

internal class RHRequest: RHProtocol, Initializable {

    internal struct Default {
        static var defaultFormat = ResponseFormat.JSON
        static var defaultSkip   = 0
        static var defaultTop    = 10
    }
    
    internal typealias RequestType         = RHRequest
    internal typealias SelectRequestParams = SelectParameters
    internal typealias ExpandRequestParams = ExpandParameters
    internal typealias ResponseModel       = RHModel
    
    internal var baseURL: NSURL = NSURL()
    internal var URLSession: NSURLSession = NSURLSession.sharedSession()
    internal var requestParams: [String : String] = [:]
    
    internal required init() {}
    
    required internal init(session: NSURLSession?, baseURL: NSURL) {
        self.baseURL = baseURL
        if let lSession = session { self.URLSession = lSession }
        self.format(Default.defaultFormat)
        self.top(Default.defaultTop)
        self.skip(Default.defaultSkip)
    }
    
    internal func filter(value: Filter)  -> RHRequest {
        guard let lStringValue = value.getFormattedString() else {
            NSLog("WARNING: Filter's format is wrong. Aborting filter")
            return self
        }
        self.requestParams.updateValue(lStringValue, forKey: RequestQuery.filter.key)
        return self
    }
    
    internal func format(value: ResponseFormat) -> RHRequest {
        self.requestParams.updateValue(value.rawValue, forKey: RequestQuery.format.key)
        return self
    }
    
    internal func inlinecount(value: Bool) -> RHRequest {
        if value {
            self.requestParams.updateValue("allpages", forKey: RequestQuery.inlinecount.key)
        } else {
            self.requestParams.removeValueForKey(RequestQuery.inlinecount.key)
        }
        return self
    }
    
    internal func keyword(value: String) -> RHRequest {
        self.requestParams.updateValue(value, forKey: RequestQuery.keyword.key)
        return self
    }
    
    internal func skip(value: Int) -> RHRequest {
        self.requestParams.updateValue(String(value), forKey: RequestQuery.skip.key)
        return self
    }
    
    internal func top(value: Int) -> RHRequest {
        self.requestParams.updateValue(String(value), forKey: RequestQuery.top.key)
        return self
    }
    
    internal func idCdl(values: [Int]) -> RHRequest {
        self.requestParams.updateValue(values.stringValue(), forKey: RequestQuery.id_cdl.key)
        return self
    }
    
    internal func getQueryParams() -> NSURLComponents {
        let components = NSURLComponents()
        var items: [NSURLQueryItem] = []
        items.append(Rhymba.getQueryItemForToken())
        for (key, value) in self.requestParams {
            let queryItem = NSURLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        components.queryItems = items
        components.host       = self.baseURL.host
        components.scheme     = self.baseURL.scheme
        components.path       = self.baseURL.path
        return components
    }
    
    internal func start<T: RHModel>(modelType: T.Type, completionBlock: ((totalCount: Int?, result: [T]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask {
        
        let queryParams = self.getQueryParams()
        let url = queryParams.URLRelativeToURL(self.baseURL)
        
        guard let queryURL = url else {
            throw APIRequestError.InitializeError
        }
        
        let task = self.URLSession.dataTaskWithURL(queryURL, completionHandler: { (data: NSData?, response: NSURLResponse?, requestError: NSError?) in
            
            RHLog("RHYMBA: Response from URL %@ did received", args: response?.URL ?? NSURL())
            
            if let lData = data where requestError == nil {
                
                do {
                    guard let dicts = try NSJSONSerialization.JSONObjectWithData(lData, options: NSJSONReadingOptions.AllowFragments) as? Dictionary<String, AnyObject>,
                          let dictArray = dicts["value"] as? Array<Dictionary<String, AnyObject>> else {
                            RHLog("RHYMBA: Error at line \(#line) - %@", args: APIRequestError.WrongResponseFormat.getError().localizedDescription)
                            throw APIRequestError.WrongResponseFormat
                    }
                    
                    var totalCount: Int? = nil
                    if let stringValue = dicts["odata.count"] as? String, let intValue = Int(stringValue) { totalCount = intValue }
                    
                    var models: [T] = []
                    for dict in dictArray {
                        let model = T()
                        model.update(withDictionary: dict)
                        models.append(model)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        completionBlock?(totalCount: totalCount, result: models)
                    })
                    
                } catch let err as NSError {
                    RHLog("RHYMBA: Error at line \(#line) - %@", args: err.localizedDescription)
                    dispatch_async(dispatch_get_main_queue(), {
                        failureBlock?(error: err)
                    })
                } catch {
                    RHLog("RHYMBA: Error at line \(#line) %@", args: "")
                    dispatch_async(dispatch_get_main_queue(), {
                        failureBlock?(error: requestError)
                    })
                }
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    failureBlock?(error: requestError)
                })
            }
        })
        
        task.resume()
        return task
    }
}

