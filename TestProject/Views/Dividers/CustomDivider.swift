//
//  CustomDivider.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct CustomDivider: View {
  let color: Color
  let height: CGFloat

  init(color: Color = .gray.opacity(0.5),
       height: CGFloat = 0.5) {
    self.color = color
    self.height = height
  }

  var body: some View {
    Rectangle()
      .fill(color)
      .frame(height: height)
      .edgesIgnoringSafeArea(.horizontal)
  }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
