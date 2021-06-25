//
//  User+CoreDataProperties.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var imgPath: String?
    @NSManaged public var dob: String?
    @NSManaged public var phoneNumber: String?

}

extension User : Identifiable {

}
