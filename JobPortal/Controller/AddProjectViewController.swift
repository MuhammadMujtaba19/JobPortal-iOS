//
//  AddViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/22/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class AddProjectViewController: UIViewController {
    var frameworkName = [Framework]()
    var domainName = [Domain]()
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var githubTextField: UITextField!
    @IBOutlet weak var courseIDTextField: UITextField!
    @IBOutlet weak var skillsGainedTextField: UITextField!
    @IBOutlet weak var frameworkNameTextField: UITextField!
    @IBOutlet weak var domainNameTextField: UITextField!
    
    private var FrameworkPickerView: UIPickerView = UIPickerView()
    private var DomainPickerView: UIPickerView = UIPickerView()
    
    private var frameID:Int?
    private var DomainID:Int?
    var studentData:Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentStudent = UserDefaults.standard.data(forKey: "current"){
            studentData = try? JSONDecoder().decode(Student.self, from: currentStudent)
        }
      
        FrameworkPickerView.delegate = self
        FrameworkPickerView.dataSource = self
        frameworkNameTextField.inputView = FrameworkPickerView
        FrameworkPickerView.tag = 1
        
        
        DomainPickerView.delegate = self
        DomainPickerView.dataSource = self
        domainNameTextField.inputView = DomainPickerView
        DomainPickerView.tag = 2
        
        getDomains()
        getFrameworkNames()
        
    }
    @IBAction func SubmitButton(_ sender: UIButton) {
        let parameters = [
                   "StudentID": 3870,
                   "ProjectName" : projectNameTextField.text!,
                   "GitHubLink" : githubTextField.text!,
                   "courseOfferedID" : Int(courseIDTextField.text!),
                   "Skillvalue":skillsGainedTextField.text!,
                   "ApproveStatus": "Complete",
                   "FrameworkID":frameID!,
                   "DomainID":DomainID!
            
                   ] as [String : Any]
               
               AF.request("http://127.0.0.1:8080/api/studentProfile/AddProject", method: HTTPMethod.post, parameters: parameters).response { (response) in
                   
               }
    }
}
    
extension AddProjectViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count:Int=0
        if pickerView.tag == 1{
            count = frameworkName.count
        }else if pickerView.tag == 2 {
            count = domainName.count
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var value:String = ""
        if pickerView.tag == 1{
            value = frameworkName[row].FName!
            frameID = frameworkName[row].FID!
        }else if pickerView.tag == 2 {
            value = domainName[row].DomainName!
            DomainID = domainName[row].DomainID!
        }
        return value
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            frameworkNameTextField.text = frameworkName[row].FName
            frameworkNameTextField.resignFirstResponder()
        
        }else if pickerView.tag == 2 {
            domainNameTextField.text = domainName[row].DomainName
            domainNameTextField.resignFirstResponder()
        }
    }
    
    func getDomains() -> Void {
          AF.request("http://127.0.0.1:8080/api/studentProfile/GetDomains").responseJSON { (response) in
               do{
                   let decoder = JSONDecoder()
                   let models = try decoder.decode([Domain].self, from:
                       response.data!)
                           for model in models{
                               self.domainName.append(model)
                            }
                }catch{
                    self.gotError()
                }
            }
        }
    func getFrameworkNames() -> Void {
        AF.request("http://127.0.0.1:8080/api/studentProfile/GetAllFrameworkName").responseJSON { (response) in
            do{
                let decoder = JSONDecoder()
                let models = try decoder.decode([Framework].self, from:
                    response.data!) //Decode JSON Response Data
                        for model in models{
                            self.frameworkName.append(model)
                        }
                
            }catch{
                self.gotError()
            }
        }
    }
    func gotError() -> Void {
        let alert = UIAlertController(title: "Error!", message: "Error Could not connect to Server tryAgain....", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    }


