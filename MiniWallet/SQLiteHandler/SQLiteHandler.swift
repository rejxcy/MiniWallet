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
    
    
    private let walletTable = Table("wallet")
    private let walletId = Expression<Int64>("id")
    private let walletIndex = Expression<Int>("index")
    private let walletName = Expression<String>("name")
    private let walletBudget = Expression<Int>("budget")
    private let walletTotalCost = Expression<Int>("totalCost")
    
    
    private let recordTable = Table("wallet_record")
    private let recordId = Expression<Int64>("id")
    private let recordWalletId = Expression<Int64>("walletId")
    private let recordDate = Expression<String>("date")
    private let recordName = Expression<String>("name")
    private let recordDescription = Expression<String?>("description")
    private let recordCost = Expression<Int>("cost")
    
    init() {
        do {
            db = try Connection(path)
            
            try createWalletTable()
            try createWalletRecordTable()
        } catch {
            print("Error connecting to database: \(error)")
        }
    }
    
    private func createWalletTable() throws {
        try db?.run(walletTable.create(ifNotExists: true) { table in
            table.column(walletId, primaryKey: true)
            table.column(walletIndex)
            table.column(walletName)
            table.column(walletBudget)
            table.column(walletTotalCost)
        })
    }
    
    private func createWalletRecordTable() throws {
        try db?.run(recordTable.create(ifNotExists: true) { table in
            table.column(recordId, primaryKey: true)
            table.column(recordWalletId)
            table.column(recordDate)
            table.column(recordName)
            table.column(recordDescription)
            table.column(recordCost)
            table.foreignKey(recordWalletId, references: walletTable, walletId)
        })
    }
    
    func insertWallet(wallet: Wallet) {
        do {
            let insert = walletTable.insert(
                walletIndex <- wallet.index,
                walletName <- wallet.name,
                walletBudget <- wallet.budget,
                walletTotalCost <- wallet.totalCost
            )
            try db?.run(insert)
        } catch {
            print("Error inserting wallet: \(error)")
        }
    }
    
    func insertWalletRecord(walletRecord: WalletRecord) {
        do {
            let insert = recordTable.insert(
                recordWalletId <- walletRecord.walletId,
                recordDate <- walletRecord.date,
                recordName <- walletRecord.name,
                recordDescription <- walletRecord.description,
                recordCost <- walletRecord.cost
            )
            try db?.run(insert)
        } catch {
            print("Error inserting wallet record: \(error)")
        }
    }
    
    func getWallets() -> [Wallet] {
        var wallets: [Wallet] = []
        do {
            let query = walletTable
            for wallet in try db!.prepare(query) {
                let wallet = Wallet(
                    id:        wallet[walletId],
                    index:     wallet[walletIndex],
                    name:      wallet[walletName],
                    budget:    wallet[walletBudget],
                    totalCost: wallet[walletTotalCost]
                )
                wallets.append(wallet)
            }
        } catch {
            print("Error retrieving wallets: \(error)")
        }
        return wallets
    }
    
    func getWalletRecords(walletId: Int64) -> [WalletRecord] {
        var records: [WalletRecord] = []
        do {
            let query = recordTable.filter(recordWalletId == walletId)
            for record in try db!.prepare(query) {
                let walletRecord = WalletRecord(
                    id:          record[recordId],
                    walletId:    record[recordWalletId],
                    date:        record[recordDate],
                    name:        record[recordName],
                    description: record[recordDescription] ?? "",
                    cost:        record[recordCost]
                )
                records.append(walletRecord)
            }
        } catch {
            print("Error retrieving wallet records: \(error)")
        }
        return records
    }
    
    
}
