import SwiftUI

struct ReplayView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Replay")
            Text("Previous drawings will appear here.")
        }
        .navigationTitle("Replay")
    }
}

#Preview {
    ReplayView()
}
