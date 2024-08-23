import Foundation
import Combine

final class MiningViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    var professionId: Int = 0
    
    var professions: Array<Profession> {
        dataManager.professions
    }
    
    var balance: Int {
        dataManager.balance
    }
    
    private var balanceCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        balanceCancellable = dataManager.$balance.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func balanceString() -> String {
        String(String("\(dataManager.balance)".reversed()).separate(every: 3, with: ",").reversed())
    }
    
    func hiddenString() -> String {
        var str = " "
        for _ in 0..<"\(dataManager.balance)".count {
            str += "9"
        }
        str = String(String(str.reversed()).separate(every: 3, with: ",").reversed())
        str += " "
        return str
    }
    
    func getProfession(by index: Int) -> Profession {
        dataManager.professions[index]
    }
    
    func getProfessionImageTitle(by index: Int) -> String {
        dataManager.professionImageTitle(id: index)
    }
}
