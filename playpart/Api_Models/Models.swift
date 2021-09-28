import Foundation


struct User{
    var id: Int
    var first_name: String
    var last_name: String
    var email: String
    init(_ dictionary:[String: Any]){
        self.id = dictionary["id"] as? Int ?? Int()
        self.first_name = dictionary["first_name"] as? String ?? String()
        self.last_name = dictionary["last_name"] as? String ?? String()
        self.email = dictionary["email"] as? String ?? String()
    }
}
struct Meta {
    var token: String
    init(_ dictionary:[String: Any]) {
        self.token = dictionary["token"] as? String ?? String()
    }
}
struct UserModel{
    var user: User
    var meta: Meta
    init(_ dictionary:[String: Any]) {
        self.user = User(dictionary["user"] as? [String:Any] ?? [:])
        self.meta = Meta(dictionary["meta"] as? [String:Any] ?? [:])
    }
}
struct ServerResponseModel{
    var sucess: Bool
    var message: String
    init(_ dictionary:[String: Any]) {
        self.message = dictionary["message"] as? String ?? String()
        self.sucess = dictionary["sucess"] as? Bool ?? Bool()
    }
}
