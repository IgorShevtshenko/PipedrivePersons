import SwiftUI
import UILibrary
import Domain
import Localization

struct PersonDetails: View {
    
    private let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    var body: some View {
        Form {
            Text(person.name ?? localisables.common.notAvailable)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color(UIColor.systemGroupedBackground))
            
            makeContactInfoSections(
                for: person.phones,
                title: localisables.persons.phonesSectionTitle
            )
            makeContactInfoSections(
                for: person.emails,
                title: localisables.persons.emailsSectionTitle
            )
            
        }
    }
    
    @ViewBuilder
    func makeContactInfoSections(for info: [ContactInfo], title: String) -> some View {
        if !info.isEmpty {
            Section {
                ForEach(info, id: \.self) { info in
                    HStack(alignment: .center, spacing: 4) {
                        Text(info.label)
                            .font(.headline1)
                        Text(info.contact)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            } header: {
                Text(title)
            }
        }
    }
}

#Preview {
    PersonDetails(person: .mock(id: 1))
}
