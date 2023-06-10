import Foundation

class WalletHandler {
    static let shared = WalletHandler()
    var wallets:[Wallet] = []
    
    private init() {
        updateWallets()
    }
    
    private func updateWallets() {
        wallets = SQLiteHandler.shared.getWallets()
    }
    
    func addWallet(wallet: Wallet) {
        SQLiteHandler.shared.insertWallet(wallet: wallet)
        updateWallets()
    }
    
    func updateWalletInfo(wallet: Wallet) {
        SQLiteHandler.shared.updateWalletInfo(wallet: wallet)
        updateWallets()
    }
    
    func deleteWallet(walletId: Int64) {
        SQLiteHandler.shared.deleteWallet(walletId: walletId)
        updateWallets()
    }
}
