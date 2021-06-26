//
//  UserDetailVC.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 26/06/21.
//

import UIKit

class UserDetailVC: UIViewController {

    //MARK:- Property
    var user: UserData?
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblMatchFound: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    var isSearch = false
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Methods
    private func setupUI(){
        
        let username = user?.name
        self.lblMessage.text = "Welcome to FaceApp \n\(username ?? "")"
        self.lblName.text = username
        self.lblDOB.text = user?.dob
        self.getImageFromPath(imageName: user?.imagePath)
        self.lblMatchFound.isHidden = !isSearch
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
    }

    private func getImageFromPath(imageName: String?){
        
        guard let imageName = imageName else {
            return
        }
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileurl = (documentDirectory.appendingPathComponent(imageName))

        if fileManager.fileExists(atPath: documentDirectory.path){
            self.imgProfile.image = UIImage(contentsOfFile: fileurl.path)
        }else{
            print("No Image")
        }
    }
}
