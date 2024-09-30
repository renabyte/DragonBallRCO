//
//  MainListCellViewController.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 21/09/24.
//

import UIKit

final class MainListCellViewController: UITableViewCell {

    // MARK: Identifier
    static let identifier = String(describing: MainListCellViewController.self)
    // MARK: - Outlets
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellLabelForm: UILabel!
    @IBOutlet weak var cellImageForms: UIImageView!
    // MARK: - Configuration
    func configure(with heroe: Hero) {
        // RawValue lo utilizamos para obtener
        // la representacion del String
        
        //cellLabelForm.font = UIFont
        
        /*cellLabel.text = "TTT"
        cellLabelForm.text = "dfd" //heroe.name
        cellLabel.font = UIFont(name: "Avenir", size: 5)
        cellLabel.font = UIFont.boldSystemFont(ofSize: 16.0)*/
        
        //guard let imageURL = heroe.photo else {
        //    return
        //}
        // MARK: - Main Image Character
        if let imageURL = URL(string: heroe.photo) {
            // Aspecto de la imagen de los personajes6
            cellImageView.contentMode = .scaleAspectFill
            cellImageView.layer.cornerRadius = cellImageView.frame.width / 2
            cellImageView.layer.borderWidth = 1
            cellImageView.layer.borderColor = UIColor.cyan.cgColor
            // Carga de la imagen
            cellImageView.setImage(url: imageURL)
            //cellImageForms.setImage(url: imageURL)
            
        }
        
        cellImageForms.image = UIImage(systemName:"bolt")
        cellImageForms.tintColor = .systemYellow
        cellImageForms.contentMode = .scaleAspectFill
        cellLabel.text = heroe.name
        //cellImageForms.selectedImage = UIImage(systemName: "bolt.fill")
        cellLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
}
