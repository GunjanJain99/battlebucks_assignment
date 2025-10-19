

import SwiftUI

struct PostsListView: View {
    @EnvironmentObject var vm: PostsViewModel

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading && vm.posts.isEmpty {
                    VStack {
                        ProgressView("Loading posts...")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = vm.errorMessage, vm.posts.isEmpty {
                    VStack(spacing: 16) {
                        Text("Error: \(error)")
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await vm.fetchPosts() }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        Section {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search by title", text: $vm.query)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            }
                            .padding(.vertical, 6)
                        }

                        Section {
                            ForEach(vm.filteredPosts) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    PostRowView(post: post)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .refreshable { await vm.refresh() }
                }
            }
            .navigationTitle("Posts")
        }
        .task {
            if vm.posts.isEmpty {
                await vm.fetchPosts()
            }
        }
    }
}

struct PostRowView: View {
    @EnvironmentObject var vm: PostsViewModel
    let post: Post

    var body: some View {
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
            Button(action: {
                vm.toggleFavorite(post)
            }) {
                Image(systemName: vm.isFavorite(post) ? "heart.fill" : "heart")
                    .imageScale(.large)
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 6)
    }
}
