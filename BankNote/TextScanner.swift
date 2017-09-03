//
//  TextScanner.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit

enum TextInputStatus {
    case NoInput, NumberInput, OperatorInput
}

class TextScanner: NSObject {
    var m_parentVC: NewNoteViewController?
    
    var m_display = "0"
    var m_parameter = ""
    var m_operator = ""
    var m_inputStatus = TextInputStatus.NoInput
    var m_numberLimit = -1
    
    let m_numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let m_operators = ["+", "-", "*", "/"]
    let m_dot = "."
    let m_equal = "="
    
    override init() {
        
    }
    
    func setParentVC(parent: NewNoteViewController) {
        m_parentVC = parent
    }
    
    func setResultAsParam1(result: String) {
        m_display = result
        m_parameter = result
        m_operator = ""
        m_numberLimit = -1
        m_inputStatus = TextInputStatus.NumberInput
    }
    
    func reset() {
        m_display = "0"
        m_numberLimit = -1
        m_parameter = ""
        m_operator = ""
    }
    
    func isOperator(str:String)->Bool {
        return m_operators.contains(str)
    }
    
    func isNumber(str:String)->Bool {
        return m_numbers.contains(str)
    }
    
    func getParameter()->String {
        return m_parameter
    }
    
    func inputChar(str:String)->String {
        switch m_inputStatus {
        case TextInputStatus.NoInput:
            if isNumber(str: str) {
                m_display = str
            }
            if str == m_dot {
                m_display += str
                m_numberLimit += 1
            }
            m_inputStatus = TextInputStatus.NumberInput
            break
        case TextInputStatus.NumberInput:
            if isNumber(str: str) {
                if m_display.contains(m_dot) {
                    if m_numberLimit >= 2 {
                        return m_display
                    }
                    m_numberLimit += 1
                }
                if m_display == "0" {
                    m_display = str
                }else {
                    m_display += str
                }
            }
            if str == m_dot {
                if m_display.contains(m_dot) {
                    return m_display
                }else {
                    m_display += str
                    m_numberLimit += 1
                }
            }
            if isOperator(str: str) {
                if !m_operator.isEmpty {
                    m_parentVC?.setParam2(str: m_display)
                }else {
                    m_parentVC?.setParam1(str: m_display)
                }
                m_operator = str
                m_inputStatus = TextInputStatus.OperatorInput
            }
            if str == m_equal {
                if !m_operator.isEmpty {
                    m_parentVC?.setParam2(str: m_display)
                }
            }
            break
        case TextInputStatus.OperatorInput:
            if isNumber(str: str) {
                m_display = str
                m_numberLimit = -1
                m_parentVC?.setOperator(str: m_operator)
                m_inputStatus = TextInputStatus.NumberInput
            }
            if isOperator(str: str) {
                m_operator = str
            }
            if str == m_dot {
                m_display = "0."
                m_numberLimit = 0
                m_parentVC?.setOperator(str: m_operator)
                m_inputStatus = TextInputStatus.NumberInput
            }
            break
        }
        
        return m_display
    }
}
