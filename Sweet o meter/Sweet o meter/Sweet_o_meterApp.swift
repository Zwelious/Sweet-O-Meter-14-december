import SwiftUI

@main
struct Sweet_o_meterApp: App {
    @StateObject private var productData = ProductData()

    var body: some Scene {
        WindowGroup {
            InputPage()
                .environmentObject(productData) // Provide the ProductData instance
        }
    }
}
