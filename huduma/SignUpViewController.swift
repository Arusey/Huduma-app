//
//  ViewController.swift
//  huduma
//
//  Created by macbook on 19/02/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
    

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func signUpAction(_ sender: Any) {
        validate()
        
        if firstName.text == "" || lastName.text  == "" || email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure you have inserted all your credentials", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present (alertController, animated: true, completion: nil)
        }
        self.showSpinner(onView: self.view)
        
    
               let user = User(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!)
               let postRequest = APIRequest(endpoint: "register")
               
               postRequest.save(user, completion: { result in
                self.removeSpinner()
                   
                   switch result {
                   case .success(let user):
                       print("User has been successfully signed up: \(String(describing: user.firstName))")
                       DispatchQueue.main.sync {
                           let alertController = UIAlertController(title: "Success", message: "Signup successful", preferredStyle: .alert)
                           let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: {
                            (_) in
                               self.performSegue(withIdentifier: "signUpToHome", sender: self)
                           })
                           
                           alertController.addAction(defaultAction)
                           self.present(alertController, animated: true, completion: nil)
                       }
                   case .failure(let error):
                       print("An error occurred \(error.localizedDescription)")
                       DispatchQueue.main.async {
                           let alertController = UIAlertController(title: "Error", message: "An error occurred while signing up please check your credentials and try again", preferredStyle: .alert)
                           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           
                           alertController.addAction(defaultAction)
                           self.present(alertController, animated: true, completion: nil)
                       }
                       
                   }
               })
               
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validate() {
        do {
            _ = try email.validatedText(validationType: ValidatorType.email)
            _ = try password.validatedText(validationType: ValidatorType.password)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }


}

