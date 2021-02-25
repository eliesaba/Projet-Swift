import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}


final class EditProfileViewController: UIViewController, UITableViewDataSource {
    
    private let tableVIew: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private let Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableVIew.tableHeaderView = createTableHeaderView()
        tableVIew.dataSource = self
        view.addSubview(tableVIew)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        
    }

    private func configureModels(){
        // La premiere section aura  name, username et bio
        let section1Labels = ["Full Name", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableVIew.frame = view.bounds
    }

    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/2
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/1.2, y: (header.height-size)/2, width: size, height: size))
        let labell = UILabel(frame: CGRect(x: 5, y: (header.height-size)/2, width: size+120, height: size))
        labell.text = "Click to change picture"
        labell.font = UIFont.boldSystemFont(ofSize: 20)
        labell.textColor = .systemBlue
        header.addSubview(profilePhotoButton)
        header.addSubview(labell)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
        
    }
    
    @objc public func didTapProfilePhotoButton() {
        // Changement de la photo de l'utilisateur
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    // Ici on deque de la table une cellule reutilisable avec l'identifiant que l'on a enregistre
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    @objc private func didTapSave() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        
    }
        
}
