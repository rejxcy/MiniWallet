import XCTest
@testable import MiniWallet

final class SQLiteHandlerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInsertAndRetrieveWallet() {
        let wallet = Wallet(id: 1, index: 1, name: "Test Wallet", budget: 1000, totalCost: 0)
        
        SQLiteHandler.shared.insertWallet(wallet: wallet)
        
        let wallets = SQLiteHandler.shared.getWallets()
        
        XCTAssertEqual(wallets.count, 1)
        XCTAssertEqual(wallets.first?.name, "Test Wallet")
        XCTAssertEqual(wallets.first?.budget, 1000)
        XCTAssertEqual(wallets.first?.totalCost, 0)
    }
    
    func testUpdateWalletInfo() {
        let updatedWallet = Wallet(id: 1, index: 1, name: "Updated Wallet", budget: 1500, totalCost: 500)
        
        SQLiteHandler.shared.updateWalletInfo(wallet: updatedWallet)
        
        let wallets = SQLiteHandler.shared.getWallets()
        
        XCTAssertEqual(wallets.count, 1)
        XCTAssertEqual(wallets.first?.name, "Updated Wallet")
        XCTAssertEqual(wallets.first?.budget, 1500)
        XCTAssertEqual(wallets.first?.totalCost, 500)
    }
    
    func testInsertAndRetrieveWalletRecord() {
        let record = WalletRecord(id: 1, walletId: 1, date: "6/10", name: "testRecord", description: "", cost: 500)
        
        SQLiteHandler.shared.insertWalletRecord(walletRecord: record)
        
        let records = SQLiteHandler.shared.getWalletRecords(walletId: 1)
        
        XCTAssertEqual(records.count, 1)
        XCTAssertEqual(records.first?.date, "6/10")
        XCTAssertEqual(records.first?.name, "testRecord")
        XCTAssertEqual(records.first?.description, "")
        XCTAssertEqual(records.first?.cost, 500)
    }
    
    func testUpdateWalletRecord() {
        let updatedRecord = WalletRecord(id: 1, walletId: 1, date: "6/11", name: "updateRecord", description: "test", cost: 1500)
        
        SQLiteHandler.shared.updateWalletRecord(walletRecord: updatedRecord)

        let records = SQLiteHandler.shared.getWalletRecords(walletId: 1)
        
        XCTAssertEqual(records.count, 1)
        XCTAssertEqual(records.first?.date, "6/11")
        XCTAssertEqual(records.first?.name, "updateRecord")
        XCTAssertEqual(records.first?.description, "test")
        XCTAssertEqual(records.first?.cost, 1500)
    }
    
    func testDeleteWalletRecord() {
        SQLiteHandler.shared.deleteWalletRecord(recordID: 1)
        
        let records = SQLiteHandler.shared.getWalletRecords(walletId: 1)
        
        XCTAssertEqual(records.count, 0)
    }
    
    func testDeleteWallet() {
        SQLiteHandler.shared.deleteWallet(walletId: 1)
        
        let wallets = SQLiteHandler.shared.getWallets()
        
        XCTAssertEqual(wallets.count, 0)
    }
    
}
