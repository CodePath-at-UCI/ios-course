//
//  ViewController.swift
//  Unit 1 Lab
//
//  Created by Mingjia Wang on 4/7/20.
//  Copyright © 2020 Mingjia Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let students = ["Hermain","Derek","Mingjia","Chase","Lily","Ethan"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell") as! StudentCell
        
        let student = students[indexPath.row]
        
        cell.studentNameLabel.text = student
        
        return cell
    }

}

