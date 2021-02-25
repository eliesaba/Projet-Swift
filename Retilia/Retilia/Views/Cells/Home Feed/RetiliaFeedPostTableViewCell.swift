import UIKit
import SDWebImage // A framework that we brought in to load images
import AVFoundation

 final class RetiliaFeedPostTableViewCell: UITableViewCell {

    static let identifier = "RetiliaFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     public var count = 0
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "kim")
        return
    }
   
    public func configure1(with post: UserPost) {
        postImageView.image = UIImage(named: "john")
        return
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
}

}
