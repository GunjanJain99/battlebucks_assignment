


import Foundation
import Combine

@MainActor
final class PostsViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published var query: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var favoriteIDs: Set<Int> = []

    private var cancellables = Set<AnyCancellable>()
    private let favoritesKey = "favoritePostIDs_v1"

    init() {
        loadFavorites()
        $query
            .removeDuplicates()
            .debounce(for: .milliseconds(150), scheduler: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
    }

    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        await withCheckedContinuation { cont in
            NetworkService.shared.fetchPosts { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.isLoading = false
                    switch result {
                    case .success(let posts):
                        self.posts = posts
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                    cont.resume()
                }
            }
        }
    }

    func refresh() async {
        await fetchPosts()
    }

    var filteredPosts: [Post] {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return posts
        }
        let lower = query.lowercased()
        return posts.filter { $0.title.lowercased().contains(lower) }
    }

    func isFavorite(_ post: Post) -> Bool {
        favoriteIDs.contains(post.id)
    }

    func toggleFavorite(_ post: Post) {
        if favoriteIDs.contains(post.id) {
            favoriteIDs.remove(post.id)
        } else {
            favoriteIDs.insert(post.id)
        }
        saveFavorites()
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.object(forKey: favoritesKey) as? [Int] {
            favoriteIDs = Set(data)
        }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }

    var favoritePosts: [Post] {
        posts.filter { favoriteIDs.contains($0.id) }
    }
}
