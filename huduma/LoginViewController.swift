//
//  LoginViewController.swift
//  huduma
//
//  Created by macbook on 26/02/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginActionButton(_ sender: Any) {
        
        validate()
        
        
        if email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure to insert all your details", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        self.showSpinner(onView: self.view)
        


//        let defaults = UserDefaults.standard
//
//        defaults.set(email, forKey: "email")
//        defaults.set(password, forKey: "password")
        



        
        let loginUser = AuthUser(email: email.text!, password: password.text!)
        let loginRequest = LoginRequest(endpoint: "login")
        
        
        loginRequest.loginUser(loginUser, completion: {
            result in
            self.removeSpinner()
            switch result {
                
            case .success( _):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Success", message: "Login successful", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: {
                        (_) in
                        self.performSegue(withIdentifier: "loginToHome", sender: self)
                    })
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    let retrievedString: String? = KeychainWrapper.standard.string(forKey: "token")
                    print("Retrieved this data, \(String(describing: retrievedString))")
                }
                
            
            case .failure(let error):
                print("An authentication error occurred \(error)")
                
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
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


var vSpinner: UIView?
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
