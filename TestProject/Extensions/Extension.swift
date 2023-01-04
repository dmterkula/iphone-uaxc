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
    
    func getMinutesFrom() -> Int {
        
        let splitTime: [String] = self.components(separatedBy: ":")
        
        if (splitTime.isEmpty || splitTime.count == 1) {
            return 0
        }
        
        return (Int(splitTime[0]) ?? 0)
        
    }
    
    func getSecondsFrom() -> Int {
        let splitTime: [String] = self.components(separatedBy: ":")
        
        if (splitTime.isEmpty) {
            return 0
        }
        
        return (Int(Double(splitTime[1]) ?? 00) )
    }
    
    func getMillisecondsFrom() -> Int {
        let splitTime: [String] = self.components(separatedBy: ".")
        
        if (splitTime.isEmpty) {
            return 0
        }
        
        if (splitTime.count == 1) {
            return 0
        }
        
        return (Int(Double(splitTime[1]) ?? 00) )
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

extension [SplitElement] {
    
    func toSplits() -> [Split] {
        if self.isEmpty {
            return []
        } else {
            return self.map{Split(uuid: $0.uuid, number: $0.number, value: $0.time)}
        }
    }
    
    func toSplitsViewModel() -> [DoubleSplitViewModel] {
        if self.isEmpty {
            return []
        } else {
            return self.map{DoubleSplitViewModel(Split(uuid: $0.uuid, number: $0.number, value: $0.time))}
        }
    }
    
}

extension [DoubleSplitViewModel] {
    
    func toSplits() -> [Split] {
        if self.isEmpty {
            return []
        } else {
            return self.map{Split(uuid: $0.uuid, number: $0.number, value: $0.getMinuteSecondString())}
        }
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
    

    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
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


enum AccessibilityHelpers {
    // TODO: This should be a protocol but since the data objects are in flux this will suffice
    static func chartDescriptor(trainingSummaryDTOs data: [TrainingSummaryDTO], chartFrequency: String,
                                isContinuous: Bool = false) -> AXChartDescriptor {

        // Since we're measuring a tangible quantity,
        // keeping an independant minimum prevents visual scaling in the Rotor Chart Details View
        let min = 0 // data.map(\.sales).min() ??
        let max = data.map(\.totalDistance).max() ?? 0

        // A closure that takes a date and converts it to a label for axes
        let dateTupleStringConverter: ((TrainingSummaryDTO) -> (String)) = { dataPoint in

            let dateDescription = dataPoint.startDate.formatted(date: .complete, time: .omitted)

//            if let threshold = saleThreshold {
//                let isAbove = dataPoint.totalDistance.isAbove(threshold: threshold)
//
//                return "\(dateDescription): \(isAbove ? "Above" : "Below") threshold"
//            }

            return dateDescription
        }

        let xAxis = AXNumericDataAxisDescriptor(
            title: "Date index",
            range: Double(0)...Double(data.count),
            gridlinePositions: []
        ) { "Day \(Int($0) + 1)" }

        let yAxis = AXNumericDataAxisDescriptor(
            title: "Total Miles",
            range: Double(min)...Double(max),
            gridlinePositions: []
        ) { value in "\(Int(value)) miles run" }

        var name = "Weekly Miles Run"
        var title = "Miles Per Week"
        
        if (chartFrequency == "monthly") {
            name = "Monthly Miles Run"
            title = "Miles Per Month"
        } else if (chartFrequency == "daily") {
            name = "Daily Miles Run"
            title = "Miles Per Day"
        }
        
        
        let series = AXDataSeriesDescriptor(
            name: name,
            isContinuous: isContinuous,
            dataPoints: data.enumerated().map { (idx, point) in
                    .init(x: Double(idx),
                          y: Double(point.totalDistance),
                          label: dateTupleStringConverter(point))
            }
        )

        return AXChartDescriptor(
            title: title,
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }

//    static func chartDescriptor(forLocationSeries data: [LocationData.Series]) -> AXChartDescriptor {
//        let dateStringConverter: ((Date) -> (String)) = { date in
//            date.formatted(date: .abbreviated, time: .omitted)
//        }
//
//        // Create a descriptor for each Series object
//        // as that allows auditory comparison with VoiceOver
//        // much like the chart does visually and allows individual city charts to be played
//        let series = data.map { dataPoint in
//            AXDataSeriesDescriptor(
//                name: "\(dataPoint.city)",
//                isContinuous: false,
//                dataPoints: dataPoint.sales.map { data in
//                        .init(x: dateStringConverter(data.weekday),
//                              y: Double(data.sales),
//                              label: "\(data.weekday.weekdayString)")
//                }
//            )
//        }
//
//        // Get the minimum/maximum within each city
//        // and then the limits of the resulting list
//        // to pass in as the Y axis limits
//        let limits: [(Int, Int)] = data.map { seriesData in
//            let sales = seriesData.sales.map { $0.sales }
//            let localMin = sales.min() ?? 0
//            let localMax = sales.max() ?? 0
//            return (localMin, localMax)
//        }
//
//        let min = limits.map { $0.0 }.min() ?? 0
//        let max = limits.map { $0.1 }.max() ?? 0
//
//        // Get the unique days to mark the x-axis
//        // and then sort them
//        let uniqueDays = Set( data
//            .map { $0.sales.map { $0.weekday } }
//            .joined() )
//        let days = Array(uniqueDays).sorted()
//
//        let xAxis = AXCategoricalDataAxisDescriptor(
//            title: "Days",
//            categoryOrder: days.map { dateStringConverter($0) }
//        )
//
//        let yAxis = AXNumericDataAxisDescriptor(
//            title: "Sales",
//            range: Double(min)...Double(max),
//            gridlinePositions: []
//        ) { value in "\(Int(value)) sold" }
//
//        return AXChartDescriptor(
//            title: "Sales per day",
//            summary: nil,
//            xAxis: xAxis,
//            yAxis: yAxis,
//            additionalAxes: [],
//            series: series
//        )
//    }
}
