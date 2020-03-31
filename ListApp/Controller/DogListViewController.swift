//
//  ViewController.swift
//  ListApp
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import Alamofire

final class DogListViewController: UIViewController {
    
    fileprivate let model = [
        Dog(nickname: "Max"),
        Dog(nickname: "Bob"),
        Dog(nickname: "Brutus"),
        Dog(nickname: "Toto"),
        Dog(nickname: "ScoobyDoo"),
        Dog(nickname: "Bill"),
        Dog(nickname: "Nina"),
        Dog(nickname: "Medore"),
        Dog(nickname: "Cerbere")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchDogsImages { [weak self] imageUrls in
            guard let self = self else {
                return
            }
            
            for i in 0..<self.model.count {
                self.model[i].imageURL = URL(string: imageUrls[i])
            }
        }
    }
    
    private func fetchDogsImages(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/\(model.count)") else {
            return
        }
        
        AF
            .request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse.self) { response in

                switch response.result {

                case .success(let apiResponse):
                    completion(apiResponse.message)
                    break

                case .failure(let error):
                    completion([])
                    print(error)
                    break
                }
        }
    }
}

extension DogListViewController: UITableViewDataSource {
    
    var dogCellId: String { return "idDefaultCell" }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: dogCellId) {
            // I'm using a reusable cell
            cell = reusableCell
            
        } else {
            // I'm instantiating a new cell
            cell = UITableViewCell(style: .default, reuseIdentifier: dogCellId)
        }
        
        cell.textLabel?.text = model[indexPath.row].nickname
        
        return cell
    }
}

extension DogListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let dogDetailsViewController = storyboard.instantiateViewController(withIdentifier: "idDogDetailsViewController") as? DogDetailsViewController {
            dogDetailsViewController.dog = model[indexPath.row]
            self.navigationController?.pushViewController(dogDetailsViewController, animated: true)
            
        } else {
            // Do nothing
            print("Error")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
