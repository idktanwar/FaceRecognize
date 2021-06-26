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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:- Methods
    func configCell(user: UserData) {
        self.lblName.text = user.name
        self.lblDOB.text = user.dob
        self.lblPhoneNo.text = user.phoneNo
        
        self.getImageFromPath(path: user.imagePath)
    }
    
    private func getImageFromPath(path: String){
        let imageFromPath = UIImage(contentsOfFile: path)
        self.imgProfile.image = imageFromPath
    }
}
