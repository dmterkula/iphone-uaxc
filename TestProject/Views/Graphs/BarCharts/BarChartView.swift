//
//  BarChartView.swift
//  UAXC
//
//  Created by David  Terkula on 9/9/22.
//

import SwiftUI

struct BarChartView: View {
    
    @Binding var bars: [Bar]
    @State var selectedUUID: UUID = UUID()
    @State var text = "Info"
    var height: Double
    var width: Double
    
    var body: some View {
        VStack {
            Text("Runner's Time Compared To Last Year")
                .bold()
                .padding()
        
            HStack(alignment: .bottom) {
                
                let max = bars.sorted(by: { $0.value > $1.value })[0].value
                
                ForEach(bars) { bar in
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(bar.color)
                                .frame(width: width, height: (bar.value/max) * height * 0.90, alignment: .bottom)
                                .cornerRadius(6)
                                .opacity(selectedUUID == bar.id ? 0.5 : 1.0)
                                .onTapGesture {
                                    self.selectedUUID = bar.id
                                    self.text = "Value: \(Int(bar.value))"
                                }
                            
                            Text("\(Int(bar.value))")
                                .foregroundColor(.white)
                        
                            }

                            
                        Text(bar.label)
                    
                    }
                }
            }
            .frame(height: height, alignment: .bottom)
            .padding(20)
            .background(.thinMaterial)
            .cornerRadius(6)
        }
        
    }
}

//struct BarChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarChartView(bars: [Bar(label: "test", value: 10, size: 10, scaleFactor: 3, color: .green)], scaleFactor: 2.5)
//    }
//}
