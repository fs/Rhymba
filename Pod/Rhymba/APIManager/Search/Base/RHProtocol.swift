//
//  a.swift
//  Rhymba
//
//  Created by Aynur Galiev on 02.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import Foundation

internal protocol Initializable {
    init()
}

internal protocol RHProtocol {
    
    associatedtype RequestType: Initializable
    associatedtype SelectRequestParams
    associatedtype ExpandRequestParams
    associatedtype ResponseModel
    
    var URLSession: NSURLSession { get set }
    
    func filter(value: String)  -> RequestType
    func select(values: [SelectRequestParams]) -> RequestType
    func expand(values: [ExpandRequestParams]) -> RequestType
    func format(value: ResponseFormat) -> RequestType
    func inlinecount(value: Bool) -> RequestType
    func keyword(value: String) -> RequestType
    func skip(value: Int) -> RequestType
    func top(value: Int) -> RequestType
    func idCdl(values: [Int]) -> RequestType
    func getQueryParams() -> NSURLComponents
    func start(completionBlock: ((result: [ResponseModel]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask
}

internal extension RHProtocol {
    
    internal func filter(value: String)  -> RequestType                { return RequestType() }
    internal func select(values: [SelectRequestParams]) -> RequestType { return RequestType() }
    internal func expand(values: [ExpandRequestParams]) -> RequestType {
        return RequestType()
    }
    internal func format(value: ResponseFormat) -> RequestType         { return RequestType() }
    internal func inlinecount(value: Bool) -> RequestType              { return RequestType() }
    internal func keyword(value: String) -> RequestType                { return RequestType() }
    internal func skip(value: Int) -> RequestType                      { return RequestType() }
    internal func top(value: Int) -> RequestType                       { return RequestType() }
    internal func idCdl(values: [Int]) -> RequestType                  { return RequestType() }
    internal func start(completionBlock: ((result: [ResponseModel]) -> Void)?, failureBlock: ((error: NSError?) -> Void)?) throws -> NSURLSessionDataTask { return NSURLSessionDataTask() }
}

internal enum SelectParameters { }
internal enum ExpandParameters { }
