import Foundation
import Combine

final class ProfessionDetailsViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    private var professionCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        professionCancellable = dataManager.$professions.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func getProfession(by id: Int) -> Profession {
        dataManager.professions[id]
    }
    
    func isMoneyEnough(id: Int) -> Bool {
        if dataManager.professions[id].price > dataManager.balance {
            return false
        } else {
            return true
        }
    }
    
    func isMaxLevel(id: Int) -> Bool {
        if dataManager.professions[id].level == 20 {
            return true
        } else {
            return false
        }
    }
    
    func imageTitleBy(id: Int) -> String {
        dataManager.professionImageTitleLarge(id: id)
    }
    
    func buttonDisabled(id: Int) -> Bool {
        isMoneyEnough(id: id) && dataManager.professions[id].level < 20 ? false : true
    }
    
    func isLevelMax(id: Int) -> Bool {
        if dataManager.professions[id].level == 20 {
            return true
        } else {
            return false
        }
    }
    
    func buttonPressed(id: Int) {
        dataManager.professionLevelUp(id: id)
    }
}
