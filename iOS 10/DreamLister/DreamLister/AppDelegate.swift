//
//  AppDelegate.swift
//  DreamLister
//
//  Created by robot on 3/13/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    var window: UIWindow?;
    
    // MARK: - Core Data stack
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        //goalpost.xcdatamodeld  The name of the CoreData model
        let container = NSPersistentContainer(name: "DreamLister")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    //iOS 9 coredata
    lazy var applicationDocumentsDirectory: URL = {
           let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return urls[urls.count-1]
       }()

       lazy var managedObjectModel: NSManagedObjectModel = {
           //goalpost.xcdatamodeld  The name of the CoreData model
           let modelURL = Bundle.main.url(forResource: "DreamLister", withExtension: "momd")!
           return NSManagedObjectModel(contentsOf: modelURL)!
       }()

       lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
           let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
           //goalpost.xcdatamodeld  The name of the CoreData model
           let url = self.applicationDocumentsDirectory.appendingPathComponent("DreamLister.sqlite")
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

       lazy var managedObjectContext: NSManagedObjectContext = {
           let coordinator = self.persistentStoreCoordinator
           var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
           managedObjectContext.persistentStoreCoordinator = coordinator
           managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
           return managedObjectContext
       }()

    // MARK: - Core Data Saving support
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
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

}

let ad = UIApplication.shared.delegate as! AppDelegate;

var context: NSManagedObjectContext {
    if #available(iOS 10.0, *) {
    return ad.persistentContainer.viewContext;
    } else {
    return ad.managedObjectContext;
    }
}
