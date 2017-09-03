//
//  Calculator.swift
//  Daily Note
//
//  Created by Ivan Lin on 2017/7/26.
//  Copyright © 2017 Ivan.lin. All rights reserved.
//

import UIKit

enum OperatorType {
    case Add, Minus, Multiply, Divide, Equal
}

class Calculator: NSObject {
    var m_param1 = 0.0
    var m_param2 = 0.0
    var m_operator = OperatorType.Add
    var m_bParam1Exist = false
    
    func setParam(param: Double) {
        if !m_bParam1Exist {
            m_param1 = param
        } else {
            m_param2 = param
        }
    }
    
    func setResultAsParam1(result: Double) {
        m_param1 = result
        m_param2 = 0.0
        m_bParam1Exist = false
    }
    
    func reset() {
        m_param1 = 0.0
        m_param2 = 0.0
        m_bParam1Exist = false
    }
    
    func setOperator(opt: String) {
        switch opt {
        case "+":
            m_operator = OperatorType.Add
            break
        case "-":
            m_operator = OperatorType.Minus
            break
        case "*":
            m_operator = OperatorType.Multiply
            break
        case "/":
            m_operator = OperatorType.Divide
            break
        default:
            break
        }
        m_bParam1Exist = true
    }
    
    func add()->Double {
        return m_param1 + m_param2
    }
    
    func minus()->Double {
        return m_param1 - m_param2
    }
    
    func multiply()->Double {
        return m_param1 * m_param2
    }
    
    func divide()->Double {
        if m_param1 != 0 {
            return m_param1 / m_param2
        }
        
        return 0
    }
    
    func equal()->Double {
        var result = 0.0
        switch m_operator {
        case OperatorType.Add:
            result = add()
            break
        case OperatorType.Minus:
            result = minus()
            break
        case OperatorType.Multiply:
            result = multiply()
            break
        case OperatorType.Divide:
            result = divide()
            break
        default:
            break
        }
        
        return result
    }
}
