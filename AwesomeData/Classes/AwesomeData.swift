//
//  AwesomeData.swift
//  AwesomeData
//
//  Created by Evandro Harrison Hoffmann on 27/08/2016.
//  Copyright © 2016 It's Day Off. All rights reserved.
//

import UIKit

open class AwesomeData: NSObject {

    open static let cacheCountLimit     = 50
    open static let cacheTotalCostLimit = 1024*1024
    
    open static var showLogs = false
    
    /*
     *  Print logs if activated
     *  @param message: Message to log
     */
    open static func log(_ message: String){
        if showLogs {
            print(message)
        }
    }
    
    /*
     *  Transforms URL to Hash
     *  @param url: Url to transform
     */
    open static func hashUrl(_ url: String) -> String? {
        let urlArray = url.components(separatedBy: "/")
        if urlArray.count > 2 {
            return urlArray[2] + ":" + urlArray.last!
        }
        return nil
    }
    
    /*
     *  Sets Database
     *  @param name: Name of the database
     */
    open static func setDatabase(_ name: String){
        AwesomeDataAccess.sharedInstance.setDatabase(name)
    }
    
    /*
     *  Save Database Context
     */
    open static func saveContext(){
        AwesomeDataAccess.sharedInstance.saveContext()
    }
    
}
