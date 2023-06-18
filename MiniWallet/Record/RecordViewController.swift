import UIKit

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var wallet: Wallet?
    var records: [WalletRecord] = []
    
    @IBOutlet weak var addRecordView: UIView!
    @IBOutlet weak var recordTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTable.dataSource = self
        recordTable.delegate = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let walletId = wallet?.id {
            records = SQLiteHandler.shared.getWalletRecords(walletId: walletId)
        }
        return records.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return recordTable.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTable.dequeueReusableCell(withIdentifier: "RecordDetailCell", for: indexPath) as! RecordTableViewCell
        let record = records[indexPath.row]
        
        cell.dateLabel.text = record.date
        cell.nameLabel.text = record.name
        cell.descriptionLabel.text = record.description
        cell.costLabel.text = String(record.cost)
        
        return cell
    }

    @IBAction func addRecordButton(_ sender: Any) {
    }
}
