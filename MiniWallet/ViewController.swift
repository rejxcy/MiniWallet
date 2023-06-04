//
//  ViewController.swift
//  MiniWallet
//
//  Created by 胡志龍 on 2023/6/3.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pocketTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pocketTableView.dataSource = self
        pocketTableView.delegate = self

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pocketTableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
        return cell
    }

}

