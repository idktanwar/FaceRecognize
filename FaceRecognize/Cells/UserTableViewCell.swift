//
//  UserTableViewCell.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 26/06/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    //MARK:- Property
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    
    //MARK:- lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:- Methods
    func configCell(user: UserData) {
        self.lblName.text = user.name
        self.lblDOB.text = user.dob
        self.lblPhoneNo.text = user.phoneNo
        
        self.getImageFromPath(imageName: user.imagePath)
    }
    
    private func getImageFromPath(imageName: String){

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
