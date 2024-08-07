import SwiftUI

struct LoadingView: View {
    
    @State var rotationValue: Double = 45
    
    var body: some View {
        ZStack {
            Image(ImageTitles.LoadingBackground.rawValue)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    CircularProgressBarProgressView()
                        .rotationEffect(.degrees(rotationValue))
                        .frame(width: 100, height: 100)
                        
                        .padding(.top, 29)
                    TextCustom(text: "Hamster Kombat Token", size: 32, weight: .bold, color: .textOrange)
                        .padding(.top, 29)
                    TextCustom(text: "will be launched", size: 20, weight: .bold, color: .white.opacity(0.48))
                    TextCustom(text: "on TON", size: 80, weight: .black, color: .white)
                    TextCustom(text: "Stay tuned", size: 20, weight: .bold, color: .white.opacity(0.48))
                }
        }
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                rotationValue = 1440
            }
        }
    }
}

#Preview {
    LoadingView()
}

struct CircularProgressBarProgressView: View {
    @State var lineWidth: CGFloat = 8
    @State var color: Color = .green
    var body: some View {
        Circle()
            .trim(from: 0.2, to: 1)
            .stroke(LinearGradient(colors: [.loadingIndicator, .white], startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    ))
            .rotationEffect(.degrees(-90))
            .padding(lineWidth/2)
    }
}
