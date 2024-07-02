//
//  CatListViewController.swift
//  CatsApp
//
//  Created by Miguel Saravia on 1/7/24.
//

import UIKit
import Networking

class CatListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      let demo = Networking()
      print(demo.foo)
        // Do any additional setup after loading the view.
    }
}
