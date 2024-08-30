import SwiftUI

class TimerWrapper: ObservableObject {
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

struct HamsterButton: View {
    
    @StateObject var timerWrapper = TimerWrapper()
    let initialImageTitle: String
    @Binding var imageTitle: String
    @State var imageChanging = false
    @State var sparkRotateValue: CGFloat = 0
    @State var sparkingTimer = 0
    @State var sparking = false
    var disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
            if !imageChanging && initialImageTitle == ImageTitles.DefaultHamster.rawValue {
                changeImage()
            }
            if sparkingTimer <= 0 {
                sparkingTimer = 5
                withAnimation {
                    sparking = true
                }
            }
        } label: {
            Image(ImageTitles.HamsterButtonBackground.rawValue)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(Circle())
                .contentShape(Circle())
            
        }
        .contentShape(Circle())
        .buttonStyle(HamsterButtonStyle(imageTitle: $imageTitle))
        .disabled(disabled)
        .overlay(
            Image(ImageTitles.Spark1.rawValue)
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(sparkRotateValue))
                .allowsHitTesting(false)
                .opacity(sparking ? 1 : 0)
        )
        .onReceive(timerWrapper.timer){ value in
            if sparkingTimer > 0 {
                sparkingTimer -= 1
            } else {
                withAnimation {
                    sparking = false
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                sparkRotateValue = 360
            }
        }
    }
    
    func changeImage() {
        imageChanging = true
        
        for index in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState2.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState3.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState4.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState5.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState6.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState7.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState8.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState7.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState6.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState5.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState4.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState3.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamsterState2.rawValue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4 + Double(index) * 1.4) {
                imageTitle = ImageTitles.DefaultHamster.rawValue
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.4) {
            imageChanging = false
        }
    }
}

//#Preview {
//    HamsterButton(initialImageTitle: ImageTitles.DefaultHamster.rawValue, imageTitle: ImageTitles.DefaultHamster.rawValue, disabled: false) {
//        
//    }
//}

struct HamsterButtonStyle: ButtonStyle {
    
    @Binding var imageTitle: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                Image(imageTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(33)
            )
            .padding(configuration.isPressed ? 27 : 17)
            .background(
                Image(ImageTitles.HamsterButtonBackground.rawValue)
                    .resizable()
                    .clipShape(Circle())
                    .rotationEffect(.degrees(20))
            )
            .padding(.horizontal, 15)
    }
    
    func changeState(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            imageTitle = ImageTitles.DefaultHamsterState2.rawValue
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            imageTitle = ImageTitles.DefaultHamster.rawValue
            completion()
        }
        
        
    }
}
