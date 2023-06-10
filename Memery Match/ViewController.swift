//
//  ViewController.swift
//  Memery Match
//
//  Created by Kairui Hu on 4/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    // initiaize gameboard
    let TheGameBoard = GameBoard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // make sure that the emojis comeout correctly in the output section
        TheGameBoard.printBoard()
        //print("getRow&col")
        //TheGameBoard.getRowAndCol(fromTag: 0)
        //print("getEmoji")
        //TheGameBoard.getEmoji(tag: 0)
        //print("getismatch")
        //TheGameBoard.isMatch(tag1: 0, tag2: 10)
        //for i in 1..<21{
        //print(i)
        
        //for i in 0..<21{
        //if let button = view.viewWithTag(i) as? UIButton {

        //    button.setTitle(TheGameBoard.getEmoji(tag: i-1), for: .normal)
        //    }
        //}
    }
    var tag1 = 0
    var tag2 = 0
    
    @IBOutlet weak var Moves_Made: UILabel!
    
    @IBOutlet weak var Moves_left: UILabel!
    
    
    
    @IBAction func click_1(_ sender: UIButton) {
        
        var new_Label: String
        var image:UIImage

        let tag = sender.tag

        
        if let button = view.viewWithTag(tag) as? UIButton {
            let title = button.title(for: .normal)
            print("Button title: \(title ?? "Unknown")")
            
            // if less then 2 cards are flipped


            
            if TheGameBoard.count != 3{

                
                // if the card has not yet been flipped
                
                if title != TheGameBoard.getEmoji(tag: tag-1) && TheGameBoard.count == 1
                {
                    // flip the card count increases by one
                    
                    button.setTitle(TheGameBoard.getEmoji(tag: tag-1), for: .normal)
                    TheGameBoard.count += 1
                    tag2 = tag
                    print(TheGameBoard.count)
                }
                
                // if the card has not yet been flipped
                if title != TheGameBoard.getEmoji(tag: tag-1) && TheGameBoard.count == 0
                {
                    // flip the card count increases by one
                    button.setTitle(TheGameBoard.getEmoji(tag: tag-1), for: .normal)
                    TheGameBoard.count += 1
                    tag1 = tag
                    print(TheGameBoard.count)
                }
                
                
                //after turning 2 over
                
                if TheGameBoard.count > 1{
                    //if both tag1 and tag2 have new values
                    if tag1 != 0 && tag2 != 0{
                        
                        // if the matching returns false
                        if TheGameBoard.isMatch(tag1: tag1-1, tag2: tag2-1) == false{
                            //clear cards and reset count to 0
                                if let button = view.viewWithTag(tag1) as? UIButton {
                                    button.setTitle("", for: .normal)
                                    TheGameBoard.count = 0
                                }
                            if let button = view.viewWithTag(tag2) as? UIButton {
                                button.setTitle("", for: .normal)
                            }
                        }
                        // else if match returns true
                        else{
                            for i in 0..<20{
                                print(TheGameBoard.board[i/4][i%4])
                            }
                            //TheGameBoard.trueMatch(tag1: tag1,tag2: tag2)
                            if let Button = view.viewWithTag(tag1) as? UIButton {
                                let newBackground = (UIImage(named: "Mr_Crab")as UIImage?)!
                                button.setBackgroundImage(newBackground, for: .normal)
                            }
                            if let Button = view.viewWithTag(tag2) as? UIButton {
                                let newBackground = (UIImage(named: "Mr_Crab")as UIImage?)!
                                button.setBackgroundImage(newBackground, for: .normal)
                            }
                            if TheGameBoard.checkForWin() == true{
                                Moves_left.text = "You Win"
                                print("You Win")
                            }
                            else
                            {
                                
                                print("not yet won")
                                
                                for i in 0..<20{
                                    print(TheGameBoard.board[i/4][i%4])
                                    
                                }
                            }
                            TheGameBoard.count = 0
                        }
                            
                    }


                }
            }

        }
        
        if let movesString = Moves_Made.text{
            var movesMade = Int(movesString)! + 1
            Moves_Made.text = String(movesMade)
        }
        
        // if button clicked has a title label
        // then assign value to new_label
        // else new label = ""
        
        
        /*
         if let label = sender.titleLabel!.text{
         new_Label = label
         }else{
         new_Label = ""
         }
         
         
         // if new_Label is empty, change label to "white"
         // and image = new image
         if new_Label != ""
         {
         image = (UIImage(named: "Mr_Crab") as UIImage?)!
         new_Label = "white"
         }
         //else if new_Label is not empty
         // new label = "Hello", and image = "theytook"
         else{
         image = (UIImage(named: "Mr_Crab") as UIImage?)!
         new_Label = "Hello" // from model
         // determine whether card gets flicked back around
         }
         
         sender.setTitle(new_Label, for: UIControl.State.normal)
         sender.setBackgroundImage(image, for: UIControl.State.normal)
         }
         
         */
        
        
    }
}
