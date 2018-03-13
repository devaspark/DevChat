//
//  MessageVC.swift
//  DevChat
//
//  Created by Rex Kung on 3/10/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class MessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgField: UITextField!
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    private var _MsgString: String?

    var MsgString: String? {
        set {
            _MsgString = newValue
        } get {
            return _MsgString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.getUserList { (userList) in
            self.users = userList
            self.tableView.reloadData()
        }
        
    }

    @IBAction func BackBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendBtnPressed(_ sender: UIBarButtonItem) {
        
        if let message = msgField.text, message.count > 0 {
            DataService.instance.sendMessage(message: msgField.text!, selectedUsers: selectedUsers)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error No Message", message: "Please type a message before sending", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgUserCell") as! MsgUserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! MsgUserCell
        cell.checkMarked(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MsgUserCell
        cell.checkMarked(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
