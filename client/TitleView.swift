import SwiftUI

struct TitleView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("DrawGame")
                    .font(.largeTitle)
                NavigationLink("Start") {
                    MatchingView()
                }
            }
        }
    }
}

#Preview {
    TitleView()
}
