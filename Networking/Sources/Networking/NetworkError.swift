public enum NetworkError: Error, Equatable {
    case general
    case externalError(Int)
    case noInternetConnection
}
