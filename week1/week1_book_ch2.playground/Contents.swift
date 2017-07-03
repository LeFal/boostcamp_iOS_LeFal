//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"
str = "Hello, Swift"


var constStr = str
constStr = "Hello, World"

var nextYear : Int
var bodyTemp : Float
var hasPet : Bool

var arrayOfInts : [Int]
var dictionaryOfCapitalsByCountry : [String:String]

var winningLotteryNumber : Set<Int>


let number = 42
let fmStation = 91.1

var countingUp = ["one", "two"]
var nameByParkingSpace = [13: "Alice", 27: "Bob"]

nameByParkingSpace[13]
nameByParkingSpace[27]

nameByParkingSpace[1] = "Gom"

nameByParkingSpace

let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = [Float]()

let defaultBool = Bool()
let defaultNum = Int()

let number2 = 42
let meaningOfLife = String(number)
let availavleRooms = Set(countingUp)

let defaultFloat = Float() // 32 bit
let floatFromLiteral = Float(3.14)

let normalRealNum = 3.14 // Double
let doubleRealNum = Float(normalRealNum)
let floatPi : Float = 3.14 // Float

countingUp.count
emptyString.isEmpty

countingUp.append("three")


var reading1 : Float?
var reading2 : Float?
var reading3 : Float?

reading1 = 9.8
reading2 = 9.7
reading3 = 9.2

//let avgReading = (reading1! + reading2! + reading3!)/3

if let r1 = reading1,
    let r2 = reading2,
    let r3 = reading3
{
    let avgReading = (r1 + r2 + r3)/3
} else {
    let errorString = "report is nil"
    print(errorString)
}


let range = 0 ..< countingUp.count
for i in range {
    let string = countingUp[i]
}


for (i, string) in countingUp.enumerated() {
    print("\(i) and \(string)")
}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space) : \(name)"
}

enum PieType : Int {
    case Apple = 0
    case Cherry
    case Pecan
}

let name : String
let favoritePie = PieType.Apple
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"
}

let pieRawValue = PieType.Apple.rawValue

if let pieType = PieType(rawValue: pieRawValue){
    pieType
}


