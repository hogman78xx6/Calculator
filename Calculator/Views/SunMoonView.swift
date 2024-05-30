//
//  SunMoonView.swift
//  Calculator
//
//  Created by Michael Knych on 4/22/24.
//

import SwiftUI

struct SunMoonView: View {
  var lightMode: Bool
    var body: some View {
      HStack(spacing: 30) {
        Image(systemName: "sun.min")
          .imageScale(.large)
          .foregroundStyle(lightMode ? .sunOrMoonSelected : .sunOrMoonNotSelected)
        Image(systemName: "moon")
          .imageScale(.large)
          .foregroundStyle(lightMode ? .sunOrMoonNotSelected : .sunOrMoonSelected)
      }
      .padding()
      .background(.secondaryBackground)
      .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
  VStack {
    SunMoonView(lightMode: true)
    SunMoonView(lightMode: false)  }
}
