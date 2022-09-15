//
//  SideBySideBarChart.swift
//  UAXC
//
//  Created by David  Terkula on 9/11/22.
//

import SwiftUI

struct SideBySideBarChart: View {
    
    var barComparison: BarComparison
    @State var selectedUUID: UUID = UUID()
    @State var text = "Info"
    var title = ""
    var descriptor: String = ""
    var height: Double
    var width: Double
    var barDifferentiatingScaleFactor: Double = 1.0
    
    
    func determineScaling(scaleDataSet1: Bool, dataSet1Value: Double, dataset2Value: Double) -> Double {
        
        var difference = dataSet1Value - dataset2Value
        
        if (difference <= 0) {
            // dataSet2Larger
            if (scaleDataSet1) {
                if (dataSet1Value / dataset2Value >= 0.985) {
                    return 1.0
                } else {
                    return barDifferentiatingScaleFactor
                }
            } else {
                return 1.0
            }
            
            } else {
                // dataset 1 value is larger
                if (!scaleDataSet1) {
                    if (dataset2Value / dataSet1Value >= 0.985) {
                        return 1.0
                    } else {
                        return barDifferentiatingScaleFactor
                    }
                } else {
                    return 1.0
                }
        }
    }
    
    var body: some View {
        
        VStack {
            Text(title)
                .bold()
                .padding()
            
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(barComparison.barsDataSet1[0].color)
                    .frame(width: 5, height: 5)
                
                Text(barComparison.dataSet1LegendLabel)
                
                Rectangle()
                    .foregroundColor(barComparison.barsDataSet2[0].color)
                    .frame(width: 5, height: 5)
                
                Text(barComparison.dataSet2LegendLabel)
            }
            
            ScrollView(.horizontal) {
                HStack(alignment: .bottom, spacing: 15) { // all the bars
                    
                    let dataSet1 = barComparison.barsDataSet1
                    let dataSet2 = barComparison.barsDataSet2
                    
                    if(!dataSet1.isEmpty && !dataSet2.isEmpty) {
                        let max = (dataSet1 + dataSet2).sorted(by: { $0.value > $1.value })[0].value
                        ForEach(Array(dataSet1.enumerated()), id: \.offset) { i, element in
                            
                            let bar1ScaleFactor = (dataSet1[i].value < dataSet2[i].value) ? barDifferentiatingScaleFactor : 1.0
                            let bar2ScaleFactor = (dataSet2[i].value < dataSet1[i].value) ? barDifferentiatingScaleFactor : 1.0
                            
                            VStack { // side by side bars and group label
                                HStack(alignment: .bottom, spacing: 0) { // 2 bars side by side
                                    
                                    VStack { // bar data set 1
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(dataSet1[i].color)
                                                //.frame(width: width, height: (pow(dataSet1[i].value/max, 5)) * height * 1.25, alignment: .bottom)
                                                .frame(width: width, height: (dataSet1[i].value/max) * height * determineScaling(scaleDataSet1: true, dataSet1Value: dataSet1[i].value, dataset2Value: dataSet2[i].value), alignment: .bottom)
                                                .cornerRadius(6)
                                                .opacity(selectedUUID == dataSet1[i].id ? 0.5 : 1.0)
                                                .onTapGesture {
                                                    self.selectedUUID = dataSet1[i].id
                                                    self.text = "Value: \(Int(dataSet1[i].value))"
                                                }
                                            
                                            Text("\(Double(dataSet1[i].value), specifier: "%.2f")")
                                                .foregroundColor(.white)
                                        
                                            }

                                    } // end first bar v stack
                                    
                                    VStack { // bar data set 2
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(dataSet2[i].color)
                                                //.frame(width: width, height: (pow(dataSet2[i].value/max, 5)) * height * 1.125, alignment: .bottom)
                                                .frame(width: width, height: (dataSet2[i].value/max) * height * determineScaling(scaleDataSet1: false, dataSet1Value: dataSet1[i].value, dataset2Value: dataSet2[i].value), alignment: .bottom)
                                                .cornerRadius(6)
                                                .opacity(selectedUUID == dataSet2[i].id ? 0.5 : 1.0)
                                                .onTapGesture {
                                                    self.selectedUUID = dataSet2[i].id
                                                    self.text = "Value: \(Int(dataSet2[i].value))"
                                                }
                                            
                                            Text("\(Double(dataSet2[i].value), specifier: "%.2f")")
                                                .foregroundColor(.white)
                                        
                                            }

                                    } // end second bar vstack
                                    
                                }.padding(.leading, 10) // end side by side hstack
                                
                                
                                Text(barComparison.comparisonLabels[i])
                                
                            } // end vstack side by side bars and group label
                        
                        } // end for each
                    }

                    
                } // end all bars in chart hstack
            }

            
            if (!descriptor.isEmpty) {
                Text(descriptor)
            }
            
        } // end vstack
    }
}

//struct SideBySideBarChart_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBySideBarChart()
//    }
//}
