import Foundation

final class LocalStorage {
    private let modelName = "HamsterLocalStorageModel"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func saveProfession(_ profession: Profession) {
        let professionCoreData = ProfessionCoreData(context: coreDataStack.managedContext)
        professionCoreData.id = Int32(profession.id)
        professionCoreData.level = Int32(profession.level)
        professionCoreData.totalProfit = Int32(profession.totalProfit)
        professionCoreData.profit = Int32(profession.profit)
        professionCoreData.price = Int32(profession.price)
        coreDataStack.saveContext()
    }
    
    func saveHamster(_ hamster: Hamster) {
        let hamsterCoreData = HamsterCoreData(context: coreDataStack.managedContext)
        hamsterCoreData.id = Int32(hamster.id)
        hamsterCoreData.available = hamster.isAvailable
        coreDataStack.saveContext()
    }
    
    func saveEnergyFillRestoreTimer(_ timerValue: Int) {
        do {
            let energyFillRestoreTimerCoreDataObjects = try coreDataStack.managedContext.fetch(EnergyFillRestoreTimerCoreData.fetchRequest())
            if energyFillRestoreTimerCoreDataObjects.count > 0 {
                if let first = energyFillRestoreTimerCoreDataObjects.first {
                    first.energyFillRestoreTimer = Int32(timerValue)
                }
            } else {
                let energyFillRestoreTimerCoreData = EnergyFillRestoreTimerCoreData(context: coreDataStack.managedContext)
                energyFillRestoreTimerCoreData.energyFillRestoreTimer = Int32(timerValue)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func saveEnergy(_ energy: Int) {
        do {
            let energyObjects = try coreDataStack.managedContext.fetch(EnergyCoreData.fetchRequest())
            if energyObjects.count > 0 {
                if let first =  energyObjects.first {
                    first.energy = Int32(energy)
                }
            } else {
                let energyCoreData = EnergyCoreData(context: coreDataStack.managedContext)
                energyCoreData.energy = Int32(energy)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func saveBalance(_ balance: Int) {
        do {
            let balanceObjects = try coreDataStack.managedContext.fetch(Balance.fetchRequest())
            if balanceObjects.count > 0 {
                if let first =  balanceObjects.first {
                    first.balance = Int64(balance)
                }
            } else {
                let balanceCoreData = Balance(context: coreDataStack.managedContext)
                balanceCoreData.balance = Int64(balance)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
    
    func saveMiniGameTimer(_ timerValue: Int) {
        do {
            let miniGameTimerObjects = try coreDataStack.managedContext.fetch(MiniGameTimerCoreData.fetchRequest())
            if miniGameTimerObjects.count > 0 {
                if let first =  miniGameTimerObjects.first {
                    first.miniGameTimer = Int32(timerValue)
                }
            } else {
                let miniGameTimer = MiniGameTimerCoreData(context: coreDataStack.managedContext)
                miniGameTimer.miniGameTimer = Int32(timerValue)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func fetchBalance() throws -> Int? {
        let balanceCoreData = try coreDataStack.managedContext.fetch(Balance.fetchRequest()).first
        guard let balanceCoreData = balanceCoreData else { return nil }
        return Int(balanceCoreData.balance)
    }
    
    func fetchMiniGameTimer() throws -> Int {
        Int(try coreDataStack.managedContext.fetch(MiniGameTimerCoreData.fetchRequest()).first?.miniGameTimer ?? 0)
    }
    
    func fetchEnergy() throws -> Int {
        Int(try coreDataStack.managedContext.fetch(EnergyCoreData.fetchRequest()).first?.energy ?? 0)
    }
    
    func fetchEnergyFillRestoreTimer() throws -> Int {
        Int(try coreDataStack.managedContext.fetch(EnergyFillRestoreTimerCoreData.fetchRequest()).first?.energyFillRestoreTimer ?? 0)
    }
    
    func editHamster(_ hamster: Hamster) {
        do {
            let hamstersCoreData = try fetchHamstersCoreData()
            hamstersCoreData.forEach { hamsterCoreData in
                if hamsterCoreData.id == hamster.id {
                    hamsterCoreData.available = hamster.isAvailable
                    coreDataStack.saveContext()
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func editProfession(_ profession: Profession) {
        do {
            let professionsCoreData = try fetchProfessions()
            professionsCoreData.forEach { professionCoreData in
                if professionCoreData.id == profession.id {
                    
                    professionCoreData.level = Int32(profession.level)
                    professionCoreData.totalProfit = Int32(profession.totalProfit)
                    professionCoreData.price = Int32(profession.price)
                    professionCoreData.profit = Int32(profession.profit)

                    coreDataStack.saveContext()
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchProfessions() throws -> [ProfessionCoreData] {
        try coreDataStack.managedContext.fetch(ProfessionCoreData.fetchRequest())
    }
    
    func fetchHamstersCoreData() throws -> [HamsterCoreData] {
        try coreDataStack.managedContext.fetch(HamsterCoreData.fetchRequest())
    }
}
