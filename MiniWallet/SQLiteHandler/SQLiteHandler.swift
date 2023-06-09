import Foundation
import SQLite


struct Wallet {
    let id: Int64
    let index: Int
    let name: String
    let budget: Int
    let totalCost: Int
}

struct WalletRecord {
    let id: Int64
    let walletId: Int64
    let date: String
    let name: String
    let description: String
    let cost: Int
}

class SQLiteHandler {
    static let shared = SQLiteHandler()
    
    private var db: Connection?
    private let path: String = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        return documentsPath.appendingPathComponent("wallet.db")
    }()
    
    private enum WalletTable {
        static let tableName = Table("wallet")
        static let id = Expression<Int64>("id")
        static let index = Expression<Int>("index")
        static let name = Expression<String>("name")
        static let budget = Expression<Int>("budget")
        static let totalCost = Expression<Int>("totalCost")
    }
    
    private enum RecordTable {
        static let tableName = Table("walletRecord")
        static let id = Expression<Int64>("id")
        static let walletId = Expression<Int64>("walletId")
        static let date = Expression<String>("date")
        static let name = Expression<String>("name")
        static let description = Expression<String>("description")
        static let cost = Expression<Int>("cost")
    }
    
    private init() {
        do {
            db = try Connection(path)
            
            try createWalletTable()
            try createWalletRecordTable()
        } catch {
            print("Error connecting to database: \(error)")
        }
    }
    
    private func createWalletTable() throws {
        try db?.run(WalletTable.tableName.create(ifNotExists: true) { table in
            table.column(WalletTable.id, primaryKey: true)
            table.column(WalletTable.index)
            table.column(WalletTable.name)
            table.column(WalletTable.budget)
            table.column(WalletTable.totalCost)
        })
    }
    
    private func createWalletRecordTable() throws {
        try db?.run(RecordTable.tableName.create(ifNotExists: true) { table in
            table.column(RecordTable.id, primaryKey: true)
            table.column(RecordTable.walletId)
            table.column(RecordTable.date)
            table.column(RecordTable.name)
            table.column(RecordTable.description)
            table.column(RecordTable.cost)
            table.foreignKey(RecordTable.walletId, references: WalletTable.tableName, WalletTable.id)
        })
    }
    
    
    // MARK: - Wallet
    func insertWallet(wallet: Wallet) {
        do {
            let insert = WalletTable.tableName.insert(
                WalletTable.index <- wallet.index,
                WalletTable.name <- wallet.name,
                WalletTable.budget <- wallet.budget,
                WalletTable.totalCost <- wallet.totalCost
            )
            try db?.run(insert)
        } catch {
            print("Error inserting wallet: \(error)")
        }
    }
    
    func getWallets() -> [Wallet] {
        var wallets: [Wallet] = []
        do {
            let query = WalletTable.tableName
            for wallet in try db!.prepare(query) {
                let wallet = Wallet(
                    id:        wallet[WalletTable.id],
                    index:     wallet[WalletTable.index],
                    name:      wallet[WalletTable.name],
                    budget:    wallet[WalletTable.budget],
                    totalCost: wallet[WalletTable.totalCost]
                )
                wallets.append(wallet)
            }
        } catch {
            print("Error retrieving wallets: \(error)")
        }
        return wallets
    }
    
    func updateWalletInfo(wallet: Wallet) {
        do {
            let query = WalletTable.tableName.filter(WalletTable.id == wallet.id)
            let update = query.update(
                WalletTable.index <- wallet.index,
                WalletTable.name <- wallet.name,
                WalletTable.budget <- wallet.budget,
                WalletTable.totalCost <- wallet.totalCost
            )
            try db?.run(update)
        } catch {
            print("Error with update wallet info: \(error)")
        }
    }
    
    func deleteWallet(walletId: Int64) {
        do {
            let query = WalletTable.tableName.filter(WalletTable.id == walletId)
            try db?.run(query.delete())
        } catch {
            print("Error with delete wallet: \(error)")
        }
    }
    
    
    // MARK: - Wallet Record
    func insertWalletRecord(walletRecord: WalletRecord) {
        do {
            let insert = RecordTable.tableName.insert(
                RecordTable.walletId <- walletRecord.walletId,
                RecordTable.date <- walletRecord.date,
                RecordTable.name <- walletRecord.name,
                RecordTable.description <- walletRecord.description,
                RecordTable.cost <- walletRecord.cost
            )
            try db?.run(insert)
        } catch {
            print("Error inserting wallet record: \(error)")
        }
    }
    
    func getWalletRecords(walletId: Int64) -> [WalletRecord] {
        var records: [WalletRecord] = []
        do {
            let query = RecordTable.tableName.filter(RecordTable.walletId == walletId)
            for record in try db!.prepare(query) {
                let walletRecord = WalletRecord(
                    id:          record[RecordTable.id],
                    walletId:    record[RecordTable.walletId],
                    date:        record[RecordTable.date],
                    name:        record[RecordTable.name],
                    description: record[RecordTable.description],
                    cost:        record[RecordTable.cost]
                )
                records.append(walletRecord)
            }
        } catch {
            print("Error retrieving wallet records: \(error)")
        }
        return records
    }
    
    func updateWalletRecord(walletRecord: WalletRecord) {
        do {
            let query = RecordTable.tableName.filter(RecordTable.id == walletRecord.id)
            let update = query.update(
                RecordTable.walletId <- walletRecord.walletId,
                RecordTable.date <- walletRecord.date,
                RecordTable.name <- walletRecord.name,
                RecordTable.description <- walletRecord.description,
                RecordTable.cost <- walletRecord.cost
            )
            try db?.run(update)
        } catch {
            print("Error with update wallet record: \(error)")
        }
    }
    
    func deleteWalletRecord(recordID: Int64) {
        do {
            let query = WalletTable.tableName.filter(RecordTable.id == recordID)
            try db?.run(query.delete())
        } catch {
            print("Error with delete wallet record: \(error)")
        }
    }
}
