import UIKit

// chaque model va avoir un titre et un handler
struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController{
   
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // Tableau a 2 dimensions pour plusieurs sections
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            },
        ])
        
    }
    
    private func didTapEditProfile() {
        // Editer profile
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let nanVC = UINavigationController(rootViewController: vc)
        nanVC.modalPresentationStyle = .fullScreen
        present(nanVC, animated: true)
    }
    
 
    private func didTapLogOut() {
        // Affichage a l'utilisateur une action sheet pour la confirmation et deconnecter
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
   
        // Si l'utilisateur se deconnect de son compte on present la page login
        AuthManager.shared.logOut(completion: { success in
            DispatchQueue.main.async {
                if success {
                    // Presenter log in
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        // Permettre a l'utilisetur de revenir a la page initial de l'apllication quand il se deconnecte et puis il se reconnecte avec son compte et de ne pas revenir a la page settings
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                }
                else {
                    fatalError("Could not log out user")
                }
            }
        })
            
        }))
        
        // Pour bon fonctionnement sur Ipad
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
        
    }
    
}
    extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return data.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data[section].count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.section][indexPath.row].title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            data[indexPath.section][indexPath.row].handler()
        }
        
    }
    

  


