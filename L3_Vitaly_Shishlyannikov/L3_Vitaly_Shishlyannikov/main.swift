import Foundation
import AppKit

enum Transmission: String {
    case manual = "механическая"
    case auto = "автоматическая"
}

enum actions1 {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case load(volume: Int)
    case unload(volume: Int)
}

struct Motorcar {
    let brand: String
    let carYear: Int
    let lugCapacity: Int
    var engRunning: Bool
    var windowsCondition: Bool
    var filledLugVolume: Int
    let Color: NSColor
    let transmission: Transmission
    
    mutating func operate ( actionsList: actions1) {
        switch actionsList {
            case .startEngine:
                self.engRunning = true
            case .stopEngine:
                self.engRunning = false
            case.openWindows:
                if windowsCondition == false {
                    self.windowsCondition = true
                    print("Окна открылись")
                } else {
                    print("Окна уже открыты")
                }
            case .closeWindows:
                if windowsCondition == true {
                    self.windowsCondition = false
                    print("Окна закрылись")
                } else {
                    print("Окна уже закрыты")
                }
            case .load(let volume):
                self.filledLugVolume += volume
            case .unload(let volume):
                self.filledLugVolume -= volume
        }
    }
}

// у экземляра ford случайное положение окон при инициализации

var ford = Motorcar(brand: "Ford", carYear: 1995, lugCapacity: 300, engRunning: true, windowsCondition: (arc4random_uniform(2) == 0), filledLugVolume: 0, Color: .blue, transmission: .auto)

ford.operate(actionsList: actions1.closeWindows)
ford.operate(actionsList: actions1.load(volume: 200))
print("Автомобиль марки \(ford.brand), \(ford.carYear) года выпуска, коробка \(ford.transmission.rawValue), окна \(ford.windowsCondition ? "открыты" : "закрыты"), занятый объём багажника \(ford.filledLugVolume)")


struct Truck {
    let brand: String
    let carYear: Int
    let lugCapacity: Int
    var engRunning: Bool {
        willSet {
            if newValue == true {
                print("Двигатель сейчас запустится")
            } else {
                print("Двигатель сейчас заглохнет")
            }
        }
    }
    var windowsCondition: Bool
    var filledLugVolume: Int {
        didSet {
            if (filledLugVolume > oldValue) {
                print("В кузов загрузили груз объёмом \(filledLugVolume - oldValue)")
            } else {
                print("Из кузова выгрузили груз объёмом \(oldValue - filledLugVolume)")
            }
        }
    }
    let Color: NSColor
    let transmission: Transmission
    
    mutating func operate ( actionsList: actions1) {
        switch actionsList {
        case .startEngine:
            self.engRunning = true
        case .stopEngine:
            self.engRunning = false
        case.openWindows:
            self.windowsCondition = true
        case .closeWindows:
            self.windowsCondition = false
        case .load(let volume):
            self.filledLugVolume += volume
        case .unload(let volume):
            self.filledLugVolume -= volume
        }
    }
}

var manTruck = Truck(brand: "MAN" , carYear: 2015, lugCapacity: 5000, engRunning: false, windowsCondition: false, filledLugVolume: 0, Color: .black, transmission: .manual)

// у грузовика в консоли отслеживается загрузка и разгрузка

manTruck.operate(actionsList: .openWindows)
manTruck.operate(actionsList: .startEngine)
manTruck.operate(actionsList: .load(volume: 1000))
manTruck.operate(actionsList: .unload(volume: 343))

print("Грузовик марки \(manTruck.brand), \(manTruck.carYear) года выпуска, коробка \(manTruck.transmission.rawValue), двигатель \(manTruck.engRunning ? "заведен" : "заглушен"), занятый объём в кузове \(manTruck.filledLugVolume)")


