

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: PostsViewModel

    var body: some View {
        NavigationView {
            Group {
                if vm.favoritePosts.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.largeTitle)
                        Text("No favorites yet")
                            .font(.headline)
                        Text("Mark posts with the heart icon to see them here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(vm.favoritePosts) { post in
                            NavigationLink(destination: PostDetailView(post: post)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(post.title.capitalized)
                                            .font(.headline)
                                            .lineLimit(2)
                                        Text("User: \(post.userId)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Button(action: { vm.toggleFavorite(post) }) {
                                        Image(systemName: vm.isFavorite(post) ? "heart.fill" : "heart")
                                            .imageScale(.large)
                                    }
                                    .buttonStyle(.borderless)
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
