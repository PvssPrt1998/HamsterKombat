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
