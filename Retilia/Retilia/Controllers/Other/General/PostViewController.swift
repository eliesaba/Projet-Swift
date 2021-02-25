import UIKit

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // Post
    case actions(provider: String)
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}


class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    public func configuree(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        return
    }
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(RetiliaFeedPostTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostTableViewCell.identifier)
        tableView.register(RetiliaFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostHeaderTableViewCell.identifier)
        tableView.register(RetiliaFeedPostActionsTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostActionsTableViewCell.identifier)
        tableView.register(RetiliaFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostActionsTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostActionsTableViewCell
            return cell
        
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostGeneralTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostGeneralTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostTableViewCell
            configuree(with: post)
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostHeaderTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostHeaderTableViewCell
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
    
        }
    }
    
}
