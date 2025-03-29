import SwiftUI

public struct PrimaryList<
    Item: Identifiable,
    Cell: View
>: View {
    
    private let items: [Item]
    private let cell: (Item) -> Cell
    
    public init(items: [Item], cell: @escaping (Item) -> Cell) {
        self.items = items
        self.cell = cell
    }
    
    public var body: some View {
        List(items) { item in
            cell(item)
        }
        .listStyle(.insetGrouped)
    }
}
