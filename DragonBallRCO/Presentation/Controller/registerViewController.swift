//
//  registerViewController.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 29/09/24.
//

import UIKit

class registerViewController: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var regButtonText: UIButton!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var lastName2Text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorText.text  = ""
    }


  
    @IBAction func regButtonAction(_ sender: Any) {
        NetworkModel.shared.register(name: nameText.text ?? "", lastName: lastNameText.text ?? "", lastName2: lastName2Text.text ?? "", email: emailText.text ?? "", password: passText.text ?? "") { result in
            
            switch result {
            case .success( _ ):
                DispatchQueue.main.async {
                    self.errorText.textColor = .blue
                    self.errorText.text = "Registro Exitoso."
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    // Aquí va tu código que modifica la interfaz de usuario @
                    self.errorText.textColor = .red
                    self.errorText.text = String(error.localizedDescription)
                }
                
            }
        }
        
        
    }
    
}
