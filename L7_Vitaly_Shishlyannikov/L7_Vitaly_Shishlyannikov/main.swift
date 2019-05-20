import Foundation

struct Bus {
    var name: String
    var driver: Bool
    var fuelLevel: Int
}

// ошибки: нет такого автобуса, нет топлива, нет водителя
enum TransportDeptError: Error {
    case noThisBus
    case noEnoughFuel
    case noDriver
}

// класс - транспортный отдел, в котром есть гараж с автобусами и 2 метода поездок
class TransportDept {
    
    // гараж
    var garage = [
        "Ikarus": Bus(name: "Ikarus 250", driver: true, fuelLevel: 0),
        "PAZ": Bus(name: "PAZ 3205", driver: false, fuelLevel: 300),
        "KAMAZ": Bus(name: "KAMAZ Marco Polo", driver: true, fuelLevel: 100)
    ]
    
    // метод, возвращающий кортеж из 2 опционалов, т.к. в гараже может не быть автобуса
    // а также может быть ошибка из TransportDeptError. Далее реализуется в Error
    func driveToWork (selectedBus busName: String) -> (Bus?, TransportDeptError?) {
        guard let bus = garage[busName] else {
            return (nil, TransportDeptError.noThisBus)
        }
        guard bus.fuelLevel > 0 else {
            return (nil, TransportDeptError.noEnoughFuel)
        }
        guard bus.driver else {
            return (nil, TransportDeptError.noDriver)
        }
        return (bus, nil)
    }
    
    // метод, возвращающий исключение для дальнейшей обработки в try/catch
    func driveToVacation (selectedBus busName: String) throws -> Bus {
        guard let bus = garage[busName] else {
            throw TransportDeptError.noThisBus
        }
        guard bus.fuelLevel > 0 else {
            throw TransportDeptError.noEnoughFuel
        }
        guard  bus.driver else {
            throw TransportDeptError.noDriver
        }
        return bus
    }
}


let firstTransDept = TransportDept()

// создаем поездки на работу на каждом автобусе и обрабатываем каждую
let trip1 = firstTransDept.driveToWork(selectedBus: "Liaz")
let trip2 = firstTransDept.driveToWork(selectedBus: "PAZ")
let trip3 = firstTransDept.driveToWork(selectedBus: "Ikarus")
let trip4 = firstTransDept.driveToWork(selectedBus: "KAMAZ")

if let bus = trip1.0 {
    print("Поездка состоялась на автобусе \(bus.name)")
} else if let error = trip1.1{
    print("Произошла ошибка \(error)")
}

if let bus = trip2.0 {
    print("Поездка состоялась на автобусе \(bus.name)")
} else if let error = trip2.1{
    print("Произошла ошибка \(error)")
}

if let bus = trip3.0 {
    print("Поездка состоялась на автобусе \(bus.name)")
} else if let error = trip3.1{
    print("Произошла ошибка \(error)")
}

if let bus = trip4.0 {
    print("Поездка состоялась на автобусе \(bus.name)")
} else if let error = trip4.1{
    print("Произошла ошибка \(error)")
}

// создаем 2 поездки на отдых на разных автобусах и обрабатываем их

do {
    let tripToSea = try firstTransDept.driveToVacation(selectedBus: "LAZ")
} catch TransportDeptError.noThisBus {
    print("Нет такого автобуса")
} catch TransportDeptError.noDriver {
    print("В этом автобусе нет водителя") 
} catch TransportDeptError.noEnoughFuel {
    print("Нет топлива :-(")
} catch let error {
    print(error)
}

do {
    let tripToSea = try firstTransDept.driveToVacation(selectedBus: "Ikarus")
} catch TransportDeptError.noThisBus {
    print("Нет такого автобуса")
} catch TransportDeptError.noDriver {
    print("В этом автобусе нет водителя")
} catch TransportDeptError.noEnoughFuel {
    print("Нет топлива :-(")
} catch let error {
    print(error)
}
