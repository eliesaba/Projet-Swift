import FirebaseDatabase

// Gere tout ce qui est en rapport avec notre base de donnee
public class DatabaseManager {
    
    static let shared = DatabaseManager()
    // Faire refereence a la base de donnee
    private let database = Database.database().reference()
    
    // Verifier si username et email sont disponibles
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    // Inserrer un nouveau utilisateur vers la base de donnee
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        // Nous avons utilise la fonction safeDatabaseKey qui est ecrite dans le fichier 'extensions' pour transformer un caractere afin de rendre l'insertion dans firebase valide
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // Reussi
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
   
    
}
