//
//  ViewController.swift
//  ConsumirAPIs
//
//  Created by Francisco Soares Neto on 20/08/20.
//  Copyright © 2020 Francisco Soares Neto. All rights reserved.
//

import UIKit

class FilmListViewController: UITableViewController {

   // var films: [Film] = []
    var listaDeRecord: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load()
    }

    
    /// Carrega os dados do webservice
    func load() {
        //let stringURL = "https://ghibliapi.herokuapp.com/films/"
        let stringURL = "https://www.jailbase.com/api/1/search/?source_id=az-mcso&last_name=ford"
        let url = URL(string: stringURL)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            do {
//                let decoder = JSONDecoder()
//                let filminhos = try decoder.decode([Film].self, from: data!)
//                self.films = filminhos
                
                
                
                var prisioneiros = try JSONDecoder().decode(Teste.self, from: data!)
                self.listaDeRecord = prisioneiros.records
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
                catch {
                    print("JSON error: \(error.localizedDescription)")
                }
        }
            
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return films.count
        return listaDeRecord.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Studio Ghibli Films"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! FilmTableViewCell
        
//        cell.textLabel?.text = films[indexPath.row].title
        cell.textLabel?.text = listaDeRecord[indexPath.row].name
        
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showFilm", case let nextVC = segue.destination as? FilmViewController {
//            nextVC?.film = films[tableView.indexPathForSelectedRow!.row]
//        }
//    }
}

