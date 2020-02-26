//
//  HomeTableViewController.swift
//  huduma
//
//  Created by macbook on 05/03/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomeTableViewController: UITableViewController {
    
    
    var departments = [Department]()
    var retrievedString: String? {
        KeychainWrapper.standard.string(forKey: "token")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MMU Departments"
        loadDepartments()
        
        
    }
    

    let session: URLSession = .shared
    func loadDepartments() {
        let resourceString = "https://hudumammu.herokuapp.com/api/v1/departments/"
        guard let resourceURL = URL(string: resourceString) else {
            return
        }
        var urlRequest = URLRequest(url: resourceURL)
        guard let token = retrievedString else { return }
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard let data = data,
                error == nil
                else {
                    print(error?.localizedDescription ?? "No data")
                    return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let responseJSON = try jsonDecoder.decode([Department].self, from: data)
                if let responseJSON = responseJSON as? [Department] {
                    self.departments = responseJSON
                }
            } catch {
               print("Bad data ?? \(error.localizedDescription)")
            }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
        task.resume()

    }
    // MARK: - Table view data source
    
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return departments.count
    }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentItem", for: indexPath)
            cell.textLabel?.text = departments[indexPath.row].name
            cell.detailTextLabel?.text = departments[indexPath.row].service
            return cell
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "moveToDetail", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.department = departments[(tableView.indexPathForSelectedRow?.row)!]
            tableView.deselectRow(at: (tableView?.indexPathForSelectedRow!)!, animated: true)
        }
    }
    
    
    
    
}

