//
//  User+CoreDataClass.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    @nonobjc public class func getFetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    //add the new user to local DB
    class func addNewUser(user: UserData, context: NSManagedObjectContext) -> Bool {
        
        guard let newuser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User else {
            return false
        }
        
        newuser.name             = user.name
        newuser.phoneNumber      = user.phoneNo
        newuser.dob              = user.dob
        newuser.imgPath          = user.imagePath
        
        do {
            try context.save()
            print("✅ User saved succesfuly")
            return true
            
        } catch let error {
            print("❌ Failed to add new user: \(error.localizedDescription)")
            return false
        }
        
    }
    
}
