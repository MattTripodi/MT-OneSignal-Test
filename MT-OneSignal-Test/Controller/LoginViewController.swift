//
//  ViewController.swift
//  MT-OneSignal-Test
//
//  Created by Matthew Tripodi on 1/27/24.
//

import UIKit
import OneSignalFramework

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var externalIDTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var skipLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func recordUserData() {
        let userEmail = emailTextField.text ?? "No Email"
        let userPhoneNumber = phoneNumberTextField.text ?? "No Phone Number"
        let externalID = externalIDTextField.text ?? "12345"
        OneSignal.User.addEmail(userEmail)
        OneSignal.User.addSms(userPhoneNumber)
        
        /*
         Log the user into OneSignal under your user identifier. This sets your user ID as the OneSignal external_id and switches the context to that specific user (onesignal_id). All subscriptions identified with the same external_id will have the same onesignal_id.

         If the external_id exists, the user will be retrieved, and the onesignal_id will change to the previously identified version. Any data collected while the user was anonymous will not be applied to the now logged-in user, and the anonymous data will be lost.
         If the external_id does not exist, the local state will be saved under the current onesignal_id. Any data collected while the user was anonymous will be kept.
         
         The login method has built in retries when there is no network connection or we receive a 500 response from the server.
         
         iOS will retry 4 times with backoff with these intervals 5 seconds -> 15 seconds -> 45 seconds -> 135 seconds. After which it will not retry anymore until the next session (app backgrounded for > 30 seconds or killed and restarted).
         */
        OneSignal.login(externalID)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        recordUserData()
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func skipLoginButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
}

