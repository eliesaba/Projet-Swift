import FirebaseAuth
import UIKit

// Represente par 4 models
// Chaque model va avoir sa section
struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RetiliaFeedPostTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostTableViewCell.identifier)
        tableView.register(RetiliaFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostHeaderTableViewCell.identifier)
        tableView.register(RetiliaFeedPostActionsTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostActionsTableViewCell.identifier)
        tableView.register(RetiliaFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: RetiliaFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Appel de la fonction qui va nous creer les models
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createMockModels() {
        // Here we  created a user
        let user = User(username: "@Kim_Kardashian", bio: "", name: (first: "", last: ""), profilePhoto: URL(string:"https://www.google.com/")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let user1 = User(username: "@John_Legend", bio: "", name: (first: "", last: ""), profilePhoto: URL(string:"https://www.google.com/")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let user2 = User(username: "@Kim_Kardashian", bio: "", name: (first: "", last: ""), profilePhoto: URL(string:"https://www.google.com/")!, birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        // Here we created the post
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
        // Here we crated the comments
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@Jenny",
                                        text: "best post i have seen",
                                        createdDate: Date(),
                                        likes: []))
        }
        
        for x in 0...1 {
            if (x == 0){
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType:.primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
            }
            else if (x == 1){
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user1)), post: PostRenderViewModel(renderType:.primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
            }
       
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Affichage de la page login si l'utilisateur n'a pas connecte
            if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

public var a = 0

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //chaque model a 4 sections
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        // Calculation pour trouver le model
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            // Position du model
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        // Subsection
        
        let subSection = x % 4
        
        // En basant sur la subsection on pourra retourner le nombre de lignes
        if subSection == 0 {
            // Header: alors une ligne
            return 1
        }
        
        else if subSection == 1 {
             // Post: une ligne
            return 1
        }
        
        else if subSection == 2 {
            // actions: 1 ligne
            return 1
        }
        
        
        // Retourner 0 si toutes les conditions s'echouent
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostHeaderTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostHeaderTableViewCell
                
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        
        else if subSection == 1 {
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostTableViewCell
                // Affichage de l'image en relation avec le post
                if (a == 0)
                {
                cell.configure(with: post)
                }
                else
                {
                    cell.configure1(with: post)
                }
                a = a + 1
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        }
        
        else if subSection == 2 {
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: RetiliaFeedPostActionsTableViewCell.identifier, for: indexPath) as! RetiliaFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        
      
        return UITableViewCell()
 
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Header
            return 70
        }
        else if subSection == 1 {
            // Post
            return tableView.width-140
        }
        else if subSection == 2 {
            // Actions
            return 10
        }
        else if subSection == 3 {
            // Comment row
            return 0
        }
        return 0
        
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // Long du footer

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
    

extension HomeViewController: RetiliaFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        // Reporter un post
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in self?.reportPost() }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func reportPost() {
        let actionSheet = UIAlertController(title: "You reported the user", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
        
    }
}

extension HomeViewController: RetiliaFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}
    
   
