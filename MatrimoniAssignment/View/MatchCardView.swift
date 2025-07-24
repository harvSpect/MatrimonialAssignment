import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    @ObservedObject var viewModel: MatchViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        HStack {
                            WebImage(url: URL(string: user.imageUrl ?? ""))
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                                    .font(.headline)
                                Text("Age: \(user.age)")
                                Text(user.email ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }

                        if user.status == "Pending" {
                            HStack {
                                Button("Accept") {
                                    viewModel.accept(user)
                                }.buttonStyle(.borderedProminent)

                                Button("Decline") {
                                    viewModel.decline(user)
                                }.buttonStyle(.bordered)
                            }
                        } else {
                            Text("Member \(user.status ?? "")")
                                .font(.subheadline)
                                .foregroundColor(user.status == "Accepted" ? .green : .red)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("MatchMate")
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
