import UIKit

// Nous avons cree une extension pour ne pas ecrire a chaque fois la commande complete pour acceder a une valeur
// donc nous l'ecrivons une fois pleine

extension UIView {
    
    public var  width: CGFloat {
        return frame.size.width
    }
    
    public var  height: CGFloat {
        return frame.size.height
    }
    
    public var  top: CGFloat {
        return frame.origin.y
    }
    
    public var  bottom: CGFloat {
        return frame.origin.y + frame.size.height
        
    }
    
    public var  left: CGFloat {
        return frame.origin.x
    }
    
    public var  right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
}

// Pour pouvoir inserer dans firebase sans des erreurs
extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
