import SwiftUI

struct ResultView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Results")
            Text("Scores will appear here.")
            NavigationLink("View Replay") {
                ReplayView()
            }
            NavigationLink("Back to Title") {
                TitleView()
            }
        }
        .navigationTitle("Results")
    }
}

#Preview {
    ResultView()
}
