//
//  Helper.swift
//  SudokuApp
//
//  Created by Marcus Pearce on 12/30/19.
//  Copyright © 2019 Marcus Pearce. All rights reserved.
//

import Foundation // contains things like math, print, random, stuff take for granted


// use for helper functions used to solve sudoku board
class Helper
{
    
    // return true if given number satisfies row, false otherwise
    func checkRow(board: [[Int]], row: Int, num: Int, testBoard: Bool) -> Bool
    {
        // if testing board, can be up to two instances of a number (since one is being used to check and the other is in the board itself)
        if(testBoard)
        {
            var numInstances = 0;
            for i in 0...8
            {
                if(board[row][i] == num)
                {
                    numInstances += 1;
                    if(numInstances > 1)
                    {
                        return false;
                    }
                }
                return true;
            }
        }
        
        
        
        // for testing validity of solution
        for i in 0...8
        {
            if(board[row][i] == num)
            {
                return false;
            }
        }
        return true;
    }
    
    
    
    // return true if given number satisfies col, false otherwise
    func checkCol(board: [[Int]], col: Int, num: Int, testBoard: Bool) -> Bool
    {
        // if testing board, can be up to two instances of a number (since one is being used to check and the other is in the board itself)
        if(testBoard)
        {
            var numInstances = 0;
            for i in 0...8
            {
                if(board[i][col] == num)
                {
                    numInstances = numInstances + 1;
                    
//                    print("testing")
//                    print(numInstances);
                    
                    if(numInstances > 1)
                    {
                        return false;
                    }
                }
                return true;
            }
        }
        
        
        // for testing validity of solution
        for i in 0...8
        {
            if(board[i][col] == num)
            {
                return false;
            }
        }
        return true;
    }
    
    
    
    // return true if given number satisfies box, false otherwise
        // note boxes are 3x3
    func checkBox(board: [[Int]], row: Int, col: Int, num: Int, testBoard: Bool) -> Bool
    {
        let S = 3;      // size of box
        let boxRow = row - (row % S);
        let boxCol = col - (col % S);
        
        
        // if testing board, can be up to two instances of a number (since one is being used to check and the other is in the board itself)
        if(testBoard)
        {
            var numInstances = 0;
            for i in 0...2
            {
                for j in 0...2
                {
                    if(board[i+boxRow][j+boxCol] == num)
                    {
                        numInstances += 1;
                        if(numInstances > 1)
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }
        
        
        
        // for testing validity of solution
        for i in 0...2
        {
            for j in 0...2
            {
                if(board[i+boxRow][j+boxCol] == num)
                {
                    return false;
                }
            }
        }
        
        return true;
    }
    
    
    
    // return true if given number satisfies current row, column, and box, false otherwise
    func validEntry(board: [[Int]], row: Int, col: Int, num: Int, testBoard: Bool) -> Bool
    {
        // for isValidBoard() func -> empty spaces don't matter
        if(num == 0)
        {
            return true;
        }
        
        return (checkRow(board: board,row: row,num: num, testBoard: testBoard) && checkCol(board: board,col: col,num: num, testBoard: testBoard) && checkBox(board: board,row: row,col: col,num: num, testBoard: testBoard));
    }
    
    
    
    
    
    // use backtracking algorithm -> assign a valid number to an empty cell then recursively check whether this leads to a solution
    // return true if found a solution, false otherwise
    func solve(board: inout [[Int]]) -> Bool
    {
//        // PRINT CURRENT TRACKED BOARD FOR TESTING to console
//         for i in 0...8
//         {
//             for j in 0...8
//             {
//                 print(board[i][j], terminator:"");
//             }
//             print();
//         }
//        print();
//        print();
        
        
        // look for a cell with value 0, then assign row and col to those coordinates
        var row:Int = -1;
        var col:Int = -1;
        var isSolved:Bool = true;
        
        // reset row and col to make sure go thru all vars
        for i in 0...8
        {
            for j in 0...8
            {
                // if empty, return true w/ current value of coordinates (row, col)
                if(board[i][j] == 0)
                {
                    row = i;
                    col = j;
                    isSolved = false;
                    break;
                }
            }
            if(!isSolved)
            {
                break;
            }
        }
        

        
        // BASE CASE: if there are no empty cells, return True since the board is solved
        if(isSolved)
        {
            return true;
        }
        
        
        
        // from func call findEmptyCell, row and col are updated coords of empty cell
        // iterate thru each potential num (1-9) and put valid ones into empty cell, then recursively check if that solution works (that num in that spot correct)
        for num in 1...9
        {
            // check if current number is valid to be put into current spot
            if(validEntry(board: board, row: row, col: col, num: num, testBoard: false))
            {
                // tentatively assign value to new empty cell
                board[row][col] = num;
                
                // check recursively to see if this was the correct assignment
                if(solve(board: &board))
                {
                    return true;        // yay! this was the correct assignment
                }
                
                // if was not correct assignment, make current cell empty again and try w/ next potential value
                board[row][col] = 0;
            }
        }
        
        
        // if cannot find correct solution w/ current cell, need to backtrack
        return false;
    }
    
    
    
    
    
    // MARK:- Code to check for valid Sudoku Board
    
    // returns true if sudoku board is valid, false otherwise
    func isValidBoard(board: [[Int]]) -> Bool
    {
        for i in 0...8
        {
            for j in 0...8
            {
                // if fails a condition, return false
                if(!validEntry(board: board, row: i, col: j, num: board[i][j], testBoard: true))
                {
                    return false;
                }
            }
        }
        return true;
    }
    
    
    
    
}
