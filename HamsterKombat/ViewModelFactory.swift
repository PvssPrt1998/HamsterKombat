import Foundation

final class ViewModelFactory: ObservableObject {
    
    let dataManager = DataManager()
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(dataManager: dataManager)
    }
    
    func makeBurseViewModel() -> BurseViewModel {
        BurseViewModel(dataManager: dataManager)
    }
    
    func makeSkinsViewModel() -> SkinsViewModel {
        SkinsViewModel(dataManager: dataManager)
    }
    
    func makeSelectedSkinViewModel() -> SelectedSkinViewModel {
        SelectedSkinViewModel(dataManager: dataManager)
    }
    
    func makeSkinsListViewModel() -> SkinsListViewModel {
        SkinsListViewModel(dataManager: dataManager)
    }
    
    func makeMiningViewModel() -> MiningViewModel {
        MiningViewModel(dataManager: dataManager)
    }
    
    func makeDailyRewardViewModel() -> DailyRewardViewModel {
        DailyRewardViewModel(dataManager: dataManager)
    }
    
    func makeLeagueDetailViewModel() -> LeagueDetailViewModel {
        LeagueDetailViewModel(dataManager: dataManager)
    }
    
    func makeLeagueViewModel() -> LeagueViewModel {
        LeagueViewModel(dataManager: dataManager)
    }
    
    func makeProfessionViewModel() -> ProfessionViewModel {
        ProfessionViewModel(dataManager: dataManager)
    }
    
    func makeProfessionDetailViewModel() -> ProfessionDetailsViewModel {
        ProfessionDetailsViewModel(dataManager: dataManager)
    }
    
    func makeMiniGameViewModel() -> MiniGameViewModel {
        MiniGameViewModel(dataManager: dataManager)
    }
    
    func makeGameViewModel() -> GameViewModel {
        GameViewModel(dataManager: dataManager)
    }
    
    func makeTimesUpViewModel() -> TimesUpViewModel {
        TimesUpViewModel(dataManager: dataManager)
    }
    
    func makeLoadingViewModel() -> LoadingViewModel {
        LoadingViewModel(dataManager: dataManager)
    }
    
    func makeTotalProfitPerHourViewModel() -> TotalProfitPerHourViewModel {
        TotalProfitPerHourViewModel(dataManager: dataManager)
    }
    
    func makeFillEnergyViewModel() -> FillEnergyViewModel {
        FillEnergyViewModel(dataManager: dataManager)
    }
}
