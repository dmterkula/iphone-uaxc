//
//  Extension.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI


//struct Extension: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
           opacity(shouldHide ? 0 : 1)
       }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

//extension Array {
// 
//    func anySatisfy(condition: Bool) -> Bool {
//        
//        ForEach(self) { elem in
//            if
//        }
//        
//    }
//    
//}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: self)
    }
    
    func getDateNoTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
}

extension Double {
    
    func toPaddedString() -> String {
        if (self < 10) {
            return "0" + String(self)
        } else {
            return String(self)
        }
    }
    
    func toMinuteSecondString() -> String {
        let minutes: Int = Int((self / 60))
        var seconds = (self.truncatingRemainder(dividingBy: 60)).rounded(toPlaces: 1)
            if (self < 0) {
                seconds *= -1
                let secondsString = seconds.toPaddedString()
                return "-" + String(minutes * -1) + ":" + secondsString
            } else {
                return String(minutes) + ":" + seconds.toPaddedString()
            }
    }
    
    func minutesToMinuteString() -> String {
        return String(Int(self)) + ":00"
    }
    
    
}

extension Int {
    func toMinuteSecondString() -> String {
        let minutes: Int = Int((self / 60))
        var seconds = (Double(self).truncatingRemainder(dividingBy: 60)).rounded(toPlaces: 1)
            if (self < 0) {
                seconds *= -1
                let secondsString = seconds.toPaddedString()
                return "-" + String(minutes * -1) + ":" + secondsString
            } else {
                return String(minutes) + ":" + seconds.toPaddedString()
            }
    }
}

extension String {
    
    func calculateSecondsFrom() -> Double {
        
        if (self.isEmpty) {
            return 0.0
        }
        
        let splitTime: [String] = self.components(separatedBy: ":")
        if (self.contains("-")) {
            return (Double(splitTime[0]) ?? 0.0) * 60 + (Double(splitTime[1]) ?? 0.0) * -1
        } else {
            return (Double(splitTime[0]) ?? 0.0) * 60 + (Double(splitTime[1]) ?? 0.0)
        }
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func isValidTime() -> Bool {
        
        if (self.matches("[0-9][0-9:[0-9][0-9].[0-9]+") || self.matches("[0-9:[0-9][0-9].[0-9]+") || self.matches("[0-9][0-9:[0-9][0-9]") || self.matches("[0-9]:[0-9][0-9]")) {
            return true
        } else {
            return false
        }
        
    }
}

extension Int {
    
    func convertToMilesString() -> String {
        return String((Double(self) / 1609.0).rounded(toPlaces: 2))
    }
    
}

extension Array {

     public func mapWithIndex<T> (f: (Int, Element) -> T) -> [T] {
         return zip((self.startIndex ..< self.endIndex), self).map(f)
   }
    

    public func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }

    
    
 }

//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}


//struct Extension_Previews: PreviewProvider {
//    static var previews: some View {
//        Extension()
//    }
//}

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}


public extension Data {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary {
            var swiftDict: [String: Any] = [:]
            for key in theJSONData.allKeys {
                let stringKey = key as? String
                if let key = stringKey, let keyValue = theJSONData.value(forKey: key) {
                    swiftDict[key] = keyValue
                }
            }
            swiftDict.printAsJSON()
        }
    }
}



