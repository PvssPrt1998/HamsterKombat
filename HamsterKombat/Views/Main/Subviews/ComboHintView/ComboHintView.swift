
import SwiftUI

struct ComboHintView: View {
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @Binding var showComboHintView: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 66) {
                Image(ImageTitles.WizardHamster.rawValue)
                    .resizable()
                    .scaledToFit()
                TextCustom(text: "Find 3 combo cards and upgrade them to get a prize", size: 16, weight: .medium, color: .white)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 34)
            .frame(maxHeight: .infinity, alignment: .top)
            CloseButton(action: {
                sheetSizeManager.dismissSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showComboHintView = false
                }
            })
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .offset(x: 0, y: sheetSizeManager.topPadding)
        .onAppear {
            sheetSizeManager.appearance()
        }
    }
}

struct ComboHintView_Preview: PreviewProvider {
    
    @State static var showComboHintView = false
    
    static var previews: some View {
        ComboHintView(sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight), showComboHintView: $showComboHintView)
    }
}
