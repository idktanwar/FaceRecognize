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
    var searchContoller: UISearchController!
    var searchText = ""
    var isSearchApplied = false
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getUserData()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK:- Methods
    private func setupUI() {
     
        searchContoller =  UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchContoller
        searchContoller.searchResultsUpdater = self
        searchContoller.searchBar.delegate = self
        
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
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
        viewController.user = usersVM.cellForRowAt(indexPath: indexPath)
        if isSearchApplied {
            viewController.isSearch = true
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

//MARK:- SearchBar Delegate

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count >= 2 {
            usersVM.searchUser(withQuery: searchText) {
                self.isSearchApplied = true
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
        }
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        self.isSearchApplied = false
        getUserData()
//        if let searchText = searchBar.text, searchText.count >= 2,!searchText.isEmpty {
//            self.isSearchApplied = false
//        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchContoller.isActive = false
        if let searchText = searchBar.text, searchText.count >= 2 {
            usersVM.searchUser(withQuery: searchText) {
                self.isSearchApplied = true
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
        }
    }
}
