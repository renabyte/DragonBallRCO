//
//  MainListViewController.swift
//  DragonBallRCO
//
//  Created by Renato Calderon on 21/09/24.
//

import UIKit

class MainListViewController: UITableViewController {
    
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Hero>
    //let heroOne = Heroes(name: "Sendo", photo: "",  favorite: true, id: "1", description: "yo mismo" )
    //private var heroes: [Heroes] = []
    //private var Hero = [String: Heroes]()
    
    // Al declarar una variable como nula, el compilador
    // infiere que su valor inicial es `nil`
    private var dataSource: DataSource?
    private var myHeros : [Hero] = []
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = UIImage(named: "ball.png"){
            tableView.backgroundView = UIImageView(image: imageName)
            tableView.backgroundView?.contentMode = .scaleAspectFit
        }
        //heroes.append(heroOne)
        // 1. Registrar la celda custom
        // Registramos la celda que hemos creado de forma personalizada
        tableView.register(
            // Instanciamos el archivo .xib a traves de su numbre
            UINib(nibName: MainListCellViewController.identifier, bundle: nil),
            // Cada vez que TableView se encuentre este identificador
            // tiene que instanciar el .xib que le especificamos
            forCellReuseIdentifier: MainListCellViewController.identifier
        )
        
        // 2. Configurar el data source
        dataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, hero in
            // Obtenemos una celda reusable y la casteamos a
            // el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MainListCellViewController.identifier,
                for: indexPath
            ) as? MainListCellViewController else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            //let foundHeroe = self?.favouriteHouses[house.rawValue]
            //let isFavourite = foundHouse != nil
            cell.configure(with: hero)
            cell.backgroundColor = UIColor(white: 1, alpha: 0.8)
            //cell.selectedBackgroundView?.backgroundColor = UIColor.red
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.cyan
            cell.selectedBackgroundView = bgColorView
            return cell
        }
        
        // 3. Añadir el data source al table view
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // 4. Crear un snapshot con los objetos a representar
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        //snapshot.appendItems(heroes)
        //snapshot.appendItems(getHeroesList())
        //getHeroesList()
        //print(Hero.count)
        // 5. Aplicar el snapshot al data source para añadir los objetos
        //dataSource?.apply(snapshot)
        
        //NetworkModel.shared.getAllCharacters { result in
        //    switch result {
        //        case let .success(characters):
        //            print(characters)
        //        case let .failure(error):
        //            print(error)
        //    }
        //}
        
        NetworkModel.shared.getHeroes{ result in
            switch result {
            case let .success(listado):
                snapshot.appendItems(listado)
                self.dataSource?.apply(snapshot)
                self.myHeros = listado
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let hero = self.myHeros[indexPath.row]
        let descViewController = descViewController( desc: hero.description, foto: hero.photo )
        
        navigationController?.show(descViewController, sender: self)
    }
    
    // MARK: - Modelo Antiguo - Se deja a modo académico de refrencia
    /*
     func getHeroesList() -> [Heroes] {
     var heroes: [Heroes] = []
     let json: [String: Any] = ["name": ""]
     let parameters = try? JSONSerialization.data(withJSONObject: json)
     //let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")!
     let url = URL(string: "https://dragonball.keepcoding.education/api/heros/all")!
     var request = URLRequest(url: url)
     request.httpMethod = "POST"  // optional
     request.addValue("application/json",forHTTPHeaderField: "Content-Type")
     request.httpBody = parameters
     //request.setValue("application/json", forHTTPHeaderField: "{ \"name\" : \"Goku\" }")
     //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUifQ.eyJlbWFpbCI6InF1aW9zY29zLXRleHR1YWwwckBpY2xvdWQuY29tIiwiaWRlbnRpZnkiOiI4NEEyQ0U2Ni05RDBBLTQzMjAtQjk2Mi1DNjU2OERDMzAxMkMiLCJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMH0.z9534WMqPhUFyA385JhbKX4Xm_Fb5-38I8-d1LjtK9s"
     request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
     
     let task = URLSession.shared.dataTask(with: request){ data, response, error in
     if let error = error {
     print("Error while fetching data:", error)
     return
     }
     
     guard let data = data else {
     return
     }
     
     do {
     let posts = try JSONDecoder().decode([Heroes].self, from: data) // Since the JSON in the URL starts with array([]), we will be using [Post].self. If the JSON starts with curly braces ({}), use Post.self
     // Fetching each element from array
     for post in posts {
     if let item = self.Hero[post.name] {
     //print("que ufe")
     }
     else{
     self.Hero[post.name] = post
     heroes.append(post)
     self.heroes.append(post)
     print("se va llenando: \(self.heroes.count)")
     }
     //print(Hero.count)
     }
     } catch let jsonError {
     print("Failed to decode jsonxx", jsonError)
     }
     
     var snapshot = Snapshot()
     snapshot.appendSections([0])
     snapshot.appendItems(self.heroes)
     // 5. Aplicar el snapshot al data source para añadir los objetos
     self.dataSource?.apply(snapshot)
     
     }
     task.resume()
     return heroes
     }*/
    
    
}

// MARK: - Table View Delegate
extension MainListViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }
    //override func viewDidAppear(_ animated: Bool) {
    //    super.viewDidAppear(true)
        //if let imageName = UIImage(named: "ball.png"){
            //tableView.backgroundView = UIImageView(image: imageName)
            //tableView.backgroundView?.contentMode = .scaleAspectFit
        //}
    //}
}
