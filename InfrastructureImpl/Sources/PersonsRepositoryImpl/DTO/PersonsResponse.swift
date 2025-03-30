struct PersonsResponse: Decodable {
    let data: [PersonEntity]
    let additional_data: CursorEntity
}

struct PersonEntity: Decodable {
    let id: Int
    let name: String?
    let phones: [ContactInfoEntity]
    let emails: [ContactInfoEntity]
}

struct ContactInfoEntity: Decodable {
    let label: String
    let value: String
}

struct CursorEntity: Decodable {
    let next_cursor: String?
}

extension PersonEntity {
    
    static func mock(id: Int) -> PersonEntity {
        PersonEntity(
            id: id,
            name: "Name",
            phones: [.init(label: "Work", value: "372 5430 3410")],
            emails: [.init(label: "Work", value: "test@gmail.com")]
        )
    }
}
