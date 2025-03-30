import Foundation

public struct LocalisablesStrings {
    
    public var common: Common { Common() }
    
    public struct Common {
        
        public var notAvailable: String {
            String(localized: "notAvailable", table: "Common", bundle: .module)
        }
        public var tryAgain: String {
            String(localized: "tryAgain", table: "Common", bundle: .module)
        }
        public var somethingWentWrong: String {
            String(localized: "somethingWentWrong", table: "Common", bundle: .module)
        }
    }
    
    public var persons: Persons { Persons() }
    
    public struct Persons {
        
        public var navTitle: String {
            String(localized: "navTitle", table: "Persons", bundle: .module)
        }
        public var noPersons: String {
            String(localized: "noPersons", table: "Persons", bundle: .module)
        }
    }
}
