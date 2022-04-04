import SwiftUI

@main
struct testprojectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel(
                    getRegistersUseCase: GetRegistersUseCase(
                        dataSource: ApiDataSource()
                    )
                )
            )
            
        }
    }
}
