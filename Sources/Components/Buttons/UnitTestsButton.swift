#if TESTING_ENABLED

    @preconcurrency import PlaygroundTester
    import SwiftUI

    struct UnitTestsButton {
        @State private var isTesterViewPresented = false
    }

    extension UnitTestsButton: View {
        var body: some View {
            Button {
                PlaygroundTesterConfiguration.isTesting = true
                self.isTesterViewPresented = true
            } label: {
                Label("Unit Tests", systemImage: "checklist")
            }
            .sheet(isPresented: self.$isTesterViewPresented) {
                PlaygroundTesterWrapperView {}
            }
        }
    }

    struct UnitTestsButton_Previews: PreviewProvider {
        static var previews: some View {
            UnitTestsButton()
                .previewPresets()
        }
    }

#endif
