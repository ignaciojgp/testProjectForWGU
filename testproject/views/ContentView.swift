
import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        List(viewModel.items) { item in
            AbilityCellView(viewModel: item)
        }
        .onAppear{
            viewModel.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel(getRegistersUseCase: MockGetRegistersUseCase())
        return ContentView(viewModel: viewModel)
    }
}
