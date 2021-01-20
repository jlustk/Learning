import Cocoa
let a : Double = 4
let toPrint : String = "Дано кв уравнение x^2 - a = 0, где а = 4"
var x : Double = 0
print(toPrint)

x = sqrt((Double)(a))
if x*x - a == 0.0 {
    print("Корень уравнения найден: " + String(x))
} else {
    print("Не удалось найти корень")
}
print("\n")

let c : Double = 5
let b : Double = 9
let s : Double = (c*b) / 2
let m : Double = sqrt(pow(c,2) + pow(b,2))
let p : Double = c + b + m
print("Площадь треугольника равна \(s)")
print("Периметр треугольника равен \(p)")
print("Гипотенуза треугольника равна \(m)")



