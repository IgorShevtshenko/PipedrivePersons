import SwiftUI

public final class StateObjectWrapper<Object>: ObservableObject {
    public let object: Object
    
    public init(object: Object) {
        self.object = object
    }
}
