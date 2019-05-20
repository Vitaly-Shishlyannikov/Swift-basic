import Foundation

// очередь походит для работы с числовыми типами данных
// протокол Numeric позволяет производить арифметические действия
struct Queue<T: Numeric> {
    var list:[T] = []
    
    // метод добавления элементов в конец очереди
    mutating func enqueue (_ element: T) {
        list.append(element)
    }
    
    // метод удаления элементов из начала очереди
    mutating func dequeue() {
        if !list.isEmpty {
            list.removeFirst()
        } else {
            print("Очередь уже пуста")
        }
    }
    
    // метод отбора элементов по условию, аргумент - замыкание типа (T) -> Bool
    func filter(condition: (T) -> Bool) -> [T] {
        var returnlist = [T]()
        for element in list {
            if condition (element) {
                returnlist.append(element)
            }
        }
        return returnlist
    }
    
    // метод типа (Int) -> (T) -> T умножает элемент с индексом index на число,
    // которое передается в замыкание
    func power (index : Int) -> (T) -> T {
        return {return self.list[index] * $0}
    }
    
    // сабскрипт возвращает элемент по индексу, возвращает nil при отсутствии индекса
    subscript (index: Int) -> (T?) {
        if index < self.list.count {
        return list[index]
        } else {
            return nil
        }
    }
}

// очередь из чисел Int
var queue = Queue<Int>()
queue.enqueue(11)  //добавляем элементы
queue.enqueue(12)
queue.enqueue(16)
queue.enqueue(18)
queue.dequeue()    // удаляем первый элемент

print(queue.list)

// выбираем элементы, которые делятся на 3 без остатка
var delTwoThree = queue.filter(condition: {$0 % 3 == 0})
print(delTwoThree)

// умножаем элемент с индексом 2 на разные числа
print(queue.power(index: 2)(3))
var powIndexTwo = queue.power(index: 2)
print(powIndexTwo(13))
print(powIndexTwo(17))

// получаем элементы по индексу
print(queue[1])
print(queue[33])


//  очередь из элементов типа Double
var queueDouble = Queue<Double>()
queueDouble.enqueue(2.4)
queueDouble.enqueue(2.2)
queueDouble.enqueue(2.4)
queueDouble.enqueue(2.6)
queueDouble.dequeue()


// применяем различные методы

print(queueDouble.list)

print(queueDouble.filter(condition: {$0 == 2.2}))

print(queueDouble.power(index: 1)(45.2))

print(queueDouble[2])
print(queueDouble[13])

