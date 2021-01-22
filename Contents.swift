import Foundation

func checkInteger(toCheck: Int, chengeParam : Bool = false) -> Bool {
    let param = chengeParam ? 3 : 2
    if toCheck % param == 0 {
        return true
    }
    return false
}

print(checkInteger(toCheck: 4)) // определяет четное число или нет
print(checkInteger(toCheck: 5, chengeParam: true)) // определяет делится ли число без остатка на 3

print("\n")

func createList(existList : [Int] = [Int]()) -> [Int] {
    var newList : [Int] = [Int]()
    if existList.isEmpty {
        for i in 1...100 {
            newList.append(i)
        }
    } else {
        for i in existList {
            if !checkInteger(toCheck: i) && checkInteger(toCheck: i, chengeParam: true) {
                newList.append(i)
            }
        }
    }
    return newList
}

let newList : [Int] = createList()
print(newList) // Создаем новый список
print(createList(existList: newList)) // Очищаем от четных и чисел, которые не делятся на 3

