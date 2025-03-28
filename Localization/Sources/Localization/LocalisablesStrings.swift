import Foundation

public struct LocalisablesStrings {
    
    public var persons: Persons { Persons() }
    
    public struct Persons {
        
        public var navTitle: String {
            String(localized: "navTitle", table: "Persons", bundle: .module)
        }
    }
}
