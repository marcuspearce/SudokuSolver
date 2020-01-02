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
    func checkRow(board: [[Int]], row: Int, num: Int) -> Bool
    {
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
    func checkCol(board: [[Int]], col: Int, num: Int) -> Bool
    {
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
    func checkBox(board: [[Int]], row: Int, col: Int, num: Int) -> Bool
    {
        let S = 3;      // size of box
        let boxRow = row - (row % S);
        let boxCol = col - (col % S);
        
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
    func validEntry(board: [[Int]], row: Int, col: Int, num: Int) -> Bool
    {
        return (checkRow(board: board,row: row,num: num) && checkCol(board: board,col: col,num: num) && checkBox(board: board,row: row,col: col,num: num));
    }
    
    
    
    
    
    
    // use backtracking algorithm -> assign a valid number to an empty cell then recursively check whether this leads to a solution
    // return true if found a solution, false otherwise
    func solve(board: inout [[Int]]) -> Bool
    {
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
            if(validEntry(board: board, row: row, col: col, num: num))
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
    
}
