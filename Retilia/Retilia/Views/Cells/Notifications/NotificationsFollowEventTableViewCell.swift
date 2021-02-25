import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}


class NotificationsFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationsFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Kanye_West followed you"
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)

        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        
        label.frame = CGRect(x: 5, y: 0, width: contentView.width-size-16, height: contentView.height)
    }
    
 
}
