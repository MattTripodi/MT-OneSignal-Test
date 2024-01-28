//
//  ViewController.swift
//  MT-OneSignal-Test
//
//  Created by Matthew Tripodi on 1/27/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var skipLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func skipLoginButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toMain", sender: self)
    }
}

