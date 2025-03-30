import Domain
import PersonsRepository

public enum PersonsEvent: Equatable {
    case didChangePersons(PaginatedArray<Person>)
    case didStartFetchingPersons
    case didFailFetching(PersonsState.PersonsError)
    case didChangeSelectedPerson(Person?)
}
