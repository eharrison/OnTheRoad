//
//  DataAccess.swift
//  AwesomeData
//
//  Created by Evandro Harrison Hoffmann on 10/19/15.
//  Copyright © 2015 It's Day Off. All rights reserved.
//

import UIKit
import CoreData

//let GROUPNAME = "group.com.itsdayoff.EmagrecerDeVez.Documents"
//let DATABASE_NAME = "PrevisaoDoTempo"
//let DATABASE_NAME_SQLITE = "\(DATABASE_NAME).sqlite"

open class AwesomeDataAccess: NSObject {
    
    static open var sharedInstance = AwesomeDataAccess()
    
    var databaseName: String!
    var databaseNameSqlite: String!
    
    override init(){
        super.init()
    }
    
    init(databaseName: String) {
        super.init()
        setDatabase(databaseName)
    }
    
    open func setDatabase(_ name: String){
        databaseName = name
        databaseNameSqlite = "\(databaseName).sqlite"
    }
    
    // MARK: - Local Core Data stack
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    // MARK: - Core Data stack
    
    open lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
        }()
    
    open lazy var managedObjectModel: NSManagedObjectModel = {
        if self.databaseName == nil {
            NSLog("You forgot setting up the database name")
            abort()
        }
        
        let modelURL = Bundle.main.url(forResource: self.databaseName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
        }()
    
    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    open func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
