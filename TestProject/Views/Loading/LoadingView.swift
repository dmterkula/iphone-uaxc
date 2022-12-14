//
//  LoadingView.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import SwiftUI

struct LoadingView: View {
    
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    @State var animate = false
    let color1 = Color.gray
    let color2 = Color.gray.opacity(0.5)
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color1, color2]), center: .center), style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
            
        }.onAppear() {
            self.animate.toggle()
        }
       
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
