//
//  TimePicker.swift
//  UAXC
//
//  Created by David  Terkula on 9/16/22.
//

import SwiftUI

struct RaceTimePicker: View {
    
    @Binding var minutesValue: Int
    @Binding var secondsValue: Int
    
    let minutes = [Int](0..<41)
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

struct RaceTimePickerMillis: View {
    
    @Binding var minutesValue: Int
    @Binding var secondsValue: Int
    @Binding var millisecondsValue: Int
    
    let minutes = [Int](0..<41)
    let seconds = [Int](0..<60)
    let milliseconds = [Int](0..<100)
    
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Text("Select Time: ")
                    .padding(.bottom, 5)
                
                HStack {
                    Spacer()
                    
                    Picker(selection: $minutesValue, label: Text("")) {
                        ForEach(minutes, id: \.self) { minutesValue in
                            Text("\(minutesValue) m")
                        }
                    }
                    .frame(width: geometry.size.width / 3.5 , height: 20, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Picker(selection: $secondsValue, label: Text("")) {
                        ForEach(seconds, id: \.self) { secondsValue in
                            Text("\(secondsValue) s")
                        }
                    }
                    .frame(width: geometry.size.width / 3.5 , height: 20, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Picker(selection: $millisecondsValue, label: Text("")) {
                        ForEach(milliseconds, id: \.self) { millisecondsValue in
                            Text("\(millisecondsValue) ms")
                        }
                    }
                    .frame(width: geometry.size.width / 3.5 , height: 20, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
    }
}

struct SplitTimePicker: View {
    
    @Binding var minutesValue: Int
    @Binding var secondsValue: Int
    
    let minutes = [Int](0..<59)
    let seconds = [Int](0..<60)
    
    
    var body: some View {
        
        GeometryReader { geometry in
                HStack {
                    Spacer()
                    
                    Picker(selection: $minutesValue, label: Text("")) {
                        ForEach(minutes, id: \.self) { minutesValue in
                            Text("\(minutesValue) m")
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 100, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Picker(selection: $secondsValue, label: Text("")) {
                        ForEach(seconds, id: \.self) { secondsValue in
                            Text("\(secondsValue) s")
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 100, alignment: .center)
                    .accentColor(.white)
                    .font(.title3)
                    
                    Spacer()
            }
        }
    }
}

struct SplitTimePickerLight: View {
    
    @Binding var minutesValue: Int
    @Binding var secondsValue: Int
    
    let minutes = [Int](0..<59)
    let seconds = [Int](0..<60)
    
    
    var body: some View {
        
        GeometryReader { geometry in
                HStack {
                    Spacer()
                    
                    Picker(selection: $minutesValue, label: Text("Min.").foregroundColor(.black)) {
                        ForEach(minutes, id: \.self) { minutesValue in
                            Text("\(minutesValue) m")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 100, alignment: .center)
               
                    Spacer()
                    
                    Picker(selection: $secondsValue, label: Text("Sec").foregroundColor(.black)) {
                        ForEach(seconds, id: \.self) { secondsValue in
                            Text("\(secondsValue) s")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 100, alignment: .center)
                    
                    Spacer()
            }
        }
    }
}


struct MilesPicker: View {
    
    @Binding var miles: Int
    @Binding var fractionOfMiles: Int
    var label: String
    
    let possibleMiles = [Int](0..<11)
    let possibleFraction = [Int](0..<100)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(label)
                        .padding(.trailing, 10)
                    
                    Picker(selection: $miles, label: Text("")) {
                        ForEach(possibleMiles, id: \.self) { milesValue in
                            Text("\(milesValue)")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 5 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                    Picker(selection: $fractionOfMiles, label: Text("")) {
                        ForEach(possibleFraction, id: \.self) { fractionValue in
                            if (fractionValue < 10) {
                                Text("." + "0\(fractionValue)" + "mi")
                                    .foregroundColor(.black)
                            } else {
                                Text("." + "\(fractionValue)" + "mi")
                                    .foregroundColor(.black)
                            }
                           
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        } // end gemometry
        .frame(height: 30)
    }
}

struct PlacePicker: View {
    
    @Binding var place: Int
    
    let possiblePlaces = [Int](0..<400)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Pick Place")
                        .padding(.trailing, 10)
                    
                    Picker(selection: $place, label: Text("")) {
                        ForEach(possiblePlaces, id: \.self) { placeValue in
                            Text("\(placeValue)")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        } // end gemometry
        .frame(height: 30)
    }
}

struct PassesPicker: View {
    
    @Binding var passes: Int
    
    let possiblePasses = [Int](-125..<125)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Passes")
                        .padding(.trailing, 10)
                    
                    Picker(selection: $passes, label: Text("")) {
                        ForEach(possiblePasses, id: \.self) { passValue in
                            Text("\(passValue)")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        } // end gemometry
        .frame(height: 30)
    }
}

struct SkullBeadPicker: View {
    
    @Binding var skulls: Int
    
    let possibleSkulls = [Int](0..<11)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Skull beads")
                        .padding(.trailing, 10)
                    
                    Picker(selection: $skulls, label: Text("")) {
                        ForEach(possibleSkulls, id: \.self) { skullValue in
                            Text("\(skullValue)")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        } // end gemometry
        .frame(height: 30)
    }
}

struct TrainingRunTimePicker: View {
    
    @Binding var minutes: Int
    @Binding var seconds: Int
  
    let possibleMinutes = [Int](0..<91)
    let possibleSeconds = [Int](0..<60)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Time: ")
                        .padding(.trailing, 10)
                    
                    Picker(selection: $minutes, label: Text("")) {
                        ForEach(possibleMinutes, id: \.self) { minutesValue in
                            Text("\(minutesValue)m")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                    
                    Picker(selection: $seconds, label: Text("")) {
                        ForEach(possibleSeconds, id: \.self) { fractionValue in
                            Text("\(fractionValue)" + "s")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 3 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        }// end geometry
        .frame(height: 30)
    }
}


struct WorkoutSplitTimePicker: View {
    
    @Binding var minutes: Int
    @Binding var seconds: Int
  
    let possibleMinutes = [Int](0..<91)
    let possibleSeconds = [Int](0..<60)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Picker(selection: $minutes, label: Text("")) {
                        ForEach(possibleMinutes, id: \.self) { minutesValue in
                            Text("\(minutesValue)m")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 2.5 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                    
                    Picker(selection: $seconds, label: Text("")) {
                        ForEach(possibleSeconds, id: \.self) { fractionValue in
                            Text("\(fractionValue)" + "s")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: geometry.size.width / 2.5 , height: 20, alignment: .center)
                    .accentColor(.black)
                    .font(.title3)
                    
                }
            }
        }// end geometry
        .frame(height: 30)
    }
}


//struct TimePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TimePicker()
//    }
//}
