import UIKit

var greeting = "Hello, playground"



let userName = "Christopher Nolan"
let userIsPremium = false
let userIsNew = false

func getUserName()->String{
    return userName
}


func getUserInfo() -> (String,Bool,Bool){
    return (userName, userIsPremium, userIsNew)
}



let userData = getUserInfo()

print(userData.0)
print(userData.1)
print(userData.2)


func getUserInfo2()->(name:String, isPremium:Bool, isNew:Bool){
    return (userName, userIsPremium, userIsNew)
}


let userData2 = getUserInfo2()


print(userData2.name)
print(userData2.isPremium)
print(userData2.isNew)

