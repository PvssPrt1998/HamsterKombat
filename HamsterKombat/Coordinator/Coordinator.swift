import SwiftUI
import Combine

final class Coordinator: ObservableObject {
    
    enum Screens {
        case loading
        case game
    }
    
    @Published var screen: Screens = .loading
    
    let viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    private var loadingAnyCancellable: AnyCancellable?
    
    @ViewBuilder func build() -> some View {
        switch screen {
        case .loading: loadingView()
        case .game: MainView(viewModel: viewModelFactory.makeMainViewModel())
        }
    }
    
    func loadingView() -> some View {
        let viewModel = viewModelFactory.makeLoadingViewModel()
        bind(viewModel)
        let view = LoadingView(viewModel: viewModel)
        return view
    }
    
    func bind(_ viewModel: LoadingViewModel) {
        loadingAnyCancellable = viewModel.loadedForCoordinator
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.screen = .game
            }
    }
}
