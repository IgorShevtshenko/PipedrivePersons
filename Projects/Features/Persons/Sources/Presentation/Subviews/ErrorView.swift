import SwiftUI
import UILibrary
import Localization

struct ErrorView: View {
    
    private let text: String
    private let tryAgain: () -> Void
    
    init(text: String, tryAgain: @escaping () -> Void) {
        self.text = text
        self.tryAgain = tryAgain
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text(text)
                .font(.title)
            Button(localisables.common.tryAgain, action: tryAgain)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(text: "Something went wrong"){}
}
