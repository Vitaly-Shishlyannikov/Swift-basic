import Foundation

// Уравнение вида ax2 + bx + c = 0, коэффициенты заданы в коде

let a: Double = 5  //тип Double, чтобы не округлять до целого числа sqrt(D)
let b: Double = 2
let c: Double = -3

let x1: Double
let x2: Double
let D: Double = b * b - 4 * a * c

if (D > 0) {
    x1 = -b + sqrt(D) / (2 * a)
    x2 = -b - sqrt(D) / (2 * a)
    print("Уравнение имеет 2 корня: х1 = \(x1), x2 = \(x2)")
} else if (D == 0) {
    x1 = -b / (2 * a)
    print("Уравнение имеет 1 корень:  x1 = \(x1)")
} else {
    print("Нет действительных корней")
}

//  Даны катеты треугольника. Найти площадь, периметр и гипотенузу

let catet1 = 8
let catet2 = 13

var hypotenuse = sqrt(Double(catet1*catet1 + catet2*catet2))
hypotenuse = Double(round(hypotenuse*100)/100)

let perimeter = Double(catet1) + Double(catet2) + hypotenuse

let square = Double(catet1 + catet2) / 2

print("При заданных катетах  \(catet1) и \(catet2)  гипотенуза равна \(hypotenuse), периметр равен \(perimeter), площадь равна \(square)")


// Посчитать сумму вклада через 5 лет, сумму и процент вводит пользователь
// Используем Double, т.к. при введении малентких чисел процент округляется, и итоговая сумма может не измениться


var amountTemp:String?
repeat {
    print("Введите сумму вклада в рублях")
    amountTemp = readLine()
} while (Double(amountTemp!) == nil);
var amount = Double(amountTemp!)!

var percentTemp:String?
repeat {
    print("Введите размер годового процента")
    percentTemp = readLine()
} while (Double(percentTemp!) == nil);
var percent = Double(percentTemp!)!

for _ in 1...5 {
    amount += amount * percent / 100
}
amount = Double(round(amount*100)/100)

print("Сумма вклада через 5 лет составит \(amount) р.")
