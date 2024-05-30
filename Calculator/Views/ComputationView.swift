//
//  ComputationView.swift
//  Calculator
//
//  Created by Michael Knych on 4/22/24.
//

import SwiftUI

struct ComputationView: View {
  let currentComputation: String
  let mainResult: String
  
    var body: some View {
      VStack(spacing: 10) {
        HStack {
          Spacer()
          Text(currentComputation)
            .foregroundStyle(.foregroundDigits)
          .lineLimit(1)
        }
        .minimumScaleFactor(0.1)  // text will shrink up to 10%
        HStack {
          Spacer()
          Text(mainResult)
            .foregroundStyle(.foregroundDigits)
            .font(.largeTitle)
            .fontWeight(.bold)
          .lineLimit(1)
        }
        .minimumScaleFactor(0.1)  // text will shrink up to 10%
        
      }
      .padding(.horizontal)
    }
}

#Preview {
  ComputationView(currentComputation: "1200+936", mainResult: "12936")
}
