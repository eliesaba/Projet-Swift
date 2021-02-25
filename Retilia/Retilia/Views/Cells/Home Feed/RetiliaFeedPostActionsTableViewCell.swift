import UIKit

protocol RetiliaFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}


class RetiliaFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "RetiliaFeedPostActionsTableViewCell"
    
    weak var delegate: RetiliaFeedPostActionsTableViewCellDelegate?
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    
    public func configure(with post: UserPost) {

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
