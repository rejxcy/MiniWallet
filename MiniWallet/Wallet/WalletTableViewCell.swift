//
//  WalletTableViewCell.swift
//  MiniWallet
//
//  Created by 胡志龍 on 2023/6/4.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var totalCostButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        walletView.layer.cornerRadius = 15
        walletView.layer.shadowColor = UIColor.black.cgColor
        walletView.layer.shadowOpacity = 0.5
        walletView.layer.shadowOffset = CGSize(width: 1, height: 3)
        walletView.layer.shadowRadius = 8
        
        backgroundColor = .clear
        contentView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
}
