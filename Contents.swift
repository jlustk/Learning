import UIKit
import Foundation

class UserLogin {
    var employees: [String: String] = [
        "mail1": "pass1", "mail2": "pass2", "mail3": "pass3"
    ]
    
    func checkPass(_ mail: String, _ password: String) -> Bool? {
        guard let existMail = employees[mail] else {return nil}
        return existMail == password
    }
}

var check = UserLogin()
check.checkPass("mail1", "pass111")

if let user = check.checkPass("mail1", "pass1") {
    print("answer \(user)")
}

enum LoginError: Error {
    case invalidMail
    case invalidPass
    
    var desc: String {
        switch self {
        case .invalidMail:
            return "Wrong mail address"
        case .invalidPass:
            return "Wrong password"
        }
    }
}

extension UserLogin {
    func checkPassError(_ mail: String, _ password: String) throws -> Bool? {
        guard let existMail = employees[mail] else {
            throw LoginError.invalidMail
        }
        guard existMail == password else {
            throw LoginError.invalidPass
        }
        print("Login successful!")
        return true
    }
}

let tryLogin1 = try? check.checkPassError("who", "what")
let tryLogin2 = try? check.checkPassError("mail1", "what")
let tryLogin3 = try? check.checkPassError("mail1", "pass1")

do {
    try check.checkPassError("who", "what")
} catch let error as LoginError {
    print(error.desc)
} catch {
    print(error.localizedDescription)
}
