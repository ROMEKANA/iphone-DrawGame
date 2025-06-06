import SwiftUI

struct ChoiceView: View {
    let options = ["Real Prompt", "Fake 1", "Fake 2", "Fake 3"]

    var body: some View {
        VStack {
            Text("Choose the correct title")
            List(options, id: \.self) { opt in
                Text(opt)
            }
            NavigationLink("Confirm") {
                ResultView()
            }
            .padding()
        }
        .navigationTitle("Choose")
    }
}

#Preview {
    ChoiceView()
}
