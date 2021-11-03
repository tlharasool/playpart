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


class VideoData
{
    let id: Int
    let name: String
    let created_at: TimeInterval
    let updated_at: TimeInterval
    let result_video_url: String
    let description: String
    let username  : String?
    var reaction: Reaction!
    
    init(_ dictionary:[String: Any]){
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.created_at = dictionary["created_at"] as? TimeInterval ?? 0
        self.updated_at = dictionary["updated_at"] as? TimeInterval ?? 0
        self.result_video_url = dictionary["result_video_url"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.reaction = Reaction((dictionary["reaction"] as? [String : Any]) ?? [:])
        self.username = dictionary["username"] as? String ?? ""
    }
}

class Reaction{
    
    let id: Int
    var reaction: Int
    let user_id : Int
    let created_at: TimeInterval
    let updated_at: TimeInterval
    var video_id : Int
    
    init(_ dictionary:[String: Any]){
        self.id = dictionary["id"] as? Int ?? 0
     
        self.created_at = dictionary["created_at"] as? TimeInterval ?? 0
        self.updated_at = dictionary["updated_at"] as? TimeInterval ?? 0
        self.video_id = dictionary["video_id"] as? Int ?? 0
        self.user_id = dictionary["user_id"] as? Int ?? 0
        self.reaction = dictionary["reaction"] as? Int ?? 0
    }

}

//struct ServerResponseModel{
//    var status: Int
//    var error: String
//    init(_ dictionary:[String: Any]) {
//        self.status = dictionary["Status"] as? Int ?? Int()
//        self.error = dictionary["Error"] as? String ?? String()
//    }
//}
