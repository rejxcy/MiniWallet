import UIKit
import Foundation

private let openHeight: CGFloat = 160
private let closeHeight: CGFloat = 60

class WalletCard {
    private var walletRecords: [WalletRecord] = []
    
    var walletInfo: Wallet
    var cellHeight = closeHeight
    var isOpen = false {
        didSet {
            cellHeight = isOpen ? openHeight : closeHeight
        }
    }
    
    init(wallet: Wallet) {
        self.walletInfo = wallet
        loadRecords()
    }
    
    private func loadRecords() {
        walletRecords = SQLiteHandler.shared.getWalletRecords(walletId: walletInfo.id)
    }
    
    func openCard() {
        isOpen = true
    }
    
    func closeCard() {
        isOpen = false
    }
    
    func getWalletId() -> Int64 {
        return walletInfo.id
    }
    
    func getRecords() -> [WalletRecord] {
        return walletRecords
    }
    
    func addRecord(_ record: WalletRecord) {
        SQLiteHandler.shared.insertWalletRecord(walletRecord: record)
        walletRecords.append(record)
    }
    
    func updateRecord(_ record: WalletRecord) {
        SQLiteHandler.shared.updateWalletRecord(walletRecord: record)
    }
    
    func deleteRecord(_ recordId: Int64) {
        SQLiteHandler.shared.deleteWalletRecord(recordID: recordId)
        walletRecords.removeAll(where: { $0.id == recordId })
    }
    
    func updateWallet(_ target: Wallet) {
        self.walletInfo = target
    }
}


