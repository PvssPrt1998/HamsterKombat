import SwiftUI

struct SkinsListView: View {
    
    @Binding var selection: Int
    @ObservedObject var viewModel: SkinsListViewModel
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(viewModel.hamsters, id: \.self) { hamster in
                SkinListItemView(hamster: hamster, isSelected: isSelected(id: hamster.id), isDefault: isDefault(id: hamster.id))
            }
        }
    }
    
    private func isSelected(id: Int) -> Bool {
        selection == id ? true : false
    }
    
    private func isDefault(id: Int) -> Bool {
        viewModel.isDefault(id: id)
    }
}

struct SkinsListView_Preview: PreviewProvider {
    
    @State static var selection: Int = 0
    
    static var previews: some View {
        SkinsListView(selection: $selection, viewModel: SkinsListViewModel(dataManager: DataManager()))
    }
}
