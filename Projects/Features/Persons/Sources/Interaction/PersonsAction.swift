import Domain

public enum PersonsAction {
    case fetchPersons
    case initialFetching
    case fetchMorePersons
    case openPersonDetails(Person)
    case closePersonDetails
}
