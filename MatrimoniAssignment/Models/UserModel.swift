import Foundation

struct UserResponse: Codable {
    let results: [UserProfile]
}

struct UserProfile: Codable, Identifiable {
    var id: UUID { UUID() }
    let userID: UniqueID?
    let name: Name?
    let dob: DOB?
    let email: String?
    let picture: Picture?

    struct Name: Codable {
        let first: String?
        let last: String?
    }

    struct DOB: Codable {
        let age: Int?
    }

    struct Picture: Codable {
        let large: String?
    }
    
    struct UniqueID: Codable {
        let value: String?
    }
}

enum CodingKeys: String, CodingKey, Codable {
    case userID = "id"
    case name
    case dob
    case email
    case picture
}
