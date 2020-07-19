//
//  ViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/20/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    @IBOutlet weak var expirenceTableView: UITableView!
    @IBOutlet weak var StudentNameText: UILabel!
    
    @IBOutlet weak var StudentRollNumberText: UILabel!
    
    var exp = [Experience]()
    var proj = [Project]()
    var skill = [Skill]()
    var studentProfile :StudentProfile?
    var studentData:Student?
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        studentProfile = StudentProfile()
        
        if let currentStudent = UserDefaults.standard.data(forKey: "current"){
            studentData = try? JSONDecoder().decode(Student.self, from: currentStudent)
        }
        StudentNameText.text = studentData?.SName
        StudentRollNumberText.text = studentData?.RollNumber
        let StudentID:Int = (studentData?.StudentID)!
        
        print(StudentID)
        GetExperience(StudentID: StudentID)
        GetProjects(StudentID: StudentID)
        GetSkills(StudentID: StudentID)

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        expirenceTableView.addSubview(refreshControl)
        expirenceTableView.delegate = self
        expirenceTableView.dataSource  = self

        expirenceTableView.register(UINib(nibName: "ExperienceViewCell", bundle: nil), forCellReuseIdentifier:"experienceCell")
        expirenceTableView.rowHeight = 140

        expirenceTableView.register(UINib(nibName: "ProjectViewCell", bundle: nil), forCellReuseIdentifier:"projectCell")
        expirenceTableView.rowHeight = 140
    }
  
    func GetExperience(StudentID:Int)  {
        AF.request("http://127.0.0.1:8080/api/studentProfile/GetExperienceByID/\(StudentID)").responseJSON { (response) in
            do{
                
                let decoder = JSONDecoder()
                let models = try decoder.decode([Experience].self, from:
                    response.data!) //Decode JSON Response Data
                        for model in models{
                            self.studentProfile?.experiences.append(model)
                        }
                self.expirenceTableView.reloadData()
            }catch{

            }
        }
    }
    func GetProjects(StudentID:Int)  {
         
               AF.request("http://127.0.0.1:8080/api/studentProfile/GetProjectsByID/\(StudentID)").responseJSON { (response) in
                   do{
                       
                       let decoder = JSONDecoder()
                       let models = try decoder.decode([Project].self, from:
                           response.data!) //Decode JSON Response Data
                               for model in models{
                                   self.studentProfile?.projects.append(model)
                               }
                       self.expirenceTableView.reloadData()
                   }catch{

                   }
               }
    }
    func GetSkills(StudentID:Int)  {
                AF.request("http://127.0.0.1:8080/api/studentProfile/GetSkillsByID/\(StudentID)").responseJSON { (response) in
                    do{
                        let decoder = JSONDecoder()
                        let models = try decoder.decode([Skill].self, from:response.data!) //Decode JSON Response Data
                                for model in models{
                                    self.studentProfile?.skills.append(model)
                                }
                        self.expirenceTableView.reloadData()
                    }catch{
                        
                    }
                }
    }
    @objc func refresh(_ sender: AnyObject) {
        studentProfile = StudentProfile()
        GetExperience(StudentID: 6)
        GetProjects(StudentID: 6)
        GetSkills(StudentID: 6)
        expirenceTableView.reloadData()
        refreshControl.endRefreshing()

    }
    @IBAction func OnLogoutClick(_ sender: UIButton) {
//        UserDefaults.standard.
//        UserDefaults.standard.set(session_data, forKey: "current")
//        UserDefaults.standard.set(true, forKey: "userLoggedIn")
//        UserDefaults.standard.set(currentStudent.StudentID, forKey: "StudentID")
        UserDefaults.standard.removeObject(forKey: "current")
        UserDefaults.standard.removeObject(forKey: "userLoggedIn")
        UserDefaults.standard.removeObject(forKey: "StudentID")
        let story = UIStoryboard(name: "Main", bundle:nil)
           let vc = story.instantiateViewController(withIdentifier: "loginScreen") as! LoginViewController
           UIApplication.shared.windows.first?.rootViewController = vc
           UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return studentProfile.count
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount:Int = 0
           if section == 0 {
               rowCount = studentProfile?.experiences.count ?? 0
//            rowCount = exp.count
           }
           if section == 1 {
            rowCount = studentProfile?.projects.count ?? 0
            }
        if section == 2{
            rowCount = studentProfile?.skills.count ?? 0
        }
           return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        if indexPath.section == 0 {
//            let qtv = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! ExperienceViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! ExperienceViewCell
//            (cell as! ExperienceViewCell).JobDesignation?.text = exp[indexPath.row].Designation
//            (cell as! ExperienceViewCell).JobDescription?.text = exp[indexPath.row].JDescription
            
            (cell as! ExperienceViewCell).JobDesignation?.text =  studentProfile!.experiences[indexPath.row].Designation
            (cell as! ExperienceViewCell).JobDescription?.text = studentProfile!.experiences[indexPath.row].JDescription
        }
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectViewCell
            (cell as! ProjectViewCell).ProjectName?.text = studentProfile!.projects[indexPath.row].ProjectName
            (cell as! ProjectViewCell).GithubLink?.text = studentProfile!.projects[indexPath.row].GithubLink
            (cell as! ProjectViewCell).FrameworkName?.text = studentProfile!.projects[indexPath.row].Fname
        }
        if indexPath.section == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectViewCell
            (cell as! ProjectViewCell).ProjectName?.text = studentProfile!.skills[indexPath.row].SkillName
            (cell as! ProjectViewCell).GithubLink?.text = studentProfile!.skills[indexPath.row].DomainName
            (cell as! ProjectViewCell).FrameworkName?.text = ""

            
        }
        //        cell.title?.text = studentProfile[indexPath.section].value?[indexPath.row]
//        cell.title?.text = StudentProfile[indexPath.section].
           return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! headerCell
        if section == 0 {
            cell.SectionTitle.text = "Work Experience"
            cell.sectionButton.setTitle("Add Experience", for: .normal)
            
            cell.sectionButton.tag = 0
            cell.subscribeButtonAction =
            {
                [unowned self] in
                self.performSegue(withIdentifier: "experienceSegue", sender: self)
            }
        }
        if section == 1 {
            cell.SectionTitle.text = "Project "
            cell.sectionButton.setTitle("Add Project", for: .normal)
            cell.sectionButton.tag = 1
            cell.subscribeButtonAction =
            {
                [unowned self] in
                self.performSegue(withIdentifier: "projectSegue", sender: self)
            }
        }
        if section == 2 {
            cell.SectionTitle.text = "Skills"
            cell.sectionButton.setTitle("", for: .normal)
            cell.sectionButton.tag = 2
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var uiswipe:UISwipeActionsConfiguration?
        if indexPath.section == 0{
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                
                AF.request("http://127.0.0.1:8080/api/studentProfile/DeleteExperience/\(String(describing:self.studentProfile?.experiences[indexPath.row].ExpID ?? 0))",method: HTTPMethod.delete).responseJSON { (response) in
                      print("http://127.0.0.1:8080/api/studentProfile/DeleteExperience/\(String(describing:self.studentProfile?.experiences[indexPath.row].ExpID  ??  0))")
                        self.studentProfile?.experiences.remove(at: indexPath.row)
                        self.expirenceTableView.reloadData()
                       
                      }
            }
            uiswipe = UISwipeActionsConfiguration(actions: [delete])
        }else if indexPath.section == 1{
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                AF.request("http://127.0.0.1:8080/api/studentProfile/DeleteProject/\(String(describing: self.studentProfile?.projects[indexPath.row].ProjectID ?? 0))",method: HTTPMethod.delete).responseJSON { (response) in
                    self.studentProfile?.projects.remove(at: indexPath.row)
                    self.expirenceTableView.reloadData()
                }
             
            }
            uiswipe = UISwipeActionsConfiguration(actions: [delete])
        }
        return uiswipe!
    }

    
}
