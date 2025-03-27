public struct ContactInfo: Hashable {
    public let label: String
    public let contact: String
    
    public init(label: String, contact: String) {
        self.label = label
        self.contact = contact
    }
}
