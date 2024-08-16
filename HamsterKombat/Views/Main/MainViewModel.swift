import Foundation

final class MainViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    enum ScreenType {
        case burse
        case mining
    }
    
    @Published var screenType: ScreenType = .burse
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}
