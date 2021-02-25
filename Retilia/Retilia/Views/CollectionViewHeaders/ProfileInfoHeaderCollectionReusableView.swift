import UIKit

protocol  ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}


final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
   
    private let profilePhotoImageView: UIView = {
        let header = UIView()
        let backgroundImageView = UIImageView(image: UIImage(named: "men"))
        header.clipsToBounds = true // We used it so that nothing overflows
        header.addSubview(backgroundImageView)
        header.backgroundColor = .systemGray6
        return header
        
    }()
    
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let postsButtonNb: UIButton = {
        let button = UIButton()
        button.setTitle("12", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return button
    }()
    
    public let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let followingButtonNb: UIButton = {
        let button = UIButton()
        button.setTitle("4", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let followersButtonNb: UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Leonardo Dorian"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    
    public var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "  A life spent making mistakes is not only more honorable but more useful than a life spent doing nothing"
        label.textColor = .label
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    //Here we are going to add all our subviews we created above
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followersButtonNb)
        addSubview(followingButton)
        addSubview(followingButtonNb)
        addSubview(postsButton)
        addSubview(postsButtonNb)
        addSubview(bioLabel)
        addSubview(nameLabel)
        addSubview(editProfileButton)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followersButtonNb.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        followingButtonNb.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        postsButtonNb.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 2, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right-10, y: 20, width: countButtonWidth+10, height: buttonHeight+5).integral
        postsButtonNb.frame = CGRect(x: profilePhotoImageView.right-10, y: -9, width: countButtonWidth+10, height: buttonHeight+2).integral
        followersButton.frame = CGRect(x: postsButton.right-15, y: 20, width: countButtonWidth+10, height: buttonHeight+5).integral
        followersButtonNb.frame = CGRect(x: postsButton.right-15, y: -9, width: countButtonWidth+10, height: buttonHeight+2).integral
        followingButton.frame = CGRect(x: followersButton.right-10, y: 20, width: countButtonWidth+10, height: buttonHeight+5).integral
        followingButtonNb.frame = CGRect(x: followersButton.right-10, y: -9, width: countButtonWidth+10, height: buttonHeight+2).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right+60, y: buttonHeight+40, width: countButtonWidth+60, height: buttonHeight-10).integral
        nameLabel.frame = CGRect(x: 5, y: 40 + profilePhotoImageView.bottom, width: width-10, height: 50).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width-10, height: bioLabelSize.height).integral
    }
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
