import Domain

extension Person {
    
    init(from entity: PersonEntity) {
        self = Person(
            id: entity.id,
            name: entity.name,
            phones: entity.phones.map(ContactInfo.init),
            emails: entity.emails.map(ContactInfo.init)
        )
    }
}

extension ContactInfo {
    
    init(from entity: ContactInfoEntity) {
        self = ContactInfo(
            label: entity.label,
            contact: entity.value
        )
    }
}

extension PaginatedArray.Cursor {
    
    init(from entity: CursorEntity) {
        if let cursor = entity.next_cursor {
            self = .page(cursor)
        } else {
            self = .end
        }
    }
}
