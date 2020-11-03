//
//  ViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 24/06/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift
import SideMenu
import FirebaseAuth

class PasswordListViewController: UIViewController, SideMenuControllerDelegate {
    
    @IBOutlet weak var passwordTableView: UITableView!
    private var sideMenu: SideMenuNavigationController?
    var passwordViewModel: PasswordViewModelProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = SideMenuViewController()
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        passwordTableView.dataSource = self
        passwordViewModel = PasswordViewModel(webService: WebService())
        passwordViewModel?.passwordCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        passwordViewModel?.fetchPasswords()
        
    }
    
    @IBAction func addPasswordClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createNewPasswordSegue", sender: nil)
    }
    
    @IBAction func menuButtonTapped() {
        present(sideMenu!, animated: true)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewPasswordSegue" {
            if let viewController = segue.destination as? NewPasswordViewController {
                viewController.passwordViewModel = self.passwordViewModel
            }
        }
    }
    
    func repopulateView() {
        self.passwordTableView.reloadData()
    }
    
    func didSelectMenuItem(withName: MenuLabel) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        switch withName {
        case .appInfo:
            view.backgroundColor = .black
        case .groups:
            view.backgroundColor = .blue
        case .passwords:
            passwordViewModel?.fetchPasswords()
            repopulateView()
        case .groupPasswords:
            passwordViewModel?.fetchGroupPasswords()
            repopulateView()
        case .signOut:
            signOut()
        }
    }
    
}

extension PasswordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (passwordViewModel?.passwordCollection.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        cell.passwordDetails = passwordViewModel?.passwordCollection.value[indexPath.row]
        cell.vendorNameLabel.text = cell.passwordDetails.vendorName
        return cell
    }
    
    
}

