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
    
    func saveReward(id: Int, got: Bool) {
        do {
            let rewardObjects = try coreDataStack.managedContext.fetch(DailyRewardCoreData.fetchRequest())
            var founded = false
            rewardObjects.forEach { reward in
                if reward.id == Int32(id) {
                    reward.got = got
                    founded = true
                }
            }
            if !founded {
                let reward = DailyRewardCoreData(context: coreDataStack.managedContext)
                reward.id = Int32(id)
                reward.got = got
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func fetchRewards() throws -> Array<(Int,Bool)> {
        var rewards: Array<(Int,Bool)> = []
        let rewardObjects = try coreDataStack.managedContext.fetch(DailyRewardCoreData.fetchRequest())
        rewardObjects.forEach { reward in
            rewards.append((Int(reward.id), reward.got))
        }
        return rewards
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
    
    func saveParameters(leagueId: Int, selectedHamsterId: Int) {
        do {
            let parametersObjects = try coreDataStack.managedContext.fetch(Parameters.fetchRequest())
            if parametersObjects.count > 0 {
                if let first = parametersObjects.first {
                    first.leagueId = Int32(leagueId)
                    first.selectedHamsterId = Int32(selectedHamsterId)
                }
            } else {
                let parameters = Parameters(context: coreDataStack.managedContext)
                parameters.leagueId = Int32(leagueId)
                parameters.selectedHamsterId = Int32(selectedHamsterId)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
    
    func fetchParameters() throws -> Parameters? {
        let parameters = try coreDataStack.managedContext.fetch(Parameters.fetchRequest()).first
        guard let parameters = parameters else { return nil }
        return parameters
    }
    
    func fetchTapValue() throws -> TapValueCoreData? {
        let tapValue = try coreDataStack.managedContext.fetch(TapValueCoreData.fetchRequest()).first
        guard let tapValue = tapValue else { return nil }
        return tapValue
    }
    
    func editTapValue(_ tapValue: Int, tapValueLevel: Int) {
        do {
            let tapValueCoreDataObjects = try coreDataStack.managedContext.fetch(TapValueCoreData.fetchRequest())
            if tapValueCoreDataObjects.count > 0 {
                if let first = tapValueCoreDataObjects.first {
                    first.tapValue = Int32(tapValue)
                    first.tapValueLevel = Int32(tapValueLevel)
                }
            } else {
                let tapValueCoreData = TapValueCoreData(context: coreDataStack.managedContext)
                tapValueCoreData.tapValue = Int32(tapValue)
                tapValueCoreData.tapValueLevel = Int32(tapValueLevel)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
    
    func editEnergyLevel(_ maxEnergy: Int, energyLevel: Int) {
        do {
            let energyLevelObjects = try coreDataStack.managedContext.fetch(EnergyLevel.fetchRequest())
            if energyLevelObjects.count > 0 {
                if let first = energyLevelObjects.first {
                    first.maxEnergy = Int32(maxEnergy)
                    first.maxEnergyLevel = Int32(energyLevel)
                }
            } else {
                let energyLevelCoreData = EnergyLevel(context: coreDataStack.managedContext)
                energyLevelCoreData.maxEnergy = Int32(maxEnergy)
                energyLevelCoreData.maxEnergyLevel = Int32(energyLevel)
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
    
    func fetchEnergyLevel() throws -> EnergyLevel? {
        let energyLevel = try coreDataStack.managedContext.fetch(EnergyLevel.fetchRequest()).first
        guard let energyLevel = energyLevel else { return nil }
        return energyLevel
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
    
    func save(combo: Array<(Int,Bool)>) {
        do {
            let comboObjects = try coreDataStack.managedContext.fetch(Combo.fetchRequest())
            if comboObjects.count > 0 {
                if let first =  comboObjects.first {
                    first.first = Int32(combo[0].0)
                    first.second = Int32(combo[1].0)
                    first.third = Int32(combo[2].0)
                    first.firstGot = combo[0].1
                    first.secondGot = combo[1].1
                    first.thirdGot = combo[2].1
                }
            } else {
                let comboCoreData = Combo(context: coreDataStack.managedContext)
                comboCoreData.first = Int32(combo[0].0)
                comboCoreData.second = Int32(combo[1].0)
                comboCoreData.third = Int32(combo[2].0)
                comboCoreData.firstGot = combo[0].1
                comboCoreData.secondGot = combo[1].1
                comboCoreData.thirdGot = combo[2].1
            }
            
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
    
    func fetchCombo() throws -> Array<(Int,Bool)>? {
        let combo = try coreDataStack.managedContext.fetch(Combo.fetchRequest()).first
        guard let combo = combo else { return nil }
        let array: Array<(Int,Bool)> = [(Int(combo.first),combo.firstGot), (Int(combo.second),combo.secondGot), (Int(combo.third),combo.thirdGot)]
        return array
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
    
    func saveDayIndex(_ dayIndex: Int) {
        do {
            let dayIndexObjects = try coreDataStack.managedContext.fetch(DayIndex.fetchRequest())
            if dayIndexObjects.count > 0 {
                if let first =  dayIndexObjects.first {
                    first.dayIndex = Int32(dayIndex)
                }
            } else {
                let dayIndexCoreData = DayIndex(context: coreDataStack.managedContext)
                dayIndexCoreData.dayIndex = Int32(dayIndex)
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func fetchDayIndex() throws -> Int? {
        let dayIndex = try coreDataStack.managedContext.fetch(DayIndex.fetchRequest()).first
        guard let dayIndex = dayIndex else { return nil }
        return Int(dayIndex.dayIndex)
    }
    
    func saveSavedDate(_ savedDate: String) {
        do {
            let savedDateObjects = try coreDataStack.managedContext.fetch(SavedDateCoreData.fetchRequest())
            if savedDateObjects.count > 0 {
                if let first =  savedDateObjects.first {
                    first.savedDate = savedDate
                }
            } else {
                let savedDateCoreData = SavedDateCoreData(context: coreDataStack.managedContext)
                savedDateCoreData.savedDate = savedDate
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        coreDataStack.saveContext()
    }
    
    func fetchSavedDate() throws -> String? {
        let savedDate = try coreDataStack.managedContext.fetch(SavedDateCoreData.fetchRequest()).first
        guard let savedDate = savedDate else { return nil }
        return savedDate.savedDate
    }
    
    func fetchBalance() throws -> Int? {
        let balanceCoreData = try coreDataStack.managedContext.fetch(Balance.fetchRequest()).first
        guard let balanceCoreData = balanceCoreData else { return nil }
        return Int(balanceCoreData.balance)
    }
    
    func fetchMiniGameTimer() throws -> Int? {
        let miniGameTimer = try coreDataStack.managedContext.fetch(MiniGameTimerCoreData.fetchRequest()).first
        guard let miniGameTimer = miniGameTimer else { return nil }
        return Int(miniGameTimer.miniGameTimer)
    }
    
    func fetchEnergy() throws -> Int? {
        let energy = try coreDataStack.managedContext.fetch(EnergyCoreData.fetchRequest()).first
        guard let energy = energy else { return nil }
        return Int(energy.energy)
    }
    
    func fetchEnergyFillRestoreTimer() throws -> Int? {
        let energyFillRestoreTimer = try coreDataStack.managedContext.fetch(EnergyFillRestoreTimerCoreData.fetchRequest()).first
        guard let energyFillRestoreTimer = energyFillRestoreTimer else { return nil }
        return Int(energyFillRestoreTimer.energyFillRestoreTimer)
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
