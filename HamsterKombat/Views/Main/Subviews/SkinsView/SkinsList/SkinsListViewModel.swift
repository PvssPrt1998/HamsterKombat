import Foundation
import Combine

final class SkinsListViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    private var anyCancellable: AnyCancellable?
    
    var hamsters: Array<Hamster> {
        dataManager.hamsters
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        anyCancellable = dataManager.$hamsters.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func isDefault(id: Int) -> Bool {
        dataManager.selectedHamster.id == id ? true : false
    }
}
