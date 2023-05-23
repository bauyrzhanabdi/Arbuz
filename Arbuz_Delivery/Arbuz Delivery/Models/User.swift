import Foundation

struct Address: Codable {
    var city: String
    var street: String
    var apartment: String
}

enum Subscription: Int, Codable {
    case onemonth = 1
    case sixmonth = 6
    case year = 12
}

class User: Codable {
    var name: String?
    var surname: String?
    var username: String?
    var password: String?
    var address: Address?
    var phone: String?
    var subscription: Subscription?
    
    
    init(name: String? = nil, surname: String? = nil, username: String? = nil, password: String? = nil, address: Address? = nil, phone: String? = nil, subscription: Subscription? = nil) {
        self.name = name
        self.surname = surname
        self.username = username
        self.password = password
        self.address = address
        self.phone = phone
        self.subscription = subscription
    }
}
