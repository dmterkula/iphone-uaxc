//
//  TimePicker.swift
//  UAXC
//
//  Created by David  Terkula on 9/16/22.
//

import SwiftUI

struct TimePicker: View {
    
    @Binding var minutesValue: Int
    @Binding var secondsValue: Int
    
    let minutes = [Int](15..<41)
    let seconds = [Int](0..<60)
    
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    Text("Select Time: ")
                        .padding(.trailing, 10)
                    
                    Picker(selection: $minutesValue, label: Text("")) {
                        ForEach(minutes, id: \.self) { minutesValue in
                            Text("\(minutesValue) m")
                        }
                    }
                    .frame(width: geometry.size.width / 5 , height: 20, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Picker(selection: $secondsValue, label: Text("")) {
                        ForEach(seconds, id: \.self) { secondsValue in
                            Text("\(secondsValue) s")
                        }
                    }
                    .frame(width: geometry.size.width / 5 , height: 20, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Spacer()
                }
            }
        }
    }
}

//struct TimePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TimePicker()
//    }
//}
