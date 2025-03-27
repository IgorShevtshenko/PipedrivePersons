public struct Person: Hashable, Identifiable {
    public let id: Int
    public let name: String?
    public let phones: [ContactInfo]
    public let emails: [ContactInfo]
    
    public init(id: Int, name: String?, phones: [ContactInfo], emails: [ContactInfo]) {
        self.id = id
        self.name = name
        self.phones = phones
        self.emails = emails
    }
}

public extension Person {
    
    static func mock(id: Int) -> Person {
        Person(id: id, name: "Name", phones: [], emails: [])
    }
}
