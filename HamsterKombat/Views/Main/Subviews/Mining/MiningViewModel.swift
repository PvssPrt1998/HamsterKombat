import Foundation
import Combine

final class MiningViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    var professionId: Int = 0
    
    var professions: Array<Profession> {
        dataManager.professions
    }
    
    @Published var comboAmount: Int
    
    var balance: Int {
        dataManager.balance
    }
    
    @Published var toNextDayTimer: Int
    
    private var balanceCancellable: AnyCancellable?
    private var toNextDayCancellable: AnyCancellable?
    private var comboCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.toNextDayTimer = dataManager.toNextDayTimer
        
        var amount = 0
        dataManager.combo.forEach { (number, boolean) in
            if boolean {
                amount += 1
            }
        }
        self.comboAmount = amount
        
        balanceCancellable = dataManager.$balance.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        toNextDayCancellable = dataManager.$toNextDayTimer.sink { [weak self] value in
            self?.toNextDayTimer = value
        }
    }
    
    func comboCheck(_ id: Int) {
        
    }
    
    func reloadTime() -> String {
        let hours = toNextDayTimer / 3600
        let minutes = toNextDayTimer / 60 - ((toNextDayTimer / 3600) * 60)
        let seconds = toNextDayTimer - (toNextDayTimer / 60 * 60)
        var secondsStr = ""
        var hoursStr = ""
        
        if hours > 0 {
            hoursStr = "\(hours):"
        }
        
        if seconds >= 10 {
            secondsStr = "\(seconds)"
        } else {
            secondsStr = "0\(seconds)"
        }
        return hoursStr + "\(minutes):" + secondsStr
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
