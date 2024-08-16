import Foundation

final class ViewModelFactory: ObservableObject {
    
    let dataManager = DataManager()
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(dataManager: dataManager)
    }
    
    func makeBurseViewModel() -> BurseViewModel {
        BurseViewModel(dataManager: dataManager)
    }
    
    func makeSkinsViewModel() -> SkinsViewModel {
        SkinsViewModel(dataManager: dataManager)
    }
    
    func makeSelectedSkinViewModel() -> SelectedSkinViewModel {
        SelectedSkinViewModel(dataManager: dataManager)
    }
    
    func makeSkinsListViewModel() -> SkinsListViewModel {
        SkinsListViewModel(dataManager: dataManager)
    }
}
