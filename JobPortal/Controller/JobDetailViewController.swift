//
//  JobDetailViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/30/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
class JobDetailViewController: UIViewController {

    var jobid:Int?
    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobCompany: UILabel!
    @IBOutlet weak var JobDescriptionTable: UITableView!
    var desc=[String]()
    var studentData:Student?
    
    let xPos : CGFloat = 10
       var yPos : CGFloat = 250
    let textViewFont = UIFont.systemFont(ofSize: 16)
    
    var jobdetail :JobDetails?
    override func viewDidLoad() {
        if let currentStudent = UserDefaults.standard.data(forKey: "current"){
            studentData = try? JSONDecoder().decode(Student.self, from: currentStudent)
        }

        
        super.viewDidLoad()
        print("Jobid \(jobid!)")
        
        JobDescriptionTable.dataSource = self
        JobDescriptionTable.delegate = self

        
        
        JobDescriptionTable.separatorStyle = .none
        AF.request("http://127.0.0.1:8080/api/job/detail/\(jobid!)").responseJSON { (response) in
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
                                self.JobCompany.text = self.jobdetail?.Organization
                                for i in models{
                                    self.desc.append(i.Description!)
                                }
                                    self.JobDescriptionTable.estimatedRowHeight  = 100
                                    self.JobDescriptionTable.rowHeight = UITableView.automaticDimension
                                    self.JobDescriptionTable.reloadData()
                            }
                    }
                    catch{

                    }
            }
        JobDescriptionTable.reloadData()
  


        // Do any additional setup after loading the view.
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    @IBAction func ApplyButton(_ sender: UIButton) {
//        api/apply
        let parameters = [
            "StudentId": studentData?.StudentID!,
            "JobId" : jobid!
        
               ] as [String : Any]
        
        AF.request("http://127.0.0.1:8080/api/apply/", method: HTTPMethod.post, parameters: parameters).response { (response) in

        }
        
        ProgressHUD.showSucceed()
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desc.count
    }
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell" ,for: indexPath) as! DescriptionCell
        cell.DescriptionLabel?.text = desc[indexPath.row]
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobViewCell
//        cell.JobTitle?.text = desc[indexPath.row]
////        cell.JobCompany?.text = [indexPath.row].Organization
//        return cell
//
    }
    
    
}




//
//                                 self.yPos += 60
//                                 let tf = UITextView()
//
//                                  tf.frame = CGRect(x: self.xPos, y: self.yPos, width: 400, height: 50)
//
//                                      tf.text = i.Description
//                                      tf.font =  UIFont.systemFont(ofSize: 20)
//                                      self.adjustUITextViewHeight(arg: tf)
//                                      self.view.addSubview(tf)
