import SwiftUI

@main
struct HamsterKombatApp: App {
    
    let viewModelFactory = ViewModelFactory()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModelFactory.makeMainViewModel())
                .environmentObject(viewModelFactory)
        }
    }
}
