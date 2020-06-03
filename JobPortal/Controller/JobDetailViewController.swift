//
//  JobDetailViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/30/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class JobDetailViewController: UIViewController {

    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobDescription: UILabel!
    var jobdetail :JobDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("http://127.0.0.1:8080/api/Job/Detail/1111").responseJSON { (response) in
                           do
                            {
                             let decoder = JSONDecoder()
                               let models = try decoder.decode([JobDetails].self, from:response.data!)
                                self.jobdetail = models[0]
                                DispatchQueue.main.async {
                                    guard (self.jobdetail?.Designation) != nil else {
                                      print("Error!")
                                      return
                                    }
                                self.JobTitle.text = self.jobdetail?.Title
                                }
                           }
                           catch{

                            }
            }
    
        // Do any additional setup after loading the view.
    }
    

}
