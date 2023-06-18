//
//  ViewController.swift
//  MiniWallet
//
//  Created by 胡志龍 on 2023/6/3.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pocketTableView: UITableView!
    
    var walletCards = SQLiteHandler.shared.getWallets().map { WalletCard(wallet: $0) }
    var selectWallet: Wallet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pocketTableView.dataSource = self
        pocketTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pocketTableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
        cell.nameLabel.text = walletCards[indexPath.item].walletInfo.name
        cell.budgetLabel.text = String(walletCards[indexPath.item].walletInfo.budget)
        cell.totalCostButton.titleLabel?.text = String(walletCards[indexPath.item].walletInfo.totalCost)
        cell.layer.zPosition = CGFloat(walletCards[indexPath.item].walletInfo.index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == walletCards.count - 1 {
            walletCards[indexPath.item].openCard()
        }
        return walletCards[indexPath.item].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = walletCards[indexPath.item]
        
        var oldCard: WalletCard?
        if let oldIndex = selectWallet?.index {
            oldCard = walletCards[oldIndex]
        }
        
        selectWallet = card.walletInfo
        // TODO: if tapped the last, need add new one
        if indexPath.item == walletCards.count - 1 { return }
        
        if card.isOpen {
            card.closeCard()
        } else {
            oldCard?.closeCard()
            card.openCard()
        }
        
        tableView.reloadData()
    }
    
    @IBSegueAction func totalCostSegueAction(_ coder: NSCoder) -> RecordViewController? {
        let recordVC = RecordViewController(coder: coder)
        recordVC?.wallet = selectWallet
        return recordVC
    }
    
    
    
}

