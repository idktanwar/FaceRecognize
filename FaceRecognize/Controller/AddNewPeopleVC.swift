//
//  AddNewPeopleVC.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//

import UIKit

protocol NewPeopleAddedDelegate: AnyObject {
    func refreshMembersList()
}

class AddNewPeopleVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    weak var delegate: NewPeopleAddedDelegate?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPhoneno: UITextField!
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New People"
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissController))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveUser))
        self.navigationItem.rightBarButtonItem  = saveButtonItem
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgProfile.addGestureRecognizer(tapGesture)
        imgProfile.isUserInteractionEnabled = true
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.layer.borderWidth = 0.23
        imgProfile.layer.backgroundColor = UIColor.white.cgColor
        
        txtPhoneno.keyboardType = .numberPad
    }
    
    //MARK:- Selector
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveUser(){
        
        if !imageSelected {
            openAlert(title: "Alert", message: "Please select profile image", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay pressed")
                return
            }])
            return
        }
        
        //Save image to document directory
        let t1 = self.saveImage(image: imgProfile.image!)
        
        if txtName.text?.isEmpty ?? true {
            openAlert(title: "Alert", message: "Please enter name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay pressed")
                return
            }])
            return
        }
        
        if txtDOB.text?.isEmpty ?? true {
            showInvalidDateAlert()
            return
        }
        validateDate()
        
        if txtPhoneno.text?.isEmpty ?? true || !txtPhoneno.text!.isPhoneNumber || !(txtPhoneno.text!.count == 10)  {
            openAlert(title: "Alert", message: "Please enter valid phone number", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay pressed")
                return
            }])
            return
        }
        
        let name = txtName.text!
        let dob = txtDOB.text!
        let phone = txtPhoneno.text!
        
        let user = UserData(name: name, dob: dob, imagePath: t1.1, phoneNo: phone)
        _ = CoreDataManager.sharedInstance.addNewUser(user: user)
        
        if delegate != nil{
            self.delegate?.refreshMembersList()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.openCamera()
    }
    
    //Save image to documment directory
    private func saveImage(image: UIImage) -> (Bool, String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            return (false, "")
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return (false, "")
        }
        do {
            print(directory)
            let imagename = "\((UUID().uuidString)).jpeg"
            let path = directory.appendingPathComponent(imagename)!
            try data.write(to: path)
            return (true, imagename)
        } catch {
            print(error.localizedDescription)
            return (false, "")
        }
    }
    
    func validateDate(){
        let dateString = txtDOB.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy/"

        if dateFormatter.date(from: dateString) != nil {
            print("date is valid")
        } else {
            showInvalidDateAlert()
        }
    }
    
    func showInvalidDateAlert(){
        openAlert(title: "Alert", message: "Please enter valid DOB", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
            print("Okay pressed")
            return
        }])
    }
}

//MARK:- ImagePickerController

extension AddNewPeopleVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
            imageSelected = true
        }
        dismiss(animated: true)
    }
}
