import SwiftUI

struct ExplodeView: View {
    
    @State var opacity: Double = 0
    @State var colorOpacity: Double = 0
    @Binding var showExplode: Bool
    @State var height: CGFloat = 600
    @State var coinsOffset: CGFloat = -800
    
    var greeting: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .opacity(colorOpacity)
            ZStack {
                Image(ImageTitles.Explode.rawValue)
                    .resizable()
                    .ignoresSafeArea()
                
                if greeting {
                    Image(ImageTitles.Greeting.rawValue)
                        .resizable()
                        .scaledToFit()
                }
            }
            .opacity(opacity)
            if !greeting {
                coinsView()
            }
        }
        .ignoresSafeArea()
        .background(
            GeometryReader { geo in
                Color.clear.onAppear(perform: {
                    DispatchQueue.main.async {
                        height = geo.size.height
                        coinsOffset = -height
                    }
                })
            }
        )
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                colorOpacity = 1
                opacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation(.linear(duration: 1)) {
                    opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                withAnimation(.linear(duration: 1.2)) {
                    coinsOffset = height
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.linear(duration: 1)) {
                    coinsOffset = height
                    colorOpacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                showExplode = false
            }
        }
    }
    
    func coinsView() -> some View {
        Image(ImageTitles.CoinsRain.rawValue)
            .resizable()
            .scaledToFit()
            .offset(y: coinsOffset)
    }
}

struct ExplodeView_Preview: PreviewProvider {
    
    @State static var show = false
    
    static var previews: some View {
        ExplodeView(showExplode: $show)
    }
    
}
