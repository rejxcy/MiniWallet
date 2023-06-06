import UIKit
import Foundation

private let openHeight: CGFloat = 160
private let closeHeight: CGFloat = 60

class WalletItem {
    var isOpen = false
    var cardColor: UIColor = UIColor.blue
    var cellHeight = closeHeight
    var zPosition: CGFloat = 0
    
    init(isOpen: Bool = false, cardColor: UIColor, cellHeight: CGFloat = closeHeight, zPosition: CGFloat) {
        self.isOpen = isOpen
        self.cardColor = cardColor
        self.cellHeight = cellHeight
        self.zPosition = zPosition
    }
    
    func openCard() {
        isOpen = true
        cellHeight = openHeight
    }

    func closeCard() {
        isOpen = false
        cellHeight = closeHeight
    }
}

