//
//  CalcsButtonsView.swift
//  Calculator
//
//  Created by Michael Knych on 4/22/24.
//

import SwiftUI

struct CalcButtonModel: Identifiable {
  let id = UUID()
  let calcButton: CalcButton
  var color: Color = .foregroundDigits
}

struct RowOfCalcButtonsModel: Identifiable {
  let id = UUID()
  let row: [CalcButtonModel]
}

struct CalcsButtonsView: View {
  @Binding var currentComputation: String
  @Binding var mainResult: String
  
  let buttonData: [RowOfCalcButtonsModel] = [
    RowOfCalcButtonsModel(row: [
      CalcButtonModel(
        calcButton: .clear,
        color: .forergroundTopButtons),
      CalcButtonModel(
        calcButton: .negative,
        color: .forergroundTopButtons),
      CalcButtonModel(
        calcButton: .percent,
        color: .forergroundTopButtons),
      CalcButtonModel(
        calcButton: .divide,
        color: .foregroundRightButtons)
    ]),
    RowOfCalcButtonsModel(row: [
      CalcButtonModel(
        calcButton: .seven),
      CalcButtonModel(
        calcButton: .eight),
      CalcButtonModel(
        calcButton: .nine),
      CalcButtonModel(
        calcButton: .multiply,
        color: .foregroundRightButtons)
    ]),
    RowOfCalcButtonsModel(row: [
      CalcButtonModel(
        calcButton: .four),
      CalcButtonModel(
        calcButton: .five),
      CalcButtonModel(
        calcButton: .six),
      CalcButtonModel(
        calcButton: .subtract,
        color: .foregroundRightButtons)
    ]),
    RowOfCalcButtonsModel(row: [
      CalcButtonModel(
        calcButton: .one),
      CalcButtonModel(
        calcButton: .two),
      CalcButtonModel(
        calcButton: .three),
      CalcButtonModel(
        calcButton: .add,
        color: .foregroundRightButtons)
    ]),
    RowOfCalcButtonsModel(row: [
      CalcButtonModel(
        calcButton: .undo),
      CalcButtonModel(
        calcButton: .zero),
      CalcButtonModel(
        calcButton: .decimal),
      CalcButtonModel(
        calcButton: .equal,
        color: .foregroundRightButtons)
    ])
  ]
  
  var body: some View {
    Grid() {
      ForEach(buttonData) { rowOfCalcButtonsModel in
        GridRow {
          ForEach(rowOfCalcButtonsModel.row) { calcButtonModel in
            Button(action: {
              buttonPressed(calcButton: calcButtonModel.calcButton)
            }, label: {
              ButtonView(calcButton: calcButtonModel.calcButton, fgColor: calcButtonModel.color, bgColor: .buttonBackground)
            })
          }
        }
        
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(.secondaryBackground)
      
    )
    
  }
  
  // logic for the button actions are here
  func buttonPressed(calcButton: CalcButton) {
    switch calcButton {
    case .clear:
      currentComputation = ""  // a binding into this view
      mainResult = "0"
    case .equal, .negative:
      if !currentComputation.isEmpty {
        if !lastCharacterIsAnOperator(str: currentComputation) {
          let sign = calcButton == .negative ? -1.0 : 1.0
          mainResult = formatResult(val: sign * calculateResults())
          if calcButton == .negative {
            currentComputation = mainResult
          }
        }
      }
    case .decimal:
      // if we have a decimal in the string already
      if let lastOcurrenceOfDecimal = currentComputation.lastIndex(of: ".") {
        // need to make sure that we have only digits to the right
        // of the decmal point
        if lastCarIsDigit(str: currentComputation) {
          let startIndex = currentComputation.index(lastOcurrenceOfDecimal, offsetBy: 1)
          let endIndex = currentComputation.endIndex
          let range = startIndex..<endIndex
          let rightSubString = String(currentComputation[range])
          
          // Only have digits to the right of "."
          // that means do not add another "."
          // otherwise we can add another decomal point
          // for example, if we have 23.37+108,
          // the rightSubString is 37+108 which would not
          // convert to an integer and is a good thing and we can
          // add a deciomal.  Also dont whant to add decimal to nil
          // string
          // so we get "23.37+108" -> "23.37+108." from below
          // and if we have "123.45" we get "123.45" form below
          // (i.e. we don't add a decimal
          if Int(rightSubString) == nil && !rightSubString.isEmpty {
            currentComputation += "."
          }
        }
        // else if string is empty, add "0.
      } else {
        if currentComputation.isEmpty {
          currentComputation += "0."
          // else if we just have numbers, ok to add "."
        } else if lastCarIsDigit(str: currentComputation) {
          currentComputation += "."
        }
      }
    case .percent:
      if lastCarIsDigit(str: currentComputation) {
        appendToCurrentComputation(calcButton: calcButton)
      }
    case .undo:
      currentComputation = String(currentComputation.dropLast())
    case .add, .subtract, .multiply, .divide:
      if lastCarIsDigitOrPercent(str: currentComputation) {
        appendToCurrentComputation(calcButton: calcButton)
      }
    default:
      //needs further work
      appendToCurrentComputation(calcButton: calcButton)
    }
  }
  
  // Implements the actual computation
  func calculateResults() -> Double {
    let visibleWorkings: String = currentComputation
    var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
    workings = workings.replacingOccurrences(of: mutiplySymbol, with: "*")
    workings = workings.replacingOccurrences(of: divisionSymbol, with: "/")
    
    // if we have 35., will be replaced by 35.0
    if getLastChar(str: visibleWorkings) == "." {
      workings += "0"
    }
    
    // key point!!!!!!!
    //Actual computation
    let expr = NSExpression(format: workings)
    let exprValue = expr.expressionValue(with: nil, context: nil) as! Double
    
    return exprValue
    
  }
  
  func appendToCurrentComputation(calcButton: CalcButton) {
    currentComputation += calcButton.rawValue
  }
  
}




#Preview {
  CalcsButtonsView(currentComputation: .constant("5+1"), mainResult: .constant("6"))
}
