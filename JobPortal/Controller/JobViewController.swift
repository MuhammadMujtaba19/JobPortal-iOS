//
//  JobViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/28/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class JobViewController: UIViewController{
    
    @IBOutlet weak var JobTableView: UITableView!
    var id :Int?
    @IBOutlet weak var searchBar: UISearchBar!
    var jobs = [Job]()
    var filteredjobs = [Job]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        JobTableView.delegate = self
        JobTableView.dataSource = self
        
            AF.request("http://127.0.0.1:8080/api/Job/GetAllJobs").responseJSON { (response) in
                do{
//                    print(response)
                    let decoder = JSONDecoder()
                    let models = try decoder.decode([Job].self, from:
                        response.data!) //Decode JSON Response Data
                            for model in models{
                                self.jobs.append(model)
                                
                            }
                    self.filteredjobs = self.jobs

                    self.JobTableView.reloadData()
                }catch{

                }
        }
        
        JobTableView.register(UINib(nibName: "JobViewCell", bundle: nil), forCellReuseIdentifier:"JobCell")
        
        JobTableView.rowHeight = 70
        
        // Do any additional setup after loading the view.
    }
    
}
extension JobViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // When there is no text, filteredData is the same as the original data
           // When user has entered text into the search box
           // Use the filter method to iterate over all items in the data array
           // For each item, return true if the item should be included and false if the
           // item should NOT be included
        filteredjobs = searchText.isEmpty ? jobs : jobs.filter { (item: Job) -> Bool in
               // If dataItem matches the searchText, return true to include it
            return item.Title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
           }
           
           JobTableView.reloadData()
       }
}
extension JobViewController:UITableViewDelegate{
    
}
extension JobViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredjobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobViewCell
        cell.JobTitle?.text = filteredjobs[indexPath.row].Designation
        cell.JobCompany?.text = filteredjobs[indexPath.row].Organization
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = indexPath.row
        self.performSegue(withIdentifier: "jobDetail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="jobDetail"){
            print("here")
    }
    }
}
