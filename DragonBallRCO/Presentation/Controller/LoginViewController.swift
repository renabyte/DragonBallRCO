//
//  LoginViewController.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 29/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var regButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userId.layer.borderWidth = 2
        userId.layer.borderColor = UIColor.cyan.cgColor
        passText.layer.borderWidth = 2
        passText.layer.borderColor = UIColor.cyan.cgColor
        userIdLabel.text = "email:"
        passLabel.text = "password:"
        loginButton.setTitle("Login", for: .normal)
        regButton.setTitle("Register", for: .normal)
        errorLabel.text = ""
        
    }

    
    @IBAction func loginButton(_ sender: Any) {
        
        NetworkModel.shared.login(user: userId.text ?? "", password: passText.text ?? "") { result in
            
            switch result {
            case .success( _ ):
                DispatchQueue.main.async {
                    self.errorLabel.textColor = .blue
                    self.errorLabel.text = "Ingreso exitoso."
                    let mainListviewController = MainListViewController()
                    self.navigationController?.show(mainListviewController, sender: self)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    // Aquí va tu código que modifica la interfaz de usuario @
                    self.errorLabel.textColor = .red
                    self.errorLabel.text = String(error.localizedDescription)
                }
                
            }
        }
        
        
        
        
    }
    
    @IBAction func regButton(_ sender: Any) {
        
        let registerViewController = registerViewController()
        navigationController?.show(registerViewController, sender: self)
        
    }
    
}
