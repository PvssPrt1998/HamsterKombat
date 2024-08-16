import SwiftUI

struct SelectedSkinView: View {
    
    @ObservedObject var viewModel: SelectedSkinViewModel
    
    @Binding var selection: Int
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<viewModel.hamstersCount, id: \.self) { index in
                Image(viewModel.imageTitleBy(id: index))
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 66)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(
            HStack {
                Button {
                    withAnimation {
                        if selection > 0 {
                            selection -= 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColorCustom(.white.opacity(0.4))
                        .frame(width: 66, height: 66)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        if selection < viewModel.hamstersCount - 1 {
                            selection += 1
                        }
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundColorCustom(.white.opacity(0.4))
                        .frame(width: 66, height: 66)
                }
            }
        )
    }
}

struct SelectedSkinView_Preview: PreviewProvider {
    
    @State static var selection: Int = 0
    
    static var previews: some View {
        SelectedSkinView(viewModel: SelectedSkinViewModel(dataManager: DataManager()),
                         selection: $selection
        )
        .background(Color.black)
    }
}
