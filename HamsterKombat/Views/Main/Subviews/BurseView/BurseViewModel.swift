import Foundation

final class BurseViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func selectedImageTitle() -> String {
        dataManager.imageTitleBy(id: dataManager.selectedHamster.id)
    }
}
