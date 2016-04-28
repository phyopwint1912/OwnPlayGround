//
//  CalculatorViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 26/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet private weak var resultCalculate: UILabel!
    private var userInMiddleTyping = false
    @IBAction private func touchDigit(sender: UIButton) {
        let textDigit = sender.currentTitle!
        if(userInMiddleTyping) {
            let resultText = resultCalculate.text
            resultCalculate.text = textDigit + resultText!
        }
        else {
            resultCalculate.text = textDigit
        }
        userInMiddleTyping = true
    }
    private var brain = Calculation()
    private var displayValue: Double {
        get {
            return Double(resultCalculate.text!)!
        }
        set {
            resultCalculate.text = String(newValue)
        }
    }
    @IBAction private func performOperation(sender: UIButton) {
        if userInMiddleTyping {
            brain.setOperand(displayValue)
            userInMiddleTyping = false
        }
        let mathematicSymbol = sender.currentTitle!
        if mathematicSymbol != "" {
            brain.performOperation(mathematicSymbol)
        }
        displayValue = brain.result
    }
}
