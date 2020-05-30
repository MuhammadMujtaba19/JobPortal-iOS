//
//  JobViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/28/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class JobViewController: UIViewController {
    
    @IBOutlet weak var JobTableView: UITableView!
    var jobs = [Job]()
    override func viewDidLoad() {
        super.viewDidLoad()
        JobTableView.delegate = self
        JobTableView.dataSource = self
            AF.request("http://127.0.0.1:8080/api/Job/GetAllJobs").responseJSON { (response) in
                do{
                    print(response)
                    let decoder = JSONDecoder()
                    let models = try decoder.decode([Job].self, from:
                        response.data!) //Decode JSON Response Data
                            for model in models{
                                self.jobs.append(model)
                                print(model.Title)
                            }
                    self.JobTableView.reloadData()
                }catch{

                }
        }
        
        JobTableView.register(UINib(nibName: "JobViewCell", bundle: nil), forCellReuseIdentifier:"JobCell")
        
        JobTableView.rowHeight = 70
        

        // Do any additional setup after loading the view.
    }
    
}
extension JobViewController:UITableViewDelegate{
    
}
extension JobViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobViewCell
        cell.JobTitle?.text = jobs[indexPath.row].Designation
        cell.JobCompany?.text = jobs[indexPath.row].Organization
        
        return cell
        
    }
    
    
}
