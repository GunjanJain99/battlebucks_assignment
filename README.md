# Battlebucks Assignment

A clean SwiftUI app that fetches posts from https://jsonplaceholder.typicode.com/posts, allows searching by title, viewing details, and marking posts as favorites.  
Built with *MVVM architecture* and system UI components for iOS 17.

---

## 🧱 Requirements
- *Target iOS:* 17  
- *Xcode:* Latest stable (tested with Xcode 16+)  
- *Swift:* 5.x  
- *UI Mode:* Light only  

---

## 🚀 Features
✅ Fetch posts from API  
✅ Search posts by title (real-time filter)  
✅ View post details  
✅ Mark/unmark favorites  
✅ Dedicated Favorites tab  
✅ Loading indicator + error handling  
✅ Pull-to-refresh  
✅ Favorites persistence via UserDefaults  

---

## 🧩 Architecture
*MVVM Pattern*

| Layer | File(s) | Responsibility |
|:------|:--------|:---------------|
| Model | Post.swift | Data structure for posts |
| ViewModel | PostsViewModel.swift | Business logic, state, networking control |
| Service | NetworkService.swift | Fetching data from API |
| Views | PostsListView, PostDetailView, FavoritesView | UI presentation |

Networking is handled in NetworkService, *not* inside any view.

---

## 🛠 Setup Instructions

### 1️⃣ Clone the Repository

You can directly clone this repository and open it in Xcode:

```bash
git clone https://github.com/GunjanJain99/battlebucks_assignment.git
cd battlebucks_assignment
