//
//  descViewController.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 30/09/24.
//

import UIKit

class descViewController: UIViewController {
    
    private let descText: String
    private var fotoImage: String
    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    init(desc: String, foto: String) { 
        self.descText = desc
        self.fotoImage = foto
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageURL = URL(string: fotoImage) {
            // Aspecto de la imagen de los personajes6
            fotoImageView.contentMode = .scaleAspectFill
            fotoImageView.layer.cornerRadius = 10
            fotoImageView.layer.borderWidth = 1
            fotoImageView.layer.borderColor = UIColor.cyan.cgColor
            // Carga de la imagen
            fotoImageView.setImage(url: imageURL)
            
        }
       
        descLabel.text = descText       
    }


    

}
