//
//  AppDelegate.swift
//  RhymbaExample
//
//  Created by Aynur Galiev on 09.06.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//

import UIKit
import Rhymba

let access_token  = "8A6F5D352A0A4CC7BE78821589E8D126"
let access_secret = "0BB278FCB7BE41A9BD316D521A85052E"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Rhymba.initialize(accessToken: access_token, secretKey: access_secret)
        Rhymba.loggingLevel = .Verbose
        
        let filter = Filter.newInstance().startsWith("albumd_name", value: "j").startsWith("album_name", value: "a").greaterThan("id", value: 10)
        
        let request = Rhymba.Search.getMediaRequest()
        do {
            try request.expand([MediaExpandParams.geos])
                       .inlinecount(true)
                       .select([MediaSelectParams.album_id, .album_name])
                       .filter(filter)
                       .skip(100)
                       .top(100)
                       .start({ (totalCount, result) in
                
            }) { (error) in
                
            }
        } catch {
            
        }
        
        // Override point for customization after application launch.
        return true
    }
}

