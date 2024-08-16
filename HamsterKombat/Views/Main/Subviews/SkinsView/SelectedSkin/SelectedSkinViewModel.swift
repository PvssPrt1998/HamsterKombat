import Foundation

final class SelectedSkinViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    var hamstersCount: Int {
        dataManager.hamsters.count
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func imageTitleBy(id: Int) -> String {
        dataManager.imageTitleBy(id: id)
    }
}
