//
//  ViewController.swift
//  SudokuApp
//
//  Created by Marcus Pearce on 12/29/19.
//  Copyright © 2019 Marcus Pearce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    
    // make array to store all tile UIButtons so can reference them later
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    // use below for helper functions
    var helper = Helper();
    
    // used for selecting new tile
    var tileVal = 0;
    
    // board variable to keep track of values
    var board = [
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0]
    ];
    
    
    
    
    // BELOW CODE USED FOR CALCULATING CORRECT ITEM IN ARRAY GIVEN ROW AND COLUMN
//    let tileNum = row*9 + col;  -> i*9 + j
    
    @IBAction func pressSolveButton(_ sender: Any) {
        
        // PRINT CURRENT TRACKED BOARD FOR TESTING to console
        for i in 0...8
        {
            for j in 0...8
            {
                print(board[i][j], terminator:"");
            }
            print();
        }
                
        
        
//        var testBoard = [
//            [0,0,0,2,6,0,7,0,1],
//            [6,8,0,0,7,0,0,9,0],
//            [1,9,0,0,0,4,5,0,0],
//            [8,2,0,1,0,0,0,4,0],
//            [0,0,4,6,0,2,9,0,0],
//            [0,5,0,0,0,3,0,2,8],
//            [0,0,9,3,0,0,0,7,4],
//            [0,4,0,0,5,0,0,3,6],
//            [7,0,3,0,1,8,0,0,0]
//        ];
        
        
        // check that input board is valid
        let isValidBoard = helper.isValidBoard(board: board);
        
        print("isValidBoard: \(isValidBoard)");
        
        if(!isValidBoard)
        {
            feedbackLabel.text = "No Solution :( Check your input!";
            return;     // don't output anything if failed
        }
        


        // logic to solve sudoku board in Helper class
        let ifWorked = helper.solve(board: &board);
        
        print(ifWorked);
        
        // if could not find a solution
        if (!ifWorked)
        {
            print("made it");
            feedbackLabel.text = "No Solution :( Check your input!";
            return;     // don't output anything if failed
        }
        
        
        // ~PRINT~ FUNC : update tiles w/ new values
        for i in 0...8
        {
            for j in 0...8
            {
                // use below to set image to image of tile w/ value named: "<value>"
                let btnImage = UIImage(named: "\(board[i][j])")
                collectionOfButtons?[i*9 + j].setImage(btnImage, for: UIControl.State.normal);
            }
        }
        
        
        
    }
    
    
    
    
    // Load sample sudoku board
    @IBAction func pressSampleButton(_ sender: Any) {
        
        let sampleBoard = [
            [0,0,0,2,6,0,7,0,1],
            [6,8,0,0,7,0,0,9,0],
            [1,9,0,0,0,4,5,0,0],
            [8,2,0,1,0,0,0,4,0],
            [0,0,4,6,0,2,9,0,0],
            [0,5,0,0,0,3,0,2,8],
            [0,0,9,3,0,0,0,7,4],
            [0,4,0,0,5,0,0,3,6],
            [7,0,3,0,1,8,0,0,0]
        ];
        
        // set global board variable to sampleBoard values
        for i in 0...8
        {
            for j in 0...8
            {
                board[i][j] = sampleBoard[i][j];
            }
        }
        
        
        // ~PRINT~ FUNC : update tiles w/ new values
        for i in 0...8
        {
            for j in 0...8
            {
                // use below to set image to image of tile w/ value named: "<value>"
                let btnImage = UIImage(named: "\(board[i][j])")
                collectionOfButtons?[i*9 + j].setImage(btnImage, for: UIControl.State.normal);
            }
        }
        
    }
    
    
    // reset all tiles to blank
    @IBAction func pressResetButton(_ sender: Any) {
        
        // reset global board var to all 0s
        for i in 0...8
        {
            for j in 0...8
            {
                board[i][j] = 0;
            }
        }
        
        // ~PRINT~ FUNC : update tiles w/ new values
        for i in 0...8
        {
            for j in 0...8
            {
                // use below to set image to image of tile w/ value named: "<value>"
                let btnImage = UIImage(named: "0")
                collectionOfButtons?[i*9 + j].setImage(btnImage, for: UIControl.State.normal);
            }
        }
        
    }
    
    
    
    
    // MARK:- SELECT TILE VALUE (global var tileVal) TO CREATE CUSTOM BOARD


    // if pressed tileSelector button, set global var tileVal to given value (the button pressed)
        // note: can drag multiple buttons to the same function
    @IBAction func pressTileSelectorButton(_ sender: Any) {
        // note: tileSelector tags are the (value + 100)
        tileVal = (sender as AnyObject).tag - 100;
    }
    
    
   
    
    
   // MARK:- SELECT INDIVIDUAL TILES AND SET THEIR TILE VALUES + IMAGES

    
    // after pressing given tile, change its value to current tileVal
    @IBAction func pressTile(_ sender: Any) {
        
        // set image of current tile to tileVal
        let btnImage = UIImage(named: "\(tileVal)")
        (sender as AnyObject).setImage(btnImage, for: UIControl.State.normal);
        
        
        // store new value of current tile to global board var
        
        // note: each tag for tile is (row*9 + col + 1)
        let tappedTileTag = (sender as AnyObject).tag - 1;
        
        let row = tappedTileTag / 9;
        let col = tappedTileTag % 9;
        
        
        board[row][col] = tileVal;
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

