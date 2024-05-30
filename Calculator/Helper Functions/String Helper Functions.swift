//
//  String Helper Functions.swift
//  Calculator
//
//  Created by Michael Knych on 4/23/24.
//

import Foundation

/// Returns last character, if it exists.
/// Otherwise return an empty string.
func getLastChar(str: String) -> String {
  return str.isEmpty ? "" : String(str.last!)
}

/// Test to see if last character in specified string (str) is equal to the specified character (char)
func lastCharacterIsEqualTo(str: String, char: String) -> Bool {
  let last = getLastChar(str: str)
  return last == char
}

/// Format a number of type Double into a formated String using NumberFormatter
func formatResult(val: Double) -> String {
  let numberFormatter = NumberFormatter()
  numberFormatter.numberStyle = .decimal
  numberFormatter.maximumFractionDigits = 16
  return numberFormatter.string(from: NSNumber(value: val)) ?? "0"
}

func lastCarIsDigit(str: String) -> Bool {
  return "0123456789".contains(getLastChar(str: str))
}

func lastCarIsDigitOrPercent(str: String) -> Bool {
  return "0123456789%".contains(getLastChar(str: str))
}

func lastCharacterIsAnOperator(str: String) -> Bool {
  let last = getLastChar(str: str)
  return operators.contains(last)
}
