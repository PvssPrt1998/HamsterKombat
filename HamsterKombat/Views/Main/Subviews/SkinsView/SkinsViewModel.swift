import Foundation

final class SkinsViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    @Published var selection: Int
    
    var name: String {
        dataManager.hamsters[selection].name
    }
    
    var description: String {
        dataManager.hamsters[selection].description
    }
    
    var price: String {
        separate(price: dataManager.hamsters[selection].price)
    }
    
    var isMoneyEnough: Bool {
        if dataManager.hamsters[selection].price > dataManager.balance {
            return false
        } else {
            return true
        }
    }
    
    var isLeagueEnough: Bool {
        if dataManager.leagueId >= 6 {
            return true
        } else {
            return false
        }
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        selection = dataManager.selectedHamster.id
    }
    
    func getHamsterBy(id: Int) -> Hamster {
        dataManager.hamsters[id]
    }
    
    func isSelectedHamsterPurchased() -> Bool {
        dataManager.hamsters[selection].isAvailable
    }
    
    func buttonTitle() -> String {
        if dataManager.hamsters[selection].isAvailable {
            return "Choose"
        } else if isLeagueEnough {
            return "Buy"
        } else {
            return "Reach the Legendary League to unlock\nthe skin"
        }
    }
    
    func buttonPressed() {
        if dataManager.hamsters[selection].isAvailable {
            dataManager.selectedHamsterId = selection
            dataManager.selectedHamster = dataManager.hamsters[selection]
            dataManager.saveParameters()
        } else {
            dataManager.hamsters[selection].isAvailable = true
            dataManager.balance -= dataManager.hamsters[selection].price
            dataManager.localStorage.editHamster(dataManager.hamsters[selection])
        }
        self.objectWillChange.send()
    }
    
    func buttonDisabled() -> Bool {
        if dataManager.hamsters[selection].isAvailable {
            return false
        } else if !isLeagueEnough || !isMoneyEnough {
            return true
        } else { return false }
    }
    
    private func separate(price: Int) -> String {
        var mutablePrice = price
        var str = ""
        var index = 1
        while mutablePrice > 0 {
            let digit = mutablePrice % 10
            str += "\(digit)"
            if index % 3 == 0 {
                str += " "
            }
            mutablePrice /= 10
            index += 1
        }
        
        return String(str.reversed())
    }
}
