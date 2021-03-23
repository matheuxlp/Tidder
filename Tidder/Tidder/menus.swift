import Foundation

func postLoop(main: MainMethods, postPosition: Int, userName: String) {
    var main: MainMethods = main
    let userName: String = userName
    
    var loopControlPost: Bool = true
    while loopControlPost == true {
        let currentPost: Post = main.allPosts[postPosition - 1]
        main.printLineClearTerminal()
        main.printPostFormated(post: currentPost, number: postPosition)
        printPostMenu()
        var loopControlPostMenu: Bool = true
        while loopControlPostMenu == true {
            let menuOption: Int = readKeyboardNumber()
            switch menuOption {
            case 0: // Exite to main loop
                loopControlPost = false
                loopControlPostMenu = false
            case 1: //Like current post
                main.allPosts = main.changeLike(option: 1, position: postPosition, array: main.allPosts)
                loopControlPostMenu = false
            case 2: // Dislike current post
                main.allPosts = main.changeLike(option: 0, position: postPosition, array: main.allPosts)
                loopControlPostMenu = false
            case 3: // Reply to current post
                main.printLineClearTerminal()
                main.allPosts[postPosition - 1].replies.append(main.createPost(username: userName))
                loopControlPostMenu = false
            case 4: // Like a Reply
                let option: Int = readPositionNumber(maxRange: currentPost.replies.count + 1)
                if option != -1 {
                    main.allPosts[postPosition - 1].replies = main.changeLike(option: 1, position: option, array: currentPost.replies)
                    loopControlPostMenu = false
                } else {
                    loopControlPostMenu = false
                }
            case 5: // Dislike a reply
                let option: Int = readPositionNumber(maxRange: currentPost.replies.count + 1)
                if option != -1 {
                    main.allPosts[postPosition - 1].replies = main.changeLike(option: 0, position: option, array: currentPost.replies)
                    loopControlPostMenu = false
                } else {
                    loopControlPostMenu = false
                }
            default:
                print("\nEnter a valid option or [0] to exit:")
            }
        }
    }
}

func mainLoop(main: MainMethods, userName: String) {
    var main: MainMethods = main
    let userName: String = userName
    
    var loopControlMain: Bool = true // Control variable for main while
    while loopControlMain == true{ // Main loop through the application
        main.printLineClearTerminal()
        printTidderArt()
        main.printAll()
        printMenu()
        var loopControlMenu: Bool = true // Control variable for menu while
        while loopControlMenu == true { // Menu loop to select an option
            let mainOption: Int = readKeyboardNumber()
            switch mainOption {
            case 0: // End loop
                loopControlMain = false
                loopControlMenu = false
            case 1: //Creat a Post
                main.printLineClearTerminal()
                print("CREATE A NEW POST")
                main.allPosts.append(main.createPost(username: userName))
                loopControlMenu = false
            case 2: //Enter a Post
                let option: Int = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.printLineClearTerminal()
                    postLoop(main: main, postPosition: option, userName: userName)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            case 3: //Like a Post
                let option: Int = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.allPosts = main.changeLike(option: 1, position: option, array: main.allPosts)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            case 4: //Dislike a Post
                let option: Int = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.allPosts = main.changeLike(option: 0, position: option, array: main.allPosts)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            default: // Unaccepted keyboard entry
                print("\nEnter a valid option or [0] to exit:")
            }
        }
    }
}
