import SwiftUI

struct HamsterButton: View {
    
    var imageTitle: String
    var disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        } label: {
            Circle()
        }
        .buttonStyle(HamsterButtonStyle(imageTitle: imageTitle))
        .disabled(disabled)
    }
}

#Preview {
    HamsterButton(imageTitle: ImageTitles.DefaultHamster.rawValue, disabled: false) {
        
    }
}

struct HamsterButtonStyle: ButtonStyle {
    
    var imageTitle: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                Circle()
                    .fill(LinearGradient(
                        colors:
                            [
                                configuration.isPressed ? .onTap1 : .orangeBottomGradient,  configuration.isPressed ? .onTap2 : .orangeTopGradient],
                        startPoint: .bottom, endPoint: .top))
            )
            .overlay(
                Image(imageTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(33)
            )
            .padding(configuration.isPressed ? 27 : 17)
            .background(
                Circle()
                    .fill(LinearGradient(
                        colors: [.orangeTopGradient, .orangeBottomGradient],
                        startPoint: .bottom, endPoint: .top))
            )
            .shadow(color: .hamsterTapAreaShadow, radius: 25)
            .padding(.horizontal, 15)
    }
}
