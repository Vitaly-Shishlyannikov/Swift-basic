import Foundation
import AppKit


class Car {
   
    enum Transmission: String {
        case manual = "механическая"
        case auto = "автоматическая"
    }
    
    enum actions {
        case hookTrailer
        case unhookTrailer
        case speedUp
        case speedDown
        case useNitro
    }

    let brand: String
    var engRunning: Bool
    let color: NSColor
    let transmission: Transmission
    static var carsCount: Int = 0
// переменная для подсчета количества выпущенных автомобилей
    
// обязательный инициализатор для всех подклассов
    required init(brand: String, engRunning: Bool, color: NSColor, transmission: Transmission) {
        self.brand = brand
        self.engRunning = engRunning
        self.color = color
        self.transmission = transmission
        Car.carsCount += 1
        Car.countInfo()
    }
    
    func operate (actions: Car.actions) {
    }
    
//функция для вывода сообщения при создании нового автомобиля
    static func countInfo () {
        print("Выпущен еще 1 автомобиль. Всего выпущено  \(Car.carsCount) автомобилей.")
    }
}



class TruckCar: Car {
    
// магическое число 5 - длина тягача без прицепа
// при установке общей длины 5 прицеп отсоединяется
    
    var trailer: Bool {
        willSet  {
            if newValue == true {
                print("Прицеп установлен")
            } else {
                print("Прицеп демонтирован")
            }
        }
    }
    var trailerLength: Int
    var truckLength: Int {
        get {
            return (self.trailer ? (self.trailerLength + 5) : 5)
        }
        set {
            if newValue == 5 {
            self.trailer = false
            }
        }
    }

// в обязательном инициализаторе указываем длину прицепа 20
    
    required init(brand: String, engRunning: Bool, color: NSColor, transmission: Transmission) {
        self.trailer = true
        self.trailerLength = 20
        super.init(brand: brand, engRunning: engRunning, color: color, transmission: transmission)
    }
    init(brand: String, engRunning: Bool, color: NSColor, transmission: Transmission, trailer: Bool, trailerLength: Int) {
        self.trailer = trailer
        self.trailerLength = trailerLength
        super.init(brand: brand, engRunning: engRunning, color: color, transmission: transmission)
    }
   
    override func operate (actions: actions) {
        switch actions {
        case .hookTrailer:
            self.trailer = true
        case .unhookTrailer:
            self.trailer = false
        default:
            break
        }
    }
}

// экземпляры создаются с помощью разных инициализаторов

var kamaz = TruckCar(brand: "Камаз", engRunning: true, color: .brown, transmission: .manual)
var maz = TruckCar(brand: "МАЗ", engRunning: false, color: .black, transmission: .auto, trailer: true, trailerLength: 20)

// отсоединяем прицеп от камаза
kamaz.operate(actions: .unhookTrailer)
print("Длина без прицепа  \(kamaz.truckLength)")

// цепляем прицеп к камазу
kamaz.operate(actions: .hookTrailer)
print("Длина c прицепом \(kamaz.truckLength)")

// отсоединяем прицеп через установку общей длины (используем сеттер свойства)
kamaz.truckLength = 5
print("В данный момент прицеп \(kamaz.trailer ? "установлен" : "демонтирован")")



class SportCar: Car {
    
    var nitro: Bool
    var maxSpeed: Int
    var speed: Int

// в обязательном инициализаторе указываем наличие нитро, макс и текущую скорость
    
    required init(brand: String, engRunning: Bool, color: NSColor, transmission: Transmission) {
        self.nitro = true
        self.maxSpeed = 200
        self.speed = 0
        super.init(brand: brand, engRunning: engRunning, color: color, transmission: transmission)
    }
    
    init(brand: String, engRunning: Bool, color: NSColor, transmission: Transmission, nitro: Bool, maxSpeed: Int, speed: Int) {
        self.nitro = nitro
        self.maxSpeed = maxSpeed
        self.speed = speed
        super.init(brand: brand, engRunning: engRunning, color: color, transmission: transmission)
    }

// переписываем функцию, после каждого действия проверяем и выводим на консоль скорость
// при использовании азота проверяем наличие соответствующего оборудования
    
    override func operate(actions: actions) {
        switch actions {
            case .speedUp:
                speed += 20
                checkSpeed()
            case .speedDown:
                speed -= 20
                checkSpeed()
            case .useNitro:
                if nitro {
                speed += 100
                checkSpeed()
                } else {
                    print("На автомобиле не установлена закись азота")
                }
            default:
                break
        }
    }
    
// функция ограничивает скорость в пределах 0...maxSpeed и выводит скорость в консоль
    
    func checkSpeed(){
        if (speed > maxSpeed) {
            speed = maxSpeed
            print ("Отсечка! Скорость  \(speed)")
        } else if speed <= 0 {
            speed = 0
            print("Скорость уже равна 0")
        } else {
            print("Скорость \(speed)")
        }
    }
}

//создается экземпляр с помощью обязательного инициализатора

var skyline = SportCar(brand: "Nissan Skyline", engRunning: false, color: .black, transmission: .auto)

//скорость достигает отсечки

skyline.operate(actions: .speedUp)
skyline.operate(actions: .useNitro)
skyline.operate(actions: .useNitro)

// создается экземпляр с помощью своего инициализатора подкласса

var celica = SportCar(brand: "Toyota Celica", engRunning: true, color: .blue, transmission: .auto, nitro: false, maxSpeed: 220, speed: 0)

// автомобиль стоит, пытаемся применять нитро и тормозить

celica.operate(actions: .useNitro)
celica.operate(actions: .speedDown)
