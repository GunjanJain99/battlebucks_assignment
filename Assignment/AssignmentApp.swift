

import SwiftUI

@main
struct AssignmentApp: App {
    @StateObject private var postsVM = PostsViewModel()

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(postsVM)
                    .preferredColorScheme(.light)
            }
        }
}
