import SwiftUI

struct TitleInputView: View {
    @State private var fakeTitle: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter a fake title")
            TextField("Title", text: $fakeTitle)
                .textFieldStyle(.roundedBorder)
            NavigationLink("Submit") {
                ChoiceView()
            }
        }
        .padding()
        .navigationTitle("Fake Title")
    }
}

#Preview {
    TitleInputView()
}
