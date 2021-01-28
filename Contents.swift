import Foundation

enum engineProgram {
    case stop
    case start
}

struct SportCar {
    let model: String
    let year: Int
    let cargoSpace: Double
    var engine: engineProgram
    var windowsIsOpen: Bool
    private var fullCargoSpace: Double
    
    init(model: String, year: Int, cargoSpace: Double) {
        self.model = model
        self.year = year
        self.cargoSpace = cargoSpace
        self.engine = .stop
        self.windowsIsOpen = false
        self.fullCargoSpace = 0.0
    }
    
    enum testCase : String {
        case checkWindows = "Try to open or close windows"
        case checkEngin = "Engine start program"
    }

    let testEngine = testCase(rawValue: "Engine start program")
    enum ans {
        case openWindow(msg : String, toDo: Bool)
        case closeWindow(msg : String, toDo: Bool)
        case startEngine(msg : String)
        case stopEngine(msg : String)
    }

    func testing(_ count : testCase) -> ans {
        switch count {
        case .checkWindows:
            if self.windowsIsOpen {
                return .openWindow(msg: "Windows is open", toDo: true)
            } else {
                return .closeWindow(msg: "Windows is close", toDo: false)
            }
        case .checkEngin:
            if self.engine == .start {
                return .startEngine(msg: "Engine start")
            } else {
                return .stopEngine(msg: "Engine stop")
            }
        }
    }

    func getCargoSpace() {
        print("empty - \(cargoSpace - fullCargoSpace)")
    }
    
    mutating func addCargo(_ space : Double) {
        if self.fullCargoSpace + space <= cargoSpace {
            self.fullCargoSpace += space
        } else {
            print("Sorry, not enough space in the trunk, empty - \(cargoSpace - fullCargoSpace)")
        }
    }
}

var bmw = SportCar(model: "BMW", year: 2021, cargoSpace: 160)

bmw.testing(.checkEngin)
bmw.engine = .start
bmw.testing(.checkEngin)
bmw.testing(.checkWindows)
bmw.windowsIsOpen = true
bmw.testing(.checkWindows)
bmw.addCargo(12)
bmw.addCargo(28)
bmw.getCargoSpace()
bmw.addCargo(130)

var gtr = SportCar(model: "Nissan GTR", year: 2021, cargoSpace: 120)
gtr.addCargo(130)

struct TrunkCar {
    let model: String
    let year: Int
    let cargoSpace: Double
    var engine: engineProgram
    var windowsIsOpen: Bool
    private var fullCargoSpace: Double
    
    init(model: String, year: Int, cargoSpace: Double) {
        self.model = model
        self.year = year
        self.cargoSpace = cargoSpace
        self.engine = .stop
        self.windowsIsOpen = false
        self.fullCargoSpace = 0.0
    }
    
    enum doSome {
        case openWindows
        case closeWindows
        case startEngine
        case stopEngine
    }
    
    enum ans {
        case open(msg : String)
        case close(msg : String)
        case startE(msg : String)
        case stopE(msg : String)
    }

    mutating func testing(_ count : doSome) -> ans {
        switch count {
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
        }
    }
    
    func getCargoSpace() {
        print("empty - \(cargoSpace - fullCargoSpace)")
    }
    
    mutating func addCargo(_ space : Double) {
        if self.fullCargoSpace + space <= cargoSpace {
            self.fullCargoSpace += space
        } else {
            print("Sorry, not enough space in the trunk, empty - \(cargoSpace - fullCargoSpace)")
        }
    }
}

var volvo = TrunkCar(model: "Volvo", year: 2021, cargoSpace: 3000)

volvo.testing(.openWindows)
volvo.testing(.closeWindows)
volvo.testing(.startEngine)
volvo.testing(.stopEngine)
volvo.addCargo(2000)
volvo.addCargo(800)
volvo.getCargoSpace()
volvo.addCargo(1000)
