import Foundation

func run(main:  MainMethods) {
    printTidderArt()
    let userName: String = readUserName()
    mainLoop(main: main,userName: userName)
}





