//
//  ViewController.swift
//  MiniWallet
//
//  Created by 胡志龍 on 2023/6/3.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pocketTableView: UITableView!
    
    
    
    var walletCellArr: [WalletItem] = [WalletItem(cardColor: UIColor.red, zPosition: 0),
                                       WalletItem(cardColor: UIColor.systemTeal, zPosition: 1),
                                       WalletItem(cardColor: UIColor.green, zPosition: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pocketTableView.dataSource = self
        pocketTableView.delegate = self
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pocketTableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
        cell.walletView.backgroundColor = walletCellArr[indexPath.item].cardColor
        cell.layer.zPosition = walletCellArr[indexPath.item].zPosition
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == walletCellArr.count - 1 {
            walletCellArr[indexPath.item].openCard()
        }
        return walletCellArr[indexPath.item].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = walletCellArr[indexPath.item]
        if indexPath.item == walletCellArr.count - 1 { return }
        
        if card.isOpen {
            card.closeCard()
        } else {
            card.openCard()
        }
        tableView.reloadData()
    }

}

