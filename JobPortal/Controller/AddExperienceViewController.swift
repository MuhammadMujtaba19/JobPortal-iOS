//
//  AddExperienceViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/22/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class AddExperienceViewController: UIViewController {

    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var descriptionTextFIeld: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var organizationNamesTextField: UITextField!
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var pickerView: UIPickerView = UIPickerView()
    var studentData:Student?
//    let organizations = ["Securiti.ai","Systems","Careem","Folio3","Avanza"]
    var organizations = [Organization]()
    var organizationID:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createStartDatePicker()
          createEndDatePicker()
        AF.request("http://127.0.0.1:8080/api/studentProfile/GetOrganizations").responseJSON { (response) in
            do{
                let decoder = JSONDecoder()
                let models = try decoder.decode([Organization].self, from:
                    response.data!) //Decode JSON Response Data
                    for model in models{
                        self.organizations.append(model)
                    }
            }catch{

            }
    }
        pickerView.delegate=self
        pickerView.dataSource = self
        organizationNamesTextField.inputView = pickerView
    }
    @IBAction func submitExpButton(_ sender: UIButton) {

        let parameters = [
            "StudentID": UserDefaults.standard.integer(forKey: "StudentID"),
            "Designation" : designationTextField.text!,
            "JDescription" : descriptionTextFIeld.text!,
            "StartDate" : startDateTextField.text!,
            "EndDate": endDateTextField.text!,
            "OrganizationID":organizationID!
            ] as [String : Any]
        
        AF.request("http://127.0.0.1:8080/api/studentProfile/AddExperience", method: HTTPMethod.post, parameters: parameters).response { (response) in
            self.dismiss(animated: true, completion: nil)
        }

    }
    func createStartDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed)
        )
        toolbar.setItems([doneBtn], animated: true)
        
        datePicker.datePickerMode = .date
        
        startDateTextField.inputAccessoryView = toolbar
        startDateTextField.inputView = datePicker
    }
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        startDateTextField.text = formatter.string(from:datePicker.date)
        self.view.endEditing(true)
    }
    func createEndDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed2)
        )
        toolbar.setItems([doneBtn], animated: true)
        
        datePicker.datePickerMode = .date
        
        endDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputView = datePicker
    }
    @objc func donePressed2(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        endDateTextField.text = formatter.string(from:datePicker.date)
        self.view.endEditing(true)
    }
    
}
    extension AddExperienceViewController:UIPickerViewDelegate,UIPickerViewDataSource{
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return organizations.count
            
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return organizations[row].OrganizationName
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            organizationNamesTextField.text = organizations[row].OrganizationName
            organizationID = organizations[row].OrganizationID
            organizationNamesTextField.resignFirstResponder()
        }

}
