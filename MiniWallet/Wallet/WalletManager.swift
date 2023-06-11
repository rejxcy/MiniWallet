import Foundation

class WalletManager {
    static let shared = WalletManager()
    private var walletCards: [WalletCard] = []
    
    private init() {
        loadWallets()
    }
    
    private func loadWallets() {
        walletCards = SQLiteHandler.shared.getWallets().map { WalletCard(wallet: $0) }
    }
    
    func addWallet(name: String, budget: Int, totalCost: Int) {
        // id 固定設置為 0，由 SQLite 自動產生
        let wallet = Wallet(id: 0, index: walletCards.count, name: name, budget: budget, totalCost: totalCost)
        
        SQLiteHandler.shared.insertWallet(wallet: wallet)
        walletCards.append(WalletCard(wallet: wallet))
    }
    
    func updateWalletInfo(wallet: Wallet) {
        SQLiteHandler.shared.updateWalletInfo(wallet: wallet)
        if let walletCard = walletCards.first(where: { $0.getWalletId() == wallet.id }) {
            walletCard.updateWallet(wallet)
        }
    }
    
    func deleteWallet(walletId: Int64) {
        SQLiteHandler.shared.deleteWallet(walletId: walletId)
        walletCards.removeAll(where: { $0.getWalletId() == walletId })
    }
    
    func getWalletCards() -> [WalletCard] {
        return walletCards
    }
}
