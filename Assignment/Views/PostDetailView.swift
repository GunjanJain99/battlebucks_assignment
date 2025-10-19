

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var vm: PostsViewModel
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title.capitalized)
                    .font(.title)
                    .bold()
                Text(post.body)
                    .font(.body)

                HStack {
                    Spacer()
                    Button(action: {
                        vm.toggleFavorite(post)
                    }) {
                        Label(vm.isFavorite(post) ? "Unfavorite" : "Favorite",
                              systemImage: vm.isFavorite(post) ? "heart.fill" : "heart")
                            .font(.headline)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}
