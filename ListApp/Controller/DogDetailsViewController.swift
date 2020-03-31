//
//  DogViewController.swift
//  ListApp
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import UIKit
import Kingfisher

class DogDetailsViewController: UIViewController {
    
    var dog: Dog!
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNicknameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNicknameLabel.text = dog.nickname
        
        if let url = dog.imageURL {
            dogImageView.kf.setImage(with: url)
        }
    }
}
