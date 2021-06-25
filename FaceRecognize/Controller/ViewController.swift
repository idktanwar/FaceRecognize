//
//  ViewController.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
     
    }

    @IBAction func AddNewPeoples(_ sender: Any) {
        let vc  = self.storyboard?.instantiateViewController(identifier: "AddNewPeopleVC") as! AddNewPeopleVC
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .formSheet
        navVC.isModalInPresentation = true
        self.present(navVC, animated: true, completion: nil)
    }
    
   
    
    
}

//MARK:- AddNewPeopleDelegate

extension ViewController: NewPeopleAddedDelegate {
    
    func refreshMembersList() {
        DispatchQueue.main.async {
            
        }
    }
}
