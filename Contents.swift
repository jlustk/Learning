import UIKit
import Foundation

enum engineProgram {
    case stop
    case start
}

protocol CarOperation {
    var cargoSpace: Double {get}
    var fullCargoSpace: Double {get set}
    var engine: engineProgram {get set}
    var windowsIsOpen: Bool {get set}
    mutating func openWindows(_ operation : Bool) -> Bool
    func startEngine(_ operation : engineProgram) -> engineProgram
}

extension CarOperation {
    func getSpace(_ add: Double) -> Bool {
        if fullCargoSpace + add <= cargoSpace {
            return true
        } else {
            return false
        }
    }
    
    mutating func openWindows(_ operation : Bool) -> Bool {
        print("extention super class")
        if operation {
            self.windowsIsOpen = true
        } else {
            self.windowsIsOpen = false
        }
        print(windowsIsOpen)
        return windowsIsOpen
        }
}

class Car: CarOperation {
    let model: String
    let year: Int
    let cargoSpace: Double
    var engine: engineProgram
    var windowsIsOpen: Bool
    var fullCargoSpace: Double

    init(model: String, year: Int, cargoSpace: Double) {
        self.model = model
        self.year = year
        self.cargoSpace = cargoSpace
        self.engine = .stop
        self.windowsIsOpen = false
        self.fullCargoSpace = 0.0
    }

    func startEngine(_ operation : engineProgram) -> engineProgram {
        self.engine = operation
        return self.engine
    }
}

var bmw1 = Car(model: "BMW", year: 2021, cargoSpace: 100)
print(bmw1.startEngine(.start))
print(bmw1.openWindows(true))
print(bmw1.getSpace(120))

class TrunkCar : Car {
    var trailer: Bool
    var trailerSpace: Double
    var fullTrailerSpace: Double

    init(model: String, year: Int, cargoSpace: Double, fullCargoSpace: Double) {
        self.trailer = false
        self.trailerSpace = 0.0
        self.fullTrailerSpace = 0.0
        super.init(model: model, year: year, cargoSpace: cargoSpace)
        self.fullCargoSpace = fullCargoSpace
    }
    
    func checkTrailer (_ add: Double) -> String {
        if fullTrailerSpace + add >= trailerSpace {
            return "We ran out of free space! We cannot load even using a trailer"
        } else {
            fullTrailerSpace += add
            return "Cargo loads, free space \(trailerSpace - fullTrailerSpace)"
        }
    }
    
    func fullTrailer (_ add: Double) -> String {
        if !trailer {
            trailer = true
            trailerSpace = cargoSpace
        }
        let answer: String = checkTrailer(add)
        return answer
    }

    func load (_ add: Double) {
        if self.getSpace(add) {
            print(self.fullCargoSpace + add)
            self.fullCargoSpace += add
        } else {
            print(self.fullTrailer(add))
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Trailer connected - \(trailer)"
    }
}

class SportCar : Car {
    var speed: UInt = 0 {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
    }

    init(model: String, year: Int, cargoSpace: Double, speed: UInt) {
        self.speed = speed
        super.init(model: model, year: year, cargoSpace: cargoSpace)
        if self.speed > 0 {
            self.engine = .start
        }
    }
    
    func updateSpeed (_ new: UInt) {
        self.speed += new
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Now our speed is \(speed)"
    }
}

var bmw = SportCar(model: "bmw", year: 2021, cargoSpace: 10, speed: 10)
print(bmw.description)
bmw.updateSpeed(10)
print(bmw.description)
bmw.updateSpeed(20)
print(bmw)
var volvo = TrunkCar(model: "Volvo", year: 2021, cargoSpace: 1200, fullCargoSpace: 1000)
print(volvo.cargoSpace, volvo.fullCargoSpace)
volvo.load(200)
print(volvo)
volvo.load(1100)
print(volvo)
volvo.openWindows(true)
bmw.openWindows(true)
