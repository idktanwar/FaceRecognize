//
//  UserViewModel.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 26/06/21.
//

import Foundation

class UserViewModel {
    
    private var users = [UserData]()

    func fetchUserData(completion: @escaping () -> ()) {
        users.removeAll()
        
        let users = User.fetchUsersLists()
        
        if let users = users {
            for user in users {
                
                guard let name = user.name else {continue}
                guard let dob =  user.dob else {continue}
                guard let phonenum  = user.phoneNumber else {continue}
                guard let profilePath  = user.imgPath else {continue}
                
                let userData = UserData(name: name, dob: dob, imagePath: profilePath, phoneNo: phonenum)
                self.users.append(userData)
            }
        }
        completion()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return users.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> UserData {
        let user: UserData = users[indexPath.row]
        return user
    }
    
}
