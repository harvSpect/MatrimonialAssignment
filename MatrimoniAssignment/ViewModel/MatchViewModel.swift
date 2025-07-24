import Foundation
import CoreData
import Combine

class MatchViewModel: ObservableObject {
    @Published var users: [CachedUser] = []
    private let context = PersistenceController.shared.container.viewContext

    func fetchUsers() {
        if !NetworkMonitor.shared.isConnected {
            loadCachedUsers()
            return
        }

        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                self?.loadCachedUsers()
                return
            }
            do {
                let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.cacheUsers(decoded.results)
                    self?.loadCachedUsers()
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    func accept(_ user: CachedUser) {
        updateStatus(user, to: "Accepted")
    }

    func decline(_ user: CachedUser) {
        updateStatus(user, to: "Declined")
    }

    private func updateStatus(_ user: CachedUser, to status: String) {
        user.status = status
        try? context.save()
        loadCachedUsers()
    }

    private func cacheUsers(_ profiles: [UserProfile]) {
        for profile in profiles {
            let entity = CachedUser(context: context)
            entity.firstName = profile.name?.first ?? "NA"
            entity.lastName = profile.name?.last ?? "NA"
            entity.age = Int16(profile.dob?.age ?? 0)
            entity.email = profile.email ?? "NA"
            entity.imageUrl = profile.picture?.large ?? "NA"
            entity.value = profile.userID?.value ?? "NA"
            entity.userId = UUID()
            entity.status = "Pending"
        }
        do {
            try context.save()
        } catch {
            print("failed to save the data")
        }
    }

    private func loadCachedUsers() {
        let request: NSFetchRequest<CachedUser> = CachedUser.fetchRequest()
        do {
            let result = try context.fetch(request)
            print("### Add data")
            DispatchQueue.main.async {
                self.users = result
            }
        } catch {
            print("### Failed to fetch users: \(error.localizedDescription)")
        }
    }
}
