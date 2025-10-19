

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PostsListView()
                .tabItem {
                    Label("Posts", systemImage: "list.bullet")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}


