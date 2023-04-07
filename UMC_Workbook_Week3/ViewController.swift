//
//  ViewController.swift
//  UMC_Workbook_Week3
//
//  Created by 장준모 on 2023/04/07.
//

import UIKit

class ViewController: UIViewController {

  
//    override func viewDidLoad() {
//    super.viewDidLoad()
//    // Do any additional setup after loading the view.
//}

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTHeMiddileOfTyping = false

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTHeMiddileOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTHeMiddileOfTyping = true
    }
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func perfomOpearation(_ sender: UIButton) {
        if userIsInTHeMiddileOfTyping{
            brain.setOperand(operand: displayValue)
            userIsInTHeMiddileOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle{
            brain.perfomOperation(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    
}

