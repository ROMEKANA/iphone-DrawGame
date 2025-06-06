import SwiftUI

struct TitleInputView: View {
    @State private var fakeTitle: String = ""
    @State private var timeRemaining = Int(GameConfig.titleTime)
    @State private var autoNext = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter a fake title")
            TextField("Title", text: $fakeTitle)
                .textFieldStyle(.roundedBorder)
            NavigationLink("Submit") {
                ChoiceView()
            }
            NavigationLink("", destination: ChoiceView(), isActive: $autoNext) {
                EmptyView()
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                autoNext = true
            }
        }
        .toolbar {
            Text("Time: \(timeRemaining)")
        }
        .navigationTitle("Fake Title")
    }
}

#Preview {
    TitleInputView()
}
