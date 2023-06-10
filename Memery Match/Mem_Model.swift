//
//  Mem_Model.swift
//  Memery Match
//
//  Created by Kairui Hu on 4/20/23.
//

import Foundation

// struct of type Node
struct Node {
    // string for emoji symbol
    let emoji: String
    // bool type for hasMatched
    var hasMatched: Bool
}
    
// create a GameBoard
class GameBoard{
    //5 rows by 4 columns
    let numRows: Int = 5
    let numCols: Int = 4
    var count = 0
    var flip1 = ""
    var flip2 = ""
    

        
    // create a 2d array of type Node
    var board: [[Node]]
    
    //initialize a randomized boad with emoji symbols
    init(){
        self.board = []
        for row in 0..<numRows{
            var rowNodes: [Node] = []
            for col in 0..<numCols{
                let randomEmoji = getRandomEmoji()
                let node = Node(emoji: randomEmoji, hasMatched: false)
                rowNodes.append(node)
            }
            self.board.append(rowNodes)
        }
    }
    
    //array of emojis(20 total emojis, 10 unique emojis done twice)
    private var emojis = ["\u{1F47E}","\u{1F916}","\u{1F63A}","\u{1F4A6}","\u{1F5A8}","\u{1F476}","\u{1F9D9}","\u{1F436}","\u{1F98D}","\u{1F401}","\u{1F47E}","\u{1F916}","\u{1F63A}","\u{1F4A6}","\u{1F5A8}","\u{1F476}","\u{1F9D9}","\u{1F436}","\u{1F98D}","\u{1F401}"]
    
    // get random emoji, then drop said emojis from array
    private func getRandomEmoji()->String{
        
        let randomIndex = Int.random(in: 0..<emojis.count)
        
        let selectedEmoji = emojis[randomIndex]
        emojis.remove(at: randomIndex)
        return selectedEmoji
    }
    
    
    /*
     asdasd
     dasd
     asddaad
     adsa
     */
    
    
    func search() -> (Int, Int, Int, Int)? {
        var indices: [(Int, Int)] = []
        for i in 0..<numRows {
            for j in 0..<numCols {
                let node = board[i][j]
                if !node.hasMatched {
                    // Search for at most two nodes with the same emoji
                    for m in i..<numRows {
                        for n in 0..<numCols {
                            if (m == i && n <= j) || board[m][n].hasMatched {
                                continue
                            }
                            if node.emoji == board[m][n].emoji {
                                indices.append((i, j))
                                indices.append((m, n))
                                if indices.count == 2 {
                                    return (indices[0].0, indices[0].1, indices[1].0, indices[1].1)
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    
    
    
    // takes a tag number and returns the row and column
    func getRowAndCol(fromTag tag: Int) -> (row: Int, col: Int) {
        // starts at column 0 ,1 ,2 ,3
        var col1: Int = tag % 4
        let row1: Int = tag / 4
        //print(row1,col1)
        if tag == 20
        {
            return (0,0)
        }
        else
        {
            return (row1, col1)
        }


    }
    
    
    
    // gets the row and col given a tag then looks at the board at said position and returns the emoji at that position
    func getEmoji(tag: Int) -> String? {
        let (row, col) = getRowAndCol(fromTag: tag)
        if row < numRows && col < numCols {
            print(board[row][col].emoji)
            return board[row][col].emoji
        } else {
            return nil
        }
    }
    func trueMatch(tag1: Int, tag2: Int){
        let (row1, col1) = getRowAndCol(fromTag: tag1)
        let (row2, col2) = getRowAndCol(fromTag: tag2)
        var node1 = board[row1][col1]
        var node2 = board[row2][col2]
        node1.hasMatched = true
        node2.hasMatched = true
    }
    

    // checks 2 tags, if the emojis on the two nodes are equal then set the nodes hasMatched to true
    func isMatch(tag1: Int, tag2: Int) -> Bool {
        // get position of tag1 & tag2
        let (row1, col1) = getRowAndCol(fromTag: tag1)
        let (row2, col2) = getRowAndCol(fromTag: tag2)
        
        // get the node on the board
        var node1 = board[row1][col1]
        var node2 = board[row2][col2]
        if node1.hasMatched || node2.hasMatched {
            // At least one of the nodes has already been matched, so it cannot be matched again
            return false
        }

        
        if node1.emoji == node2.emoji {
            // The two nodes have the same emoji and can be matched
            board[row1][col1].hasMatched = true
            board[row2][col2].hasMatched = true
            return true
            
        } else {
            // The two nodes do not have the same emoji and cannot be matched
            return false
        }
    }
    
    // check though all nodes on the board, if their hasMatched is all set to ture then game is won
    func checkForWin() -> Bool {
        for row in 0..<numRows {
            for col in 0..<numCols {
                if !board[row][col].hasMatched {
                    return false
                }
            }
        }
        return true
    }

    // print function to help with debugging
    func printBoard() {
        for row in board {
            var rowString = ""
            for node in row {
                let symbol = node.hasMatched ? "X" : node.emoji
                rowString += "\(symbol)\t"
            }
            print(rowString)
        }
    }
    
}
    
    
    


