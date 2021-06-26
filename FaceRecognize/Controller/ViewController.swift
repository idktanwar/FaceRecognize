//
//  ViewController.swift
//  FaceRecognize
//
//  Created by Dinesh Tanwar on 25/06/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Property
    @IBOutlet weak var tblView: UITableView!
    var usersVM = UserViewModel()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }
    
    //MARK:- Methods
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
     
        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView(frame: .zero)
    }

    func getUserData() {
        usersVM.fetchUserData {
            [weak self] in
            DispatchQueue.main.async {
                self?.tblView.delegate = self
                self?.tblView.dataSource = self
                self?.tblView.reloadData()
            }
        }
    }
    
    //MARK: Selectors
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
        print("Refresh the list")
        getUserData()
    }
}

//MARK:- Tableview Delegate and Datasource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersVM.numberOfRowsInSection(section: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
       
        let user = usersVM.cellForRowAt(indexPath: indexPath)
        cell.configCell(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

