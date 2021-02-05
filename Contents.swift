import UIKit
import Foundation

enum countSetings {
    case login
    case logout
}

protocol Screen {
    var memory: Int {get set}
}

class ScreenMenu: Screen {
    var memory: Int
    var settings: countSetings
    var background: String
    
    init(settings: countSetings, background: String, memory: Int) {
        self.settings = settings
        self.background = background
        self.memory = memory
    }
}

class ScreenImage: Screen {
    var memory: Int
    var imageName: String
    var background: String
    
    init(imageName: String, memory: Int) {
        self.imageName = imageName
        self.background = "blue"
        self.memory = memory
    }
}

struct ScreenSet<T: Screen> {
    var openScreen: [T] = []
    
    mutating func push(_ screen: T) {
        openScreen.append(screen)
    }
    
    mutating func pop() -> T? {
        guard openScreen.count > 0 else {
            return nil
        }
        return openScreen.removeLast()
    }
}

extension ScreenSet {
    subscript(indexces: Int...) -> Int {
        var total = 0
        for i in indexces where i >= 0 && i < self.openScreen.count {
            total += self.openScreen[i].memory
        }
        return total
    }
}

let useMinMemory: (Int, Int) -> Bool = {
    (i: Int, j: Int) -> Bool in return i < j
}

func findMin(obj: ScreenSet<ScreenImage>, predicate: (Int, Int) -> Bool) -> Int {
    var minUse: Int = 0
    let len = obj.openScreen.count - 1
    for i in (0...len) {
        if minUse == 0 {
            minUse = obj[i]
        } else if predicate(obj[i], minUse) {
            minUse = obj[i]
        }
    }
    return minUse
}

var menu = ScreenSet<ScreenMenu>()
var image = ScreenSet<ScreenImage>()

menu.push(ScreenMenu(settings: .login, background: "green", memory: 220))
image.push(ScreenImage(imageName: "first", memory: 10))
image.push(ScreenImage(imageName: "two", memory: 23))
image.push(ScreenImage(imageName: "three", memory: 15))
menu.push(ScreenMenu(settings: .logout, background: "red", memory: 40))

image[0]
image[1]
image[2]
image[3]
image.openScreen.count
useMinMemory(image[0], image[1])
findMin(obj: image, predicate: useMinMemory)

image.pop()?.imageName
image.pop()?.imageName
image.pop()?.imageName
menu.pop()?.background
menu.pop()?.background
menu.pop()?.background
