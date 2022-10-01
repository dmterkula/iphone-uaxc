import Foundation

import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    let interval: DateInterval
    @ObservedObject var workoutStore: WorkoutStore
    @Binding var dateSelected: DateComponents?
    @Binding var displayWorkouts: Bool
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
        if let changedWorkout = workoutStore.changedWorkout{
            uiView.reloadDecorations(forDateComponents: [changedWorkout.dateComponents], animated: true)
            workoutStore.changedWorkout = nil
        }
        
        if let movedWorkout = workoutStore.movedWorkout{
            uiView.reloadDecorations(forDateComponents: [movedWorkout.dateComponents], animated: true)
            workoutStore.movedWorkout = nil
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, workoutStore: _workoutStore)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        var parent: CalendarView
        @ObservedObject var workoutStore: WorkoutStore
        
        init(parent: CalendarView, workoutStore: ObservedObject<WorkoutStore>) {
            self.parent = parent
            self._workoutStore = workoutStore
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            
            parent.dateSelected = dateComponents
            
            guard let dateComponents else { return }
            
            let foundWorkouts = workoutStore.workouts.filter {
                $0.date.startOfDay == dateComponents.date?.startOfDay
            }
            
            if (!foundWorkouts.isEmpty) {
                parent.displayWorkouts.toggle()
            }

        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
        
        // used to add or decorate Calendar with icons, needs to happen on main thread so add @MainActor
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundWorkouts = workoutStore.workouts.filter {
                $0.date.startOfDay == dateComponents.date?.startOfDay
            }
            
            if foundWorkouts.isEmpty { return nil }
            
            if foundWorkouts.count > 1 {
                return .image(UIImage(systemName: "doc.on.doc.fill"),
                              color: .red,
                              size: .large)
            }
            
            let singleWorkout: Workout = foundWorkouts.first!
            
            return .customView {
                let icon = UILabel()
                icon.text = singleWorkout.icon
                return icon
            }
            
        }
        
       
    }
}


