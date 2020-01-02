//
//  ViewController.swift
//  SudokuApp
//
//  Created by Marcus Pearce on 12/29/19.
//  Copyright © 2019 Marcus Pearce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    // make array to store all tile UIButtons so can reference them later
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    
    // use below for helper functions
    var helper = Helper()
    
    
    
    @IBOutlet weak var tile01: UIButton!
    @IBOutlet weak var tile02: UIButton!
    @IBOutlet weak var tile03: UIButton!
    @IBOutlet weak var tile04: UIButton!
    @IBOutlet weak var tile05: UIButton!
    @IBOutlet weak var tile06: UIButton!
    @IBOutlet weak var tile07: UIButton!
    @IBOutlet weak var tile08: UIButton!
    @IBOutlet weak var tile09: UIButton!
    
    // BELOW CODE USED FOR CALCULATING CORRECT ITEM IN ARRAY GIVEN ROW AND COLUMN
//    let tileNum = row*9 + col;  -> i*9 + j
    
    @IBAction func pressSolveButton(_ sender: Any) {
        
//        let btnImage = UIImage(named: "1")
//        tile01.setImage(btnImage, for: UIControl.State.normal)
        
        
        
        // need to get current board depending on value (image number) of each tile -> get 2D array of entire sudoku board

        
        
        
        
        var testBoard = [
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


        
        let ifWorked = helper.solve(board: &testBoard)
        
        if (ifWorked)
        {
            print("MOM GET THE CAMERA");
        }
        
        
        // ~PRINT~ FUNC : update tiles w/ new values
        for i in 0...8
        {
            for j in 0...8
            {
                // use below to set image to image of tile w/ value named: "<value>"
                let btnImage = UIImage(named: "\(testBoard[i][j])")
                collectionOfButtons?[i*9 + j].setImage(btnImage, for: UIControl.State.normal);
            }
        }
        
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

