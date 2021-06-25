//
//  CoreDataHelper.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let sharedInstance = CoreDataManager()

    let model: String = "FaceRecognize"

    lazy var persistentContainer: NSPersistentContainer = {
        
        let bundle = Bundle(for: CoreDataManager.self)
        let modelURL = bundle.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()

    //Add New Task Item
    func addNewUser(user: UserData) -> Bool {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return User.addNewUser(user: user, context: context)
    }
}



