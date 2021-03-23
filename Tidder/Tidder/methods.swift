import Foundation

struct MainMethods {
    var allPosts: [Post] = []
    
    mutating func createPost(username: String) -> Post {
        var post: Post = Post(username: username)
        print("Post Title: ")
        let t: String? = readLine()
        if let title: String = t {
            post.title = title
        }
        post.text = readTextEntry()
        return post
    }
    
    func splitByLenght(textEntry: String, currentArray: [String]) -> [String]{
        var controlVar: Int = 0
        var newString: String = ""
        var newArray: [String] = currentArray
        for char in textEntry{
            controlVar += 1
            newString += String(char)
            if controlVar == 78 {
                newArray.append(newString)
                controlVar = 0
                newString = ""
            }
        }
        newArray.append(newString)
        return newArray
    }
    
    func readTextEntry() -> [String] {
        var arrayPhrases: [String] = []
        print("Enter a post: (enter ˜ to cancel)")
        while let entryText = readLine() {
            guard entryText != "˜" else {
                break
            }
            if arrayPhrases.count > 78 {
                arrayPhrases = splitByLenght(textEntry: entryText, currentArray: arrayPhrases)
            }
            arrayPhrases.append(entryText)
        }
        return arrayPhrases
    }
    
    func comparePost(p1: Post, p2: Post) -> Bool {
        if p1.likes > p2.likes{
            return true
        } else if p1.likes == p2.likes {
            if p1.date < p2.date {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    func changeLike(option: Int, position: Int, array: [Post]) -> [Post] {
        var newArray: [Post] = array
        if option == 0 { // Dislike
            if newArray[position - 1].likes != 0 {
                newArray[position - 1].likes -= 1
            }
        } else { //like
            newArray[position - 1].likes += 1
        }
        return newArray.sorted { comparePost(p1: $0, p2: $1) }
    }
    
    func retunPostText(array: [String]) -> String{
        var postText: String = "|"
        for p in array {
            postText += (p + "\n|")
        }
        return postText
    }

    func retunReplyText(array: [String], level: Int) -> String{
        var tab: String = ""
        for _ in 0...level{
            tab += "\t"
        }
        var postText: String = "\(tab)|"
        for p in array {
            postText += (p + "\n\(tab)|")
        }
        return postText
    }
    
    func differenceInDays(date: Date) -> String{ // Return difference in years, days, hour or minutes since the post creation and the current time
            let difference = Date().timeIntervalSince(date)
            if Int(difference)/86400 > 0 {
                if Int(difference)/86400/360 > 0{
                    return "\(Int(difference)/86400/360) years ago"
                } else {
                    return "\(Int(difference)/86400) days ago"
                }
            } else if Int(difference)/3600  > 0{
                return "\(Int(difference)/3600) hours ago"
            } else if Int(difference)/60 > 30{
                return "\(Int(difference)/60) mins ago"
            } else if Int(difference)/60 > 30 {
                return "30 min ago"
            } else {
                return "just now"
            }
        }
    
    func printPostFormated(post: Post, number: Int) {
        var dash: String = "\n______________________"
        for _ in 0...post.username.count{
            dash += "_"
        }
        print("\(dash)\n▸ Posted by u/\(post.username)  \(differenceInDays(date: post.date)) \n|\n|\t\(post.title) \n\(retunPostText(array: post.text)) \n|↶ Replies: \(post.replies.count)   ★ Likes: \(post.likes)   Post Number: \(number)")
        printReplyFormated(replys: post.replies, level: 1)
        }
    
    func printReplyFormated(replys: [Post], level: Int) {
        var t: String = ""
        for _ in 0...level{
            t += "\t"
        }
        if !replys.isEmpty {
            for reps in replys {
                var dash = "____________"
                for _ in 0...reps.username.count{
                    dash += "_"
                }
                print("\(t)\(dash) \n \(t)|u/\(reps.username)  \(differenceInDays(date: reps.date)) \n\(t)|\n\(t)|\t\(reps.title) \n\(retunReplyText(array: reps.text, level: level)) \n\(t)|↶ Replies: \(reps.replies.count)   ★ Likes: \(reps.likes)  Reply Number: \(Int(replys.firstIndex(where: { $0.date == reps.date }) ?? 0) + 1)")
                printReplyFormated(replys: reps.replies, level: level + 1)
            }
        }
    }
    
    func printAll() {
        var number: Int = 1
        for i in allPosts {
            printPostFormated(post: i, number: number)
            number += 1
        }
    }
    
    func printLineClearTerminal() {
        for _ in 1...20 {
            print("\n")
        }
    }
}

func readKeyboardNumber() -> Int{
    let readOptionalString: String? = readLine()
    if let readString: String = readOptionalString {
        if let readInt: Int = Int(readString) {
            return readInt
        } else {
            return -1
        }
    } else {
        return -1
    }
}

func readPositionNumber(maxRange: Int) -> Int{
    print("Enter a postion number:")
    while true {
        let number: Int = readKeyboardNumber()
        switch number {
        case 0:
            print("exiting....")
            return -1
        case 1...maxRange - 1:
            return number
        default:
            print("Invalid Option! Please enter a valid post number or [0] to exit:")
        }
    }
}


func readUserName() -> String { // Read username entry and return a string that is valid
    print("Enter your username:")
    while true{
        let keyboardEntry: String? = readLine()
        if let userName: String = keyboardEntry {
            if !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{ // Checks if string is not empty
                return userName
            } else {
                print("Invalid username! Please try again.")
            }
        } else {
            print("Invalid username! Please try again.")
        }
    }
}
