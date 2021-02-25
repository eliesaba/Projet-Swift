import UIKit

final class ProfileViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    private var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
   
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    
    // Entrer settings
    private func  configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),style: .done,target: self,action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
   

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        
        if (indexPath.row == 0)
        {
            cell.configure(debug: "test")}else if (indexPath.row == 1){
            cell.configure(debug: "test1")}else if (indexPath.row == 2){
            cell.configure(debug: "test2")}else if (indexPath.row == 3){
            cell.configure(debug: "test3")}else if (indexPath.row == 4){
            cell.configure(debug: "test4")}else if (indexPath.row == 5){
            cell.configure(debug: "test5")}else if (indexPath.row == 6){
            cell.configure(debug: "test6")}else if (indexPath.row == 7){
            cell.configure(debug: "test7")}else if (indexPath.row == 8){
            cell.configure(debug: "test8")}else if (indexPath.row == 9){
            cell.configure(debug: "test9")}else if (indexPath.row == 10){
            cell.configure(debug: "test10")}else if (indexPath.row == 11){
            cell.configure(debug: "test11")}
            return cell
        }
    

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // Footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            let tabControlheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabControlheader.delegate = self
            return tabControlheader
            
        }
        
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
    
            return CGSize(width: collectionView.width, height: 50)
        
        }
        
}

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // Faire defilier vers les postes de l'utilisateur
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<3 {
            if (x == 0){
            mockData.append(UserRelationship(username: "@Harry_Styles", name: "Harry Styles", type: x % 2 == 0 ? .following : .not_following))
            }
            else if(x==1){
                mockData.append(UserRelationship(username: "@The_Weekend", name: "The Weekend", type: x % 2 == 0 ? .following : .not_following))
                
            }
            else{
                mockData.append(UserRelationship(username: "@John_Cena", name: "John Cena", type: x % 2 == 0 ? .following : .not_following))
                
            }
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<4 {
            if (x == 0) {
                mockData.append(UserRelationship(username: "@Harry_Potter", name: "Harry Potter", type: .following))
            }
            else if (x == 1) {
                mockData.append(UserRelationship(username: "@James_Bond", name: "James Bond", type: .following))
            }
            else if (x == 2){
                mockData.append(UserRelationship(username: "@Jason_Statham", name: "Jason Statham", type: .following))
            }
            else {
                mockData.append(UserRelationship(username: "@Jhonny_English", name: "Jhonny English", type: .following))
                
            }
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        
    }
    
    func didTapTaggedButtonTab() {
    
    }
}
