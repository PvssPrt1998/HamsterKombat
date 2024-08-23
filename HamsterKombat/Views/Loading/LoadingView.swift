import SwiftUI
import Combine

struct LoadingView: View {
    
    @State var rotationValue: Double = 45
    
    @ObservedObject var viewModel: LoadingViewModel
   
    let random = Int.random(in: 1...3)
    
    var body: some View {
        ZStack {
            Image(randomBackground())
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
            withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)) {
                rotationValue = 405
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.load()
            }
        }
    }
    
    func randomBackground() -> String {
        switch random {
        case 1: return ImageTitles.LoadingBackground.rawValue
        case 2: return ImageTitles.LoadingBackground1.rawValue
        case 3: return ImageTitles.LoadingBackground2.rawValue
        default:
            return ImageTitles.LoadingBackground.rawValue
        }
    }
}

#Preview {
    LoadingView(viewModel: LoadingViewModel(dataManager: DataManager()))
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

final class LoadingViewModel: ObservableObject {
    @Published var dataManager: DataManager
    
    let loadedForCoordinator = PassthroughSubject<Bool, Never>()
    
    @Published var localLoaded = false {
        didSet {
            if localLoaded {
                loadedForCoordinator.send(true)
            }
        }
    }
    
    var loadedCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        loadedCancellable = dataManager.$localDataLoaded.sink { [weak self] value in
            if value {
                self?.localLoaded = value
            }
        }
    }
    
    func load() {
        dataManager.loadLocalData()
    }
}
