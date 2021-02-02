import UIKit
import Foundation

enum engineProgram {
    case stop
    case start
}

enum doSome {
    case openWindows
    case closeWindows
    case startEngine
    case stopEngine
    case addCargo
    case updateSpeed
}

enum ans {
    case open(msg : String)
    case close(msg : String)
    case startE(msg : String)
    case stopE(msg : String)
    case tryAddCargo(msg: String)
    case newSpeed(msg: String)
    case notCoise(msg : String)
}

class Car {
    let model: String
    let year: Int
    let cargoSpace: Double
    var engine: engineProgram
    var windowsIsOpen: Bool
    
    init(model: String, year: Int, cargoSpace: Double) {
        self.model = model
        self.year = year
        self.cargoSpace = cargoSpace
        self.engine = .stop
        self.windowsIsOpen = false
    }
    
    func vehicleOperations(_ operation : doSome, _ : Double = 0.0) -> ans {
        return(.notCoise(msg: "Vehicle not choise"))
    }
}

class TrunkCar : Car {
    var fullCargoSpace: Double = 0.0
    
    init(model: String, year: Int, cargoSpace: Double, fullCargoSpace: Double) {
        self.fullCargoSpace = fullCargoSpace
        super.init(model: model, year: year, cargoSpace: cargoSpace)
    }

    override func vehicleOperations(_ operation : doSome, _ fullCargo : Double = 0.0) -> ans {
        switch operation {
        case .openWindows:
            self.windowsIsOpen = true
            return .open(msg: "Windows is open")
        case .closeWindows:
            self.windowsIsOpen = false
            return .open(msg: "Windows is close")
        case .startEngine:
            self.engine = .start
            return .startE(msg: "Engine start")
        case .stopEngine:
            self.engine = .stop
            return .stopE(msg: "Engine stop")
        case .addCargo:
            var answer: String
            if self.fullCargoSpace + fullCargo <= cargoSpace {
                self.fullCargoSpace += fullCargo
                answer = "Cargo add to vehicle, empty space \(self.cargoSpace - self.fullCargoSpace)"
            } else {
                answer = "Cargo don't add to vehicle, empty space \(self.cargoSpace - self.fullCargoSpace)"
            }
            return .tryAddCargo(msg: answer)
        case .updateSpeed:
            return .newSpeed(msg: "Not fast")
        }
    }
}

class SportCar : Car {
    var speed: UInt = 0
    
    init(model: String, year: Int, cargoSpace: Double, speed: UInt) {
        self.speed = speed
        super.init(model: model, year: year, cargoSpace: cargoSpace)
        if self.speed > 0 {
            self.engine = .start
        }
    }

    override func vehicleOperations(_ operation : doSome, _ chengeSpeed : Double = 0.0) -> ans {
        switch operation {
        case .openWindows:
            self.windowsIsOpen = true
            return .open(msg: "Windows is open")
        case .closeWindows:
            self.windowsIsOpen = false
            return .open(msg: "Windows is close")
        case .startEngine:
            self.engine = .start
            return .startE(msg: "Engine start")
        case .stopEngine:
            self.engine = .stop
            return .stopE(msg: "Engine stop")
        case .addCargo:
            return .tryAddCargo(msg: "Sport car not for uploads cargo")
        case .updateSpeed:
            self.speed = UInt(chengeSpeed)
            return .newSpeed(msg: "New speed is \(chengeSpeed)")
            
        }
    }
}

var bmw = SportCar(model: "bmw", year: 2021, cargoSpace: 10, speed: 100)
print(bmw.vehicleOperations(.updateSpeed, 140))
var volvo = TrunkCar(model: "Volvo", year: 2021, cargoSpace: 1200, fullCargoSpace: 1000)
print(volvo.vehicleOperations(.addCargo, 200))
