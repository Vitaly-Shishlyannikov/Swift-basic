import Foundation
import AppKit

enum Transmission: String {
    case auto = "Автоматическая"
    case manual = "Механическая"
}

// протокол Car с общими свойствами и методами
protocol Car {
    var brand: String {get}
    var windowStatus: Bool {get set}
    var transmission: Transmission {get}
    mutating func operateWindow ()
    func toBeep ()
}

// расширение протокола Car с реализацией метода открывания/закрывания окна
extension Car {
    mutating func operateWindow () {
        self.windowStatus = windowStatus ? false : true
        print("Окно \(windowStatus ? "открылось" : "закрылось")")
    }
}

// наследованный протокол EnginedCar с методом запуска двигателя
protocol EnginedCar: Car {
     func operateEngine ()
}

// протокол UseNitroProtocol с методом применения нитро
protocol UseNitroProtocol {
    func useNitro ()
}

// класс TrunkCar принимает наследованный протокол EnginedCar
class TrunkCar: EnginedCar {
    
    enum EmissionClass {
        case Euro4
        case Euro5
    }
    
    var brand: String
    var windowStatus: Bool
    var engRunning: Bool
    var transmission: Transmission
    
    // свойства только для этого класса
    var tankCapacity: Int
    var emissionClass: EmissionClass
    
    // реализация метода протокола EnginedCar
    func operateEngine () {
        self.engRunning = engRunning ? false : true
        print("Двигатель \(engRunning ? "заведен" : "заглушен")")
    }
    
    // реализация метода родительского протокола Car
    func toBeep() {
        print("БИ-БИИИИИИИП!!!")
    }
    
    init(brand: String, winwowStatus: Bool, engRunning: Bool, transmission: Transmission, tankCapacity: Int, emissionClass: EmissionClass) {
        self.brand = brand
        self.windowStatus = winwowStatus
        self.engRunning = engRunning
        self.transmission = transmission
        self.tankCapacity = tankCapacity
        self.emissionClass = emissionClass
    }
}

// расширение класса TrunkCar для реализациии стандартного протокола
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(brand), коробка \(transmission.rawValue), емкость цистерны \(tankCapacity), экологический класс \(emissionClass)"
    }
}

// класс SportCar принимает протоколы  Car, UseNitroProtocol
class SportCar: Car, UseNitroProtocol {
    
    var brand: String
    var windowStatus: Bool
    var transmission: Transmission
    
    // свойства только для этого класса
    var maxSpeed: Int
    var color: NSColor
    
    // реализация метода протокола UseNitroProtocol
    func useNitro() {
        print("Используется закись азота ВЖУХ!!!")
    }
    
    // реализация метода протокола
    func toBeep() {
        print("ПиииП!")
    }
    
    init(brand: String, winwowStatus: Bool, transmission: Transmission, maxSpeed: Int, color: NSColor) {
        self.brand = brand
        self.windowStatus = winwowStatus
        self.transmission = transmission
        self.maxSpeed = maxSpeed
        self.color = color
    }
}

// расширение класса SportCar для реализациии стандартного протокола
extension SportCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(brand), коробка \(transmission.rawValue), максимальная скорость \(maxSpeed), цвет \(color)"
    }
}

var volovoTrunk = TrunkCar(brand: "Volvo FMX", winwowStatus: true, engRunning: false, transmission: .manual, tankCapacity: 3000, emissionClass: .Euro4)

volovoTrunk.operateEngine()
volovoTrunk.operateEngine()

volovoTrunk.operateWindow()
volovoTrunk.operateWindow()

volovoTrunk.toBeep()

print(volovoTrunk)

var bmwRaceCar = SportCar(brand: "BMW M5", winwowStatus: false, transmission: .auto, maxSpeed: 250, color: .blue)

bmwRaceCar.operateWindow()
bmwRaceCar.operateWindow()

bmwRaceCar.useNitro()

bmwRaceCar.toBeep()

print(bmwRaceCar)

// нормально вывести в консоль название цвета пока не умею ;)
