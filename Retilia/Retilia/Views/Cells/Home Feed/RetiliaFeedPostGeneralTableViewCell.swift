import UIKit

class RetiliaFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "RetiliaFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
