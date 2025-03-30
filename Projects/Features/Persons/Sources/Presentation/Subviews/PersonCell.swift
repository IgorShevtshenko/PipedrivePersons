import SwiftUI
import Domain
import Localization
import UILibrary

struct PersonCell: View {
    
    private let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(person.name ?? localisables.common.notAvailable)
                .font(.title1)
            Group {
                person.emails.first.map {
                    Text($0.contact)
                }
                person.phones.first.map {
                    Text($0.contact)
                }
            }
            .font(.body1)
        }
    }
}

#Preview {
    PersonCell(person: .mock(id: 1))
}
