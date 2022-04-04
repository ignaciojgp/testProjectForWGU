import SwiftUI

struct AbilityCellView: View {
    
    let viewModel: AbilityCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.name).bold()
            Text(viewModel.description)
        }
    }
}

struct AbilityCellView_Previews: PreviewProvider {
    static var previews: some View {
        AbilityCellView(viewModel: AbilityCellViewModel(name: "some name", description: "some description"))
    }
}
