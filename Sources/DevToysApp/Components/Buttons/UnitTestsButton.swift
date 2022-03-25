#if TESTING_ENABLED

import PlaygroundTester
import SwiftUI

struct UnitTestsButton {
    @State private var isTesterViewPresented = false
}

extension UnitTestsButton: View {
    var body: some View {
        Button {
            self.isTesterViewPresented = true
        } label: {
            Label("Unit Tests", systemImage: "checklist")
        }
        .sheet(isPresented: self.$isTesterViewPresented) {
            PlaygroundTesterView()
        }
    }
}

struct UnitTestsButton_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestsButton()
    }
}

#endif
