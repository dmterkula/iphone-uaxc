//
//  MetVsUnmetGoals.swift
//  UAXC
//
//  Created by David  Terkula on 9/22/22.
//

import SwiftUI

struct MetVsUnmetGoalsBarChart: View {
    
    @Binding var bars: [Bar]
    @State var selectedUUID: UUID = UUID()
    @State var text = "Info"
    var height: Double
    var width: Double
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .padding()
        
            HStack(alignment: .bottom) {
                
                let max = bars[0].value + bars[1].value
                
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
            .cornerRadius(6)
        }
        .background(.thinMaterial)
    }
}

//struct MetVsUnmetGoals_Previews: PreviewProvider {
//    static var previews: some View {
//        MetVsUnmetGoalsBarChart()
//    }
//}
