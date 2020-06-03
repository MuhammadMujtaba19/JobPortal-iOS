//
//  LoginViewController.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/26/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {

    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let preferences = UserDefaults.standard
        var x = UserDefaults.standard.bool(forKey: "userLoggedIn")
        print(x)
        if preferences.object(forKey: "current") != nil{
//         if let currentStudent = UserDefaults.standard.data(forKey: "current"),
//                let blog = try? JSONDecoder().decode(Student.self, from: currentStudent) {
//
//            }
            LoginDone()
            print("LoginDone")
        }else{
            LoginToDo()
            print("LoginToDo")
        }
    }
    

    @IBAction func LoginButtonClick(_ sender: UIButton) {
        print("buttonclick")
        if(LoginButton.titleLabel?.text=="Logout"){
//            let preferences = UserDefaults.standard
            UserDefaults.standard.removeObject(forKey: "current")
            UserDefaults.standard.removeObject(forKey: "userLoggedIn")
            LoginToDo()
            return
        }
        let username = EmailText.text
        let password = PasswordText.text
        doLogin(user: username!, password: password!)

    }
    func doLogin(user:String,password:String){
        let url = URL(string: "http://127.0.0.1:8080/api/studentProfile/login")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let parameters = "Email="+EmailText.text!+"&SPassword="  +  PasswordText.text!
        
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler:{
            (data,response,error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                if(httpResponse.statusCode == 200){
//                    let  preferences = UserDefaults.standard
                    do{
                        let decoder = JSONDecoder()
                        let currentStudent = try decoder.decode(Student.self, from:
                            data!)
                        if let session_data = try? JSONEncoder().encode(currentStudent) {
                            UserDefaults.standard.set(session_data, forKey: "current")
                            UserDefaults.standard.set(true, forKey: "userLoggedIn")
                            UserDefaults.standard.set(currentStudent.StudentID, forKey: "StudentID")
                        }
                        DispatchQueue.main.async {
                                    self.LoginDone()
                        }
                    }
                    catch{
                        self.gotError()
                    }
                }else{
                    self.gotError()
                }
            }
        })
        task.resume()
    }
    func LoginDone(){
        PasswordText.isEnabled = false
        EmailText.isEnabled = false
        LoginButton.setTitle("Logout", for: .normal)


        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        guard let nextViewController = storyBoard.instantiateViewController(identifier: "homeScreen") as? UITabBarController else {
            print("ViewController not found")
            return
        }
        nextViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(nextViewController, animated: true, completion: nil)
//        self.view.window
    }
    func LoginToDo(){
        PasswordText.isEnabled = true
        EmailText.isEnabled = true
        LoginButton.setTitle("Login", for: .normal)

    }
    func gotError() -> Void {
           let alert = UIAlertController(title: "Error!", message: "Error Could not connect to Server tryAgain....", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okAction)
           self.present(alert, animated: true, completion: nil)
       }
       

}
