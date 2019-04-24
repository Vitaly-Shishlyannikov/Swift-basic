import Foundation

// 1. Ф-ция, определяющая четность числа

func evenIdent (number: Int) -> () {
    if (number % 2 == 0) {
        print("Число \(number) четное")
    } else {
        print("Число \(number) нечетное")
    }
}
evenIdent(number: 27) // число нечетное
evenIdent(number: 8)  // число четное

// 2. Ф-ция, определяющая делимость на 3 без остатка

func division3 (number: Int) -> () {
    let remainder = (number % 3)
    if remainder == 0 {
        print("Число \(number) делится на 3 без остатка")
    } else {
        print("Остаток от деления чила \(number) на 3 равен \(remainder)")
    }
}
division3(number: 200)  // отстаток от деления равен 2
division3(number: 627)  // делится без остатка

// 3. Создать возрастающий массив из 100 чисел

var increaseArray = [Int]()
for i in 1...100 {
    increaseArray.append(i)
}

// 4.Удалить из массива все числа четные и которые делятся на 3. Для учета обоих условий использум логический оператор ИЛИ

for number in increaseArray {
    if (number % 2 == 0) || (number % 3 == 0) {
        increaseArray.remove(at: increaseArray.index(of: number)!)
    }
}
print("Массив после удаления четных чисел и чисел, делящихся на 3: \(increaseArray)")

// 5. Ф-ция для добавления чисел Фибоначчи

func fiboNumbers (array: [UInt], count:Int) -> [UInt] {
    var returnArray = array
    var a: UInt = 0
    var b: UInt = 1
    for _ in 0..<count {
        a += b
        b = a - b
        returnArray.append(a)
    }
    return returnArray
}
var fiboArray = [UInt]()
fiboArray = fiboNumbers(array: fiboArray, count: 93)
// В UInt влезло только 93 числа последовательности Фибоначчи, способа расширения диапазона значений без подключения библиотек я не нашел

// 6. Массив из 100 элементов с различными простыми числами. Получилось кривовато, но итоговый результат верный

var arraySimples = [Int]()
var p = 2
var i = 2
var n = 1000   // случайно взято число, в пределах которого точно есть 100 простых чисел

func filter(array: inout [Int]) -> [Int] {
    for i in stride(from: 2 * p, through: n, by: p) where (i % p == 0){
            if let index = array.index(of: i) {
                array.remove(at: index)
            }
    }
    return array
}

for i in 2...n {
    arraySimples.append(i)
}

for t in arraySimples {
    if t == p {
        filter(array: &arraySimples)
    } else if t > p {
        p = t
        filter(array: &arraySimples)
    }
}

for number in arraySimples where (arraySimples.index(of: number)! >= 100) {
    arraySimples.remove(at: arraySimples.index(of: number)!)
}

print(arraySimples)
print(arraySimples.count)
