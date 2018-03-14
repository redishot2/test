//
//  ViewController.swift
//  HatchApp
//
//  Created by Natasha Martinez on 3/13/18.
//  Copyright © 2018 natashamartinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var denominationField: UITextField!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countDescLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide those when not in use
        self.countLabel.alpha = 0
        self.countDescLabel.alpha = 0
        
        let example0 = self.coinChange(money: 4, denominations: [1,2,3])
        print("Example 0: \(example0)")
        
        let example1 = self.coinChange(money: 10, denominations: [2,5,3,6])
        print("Example 1: \(example1)")
    }
    
    @IBAction func goPressed(_ sender: Any) {
        
        // Get what's in the labels
        guard let moneyString = self.moneyField.text else { return }
        guard let denominationString = self.denominationField.text else { return }
        
        // Convert to numbers
        guard let money = Int(moneyString) else { print("Nothing in money; returning"); return }
        let denominationStrings = denominationString.split(separator: " ")
        let denominations: [Int] = denominationStrings.flatMap { Int($0) }
        
        let answer = self.coinChange(money: money, denominations: denominations)
        
        // Updated labels
        self.countLabel.text = String(answer)
        self.countLabel.alpha = 1
        self.countDescLabel.alpha = 1
    }
    
    func coinChange(money: Int, denominations: [Int]) -> Int {
        
        // Array of length # of coins and values of 0 (starter)
        let basicRow = Array<Int>(repeating: 0, count: denominations.count)
        
        // Create a 2d array (table) of length money
        var table = Array<Array<Int>>(repeating: basicRow, count: money + 1)
        
        // First row is 1s
        for i in 0..<denominations.count {
            table[0][i] = 1
        }
        
        // Loop through table
        for i in 1...money {
            for j in 0..<denominations.count {
                
                //solutions that include coins[j]
                let x = (i - denominations[j] >= 0) ? table[i - denominations[j]][j] : 0

                //solutions that don't include coins[j]
                let y = (j >= 1) ? table[i][j-1] : 0
                
                table[i][j] = x + y
            }
        }
        
        return table[money][denominations.count - 1]
    }
}

