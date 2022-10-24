//
//  WorkoutStore.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import Foundation

@MainActor
class WorkoutStore: ObservableObject {
    @Published var workouts = [Workout]()
    @Published var preview: Bool
    @Published var changedWorkout: Workout?
    @Published var movedWorkout: Workout?
    
    let dataService = DataService()

    init(preview: Bool = false) {
        self.preview = preview
        fetchEvents()
    }

    func fetchEvents() {
        if preview {
            workouts = Workout.sampleWorkouts
        } else {
            let startDate = Date().diff(numDays: -100)
            let endDate = Date().diff(numDays: 100)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            
            dataService.fetchAllWorkouts(startDate: startDateString, endDate: endDateString) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.workouts = response
                        case .failure(let error):
                            print(error)
                    }
                }
            }
        }
    }

    func delete(_ workout: Workout) {
        
        if (preview) {
            if let index = workouts.firstIndex(where: {$0.uuid == workout.uuid}) {
                changedWorkout = workouts.remove(at: index)
            }
        } else {
            
            if let index = self.workouts.firstIndex(where: {$0.uuid == workout.uuid}) {
                self.changedWorkout = self.workouts.remove(at: index)
            }
            
                dataService.deleteWorkout(workout: workout) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(_):
                            self.workouts = self.workouts.sorted(by: {
                                $0.date.compare($1.date) == .orderedDescending
                            })
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
       
    }

    func add(_ workout: Workout) {
        
        if (preview) {
            workouts.append(workout)
            changedWorkout = workout
        } else {
            dataService.createWorkout(workout: workout) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            self.workouts.append(response)
                            self.changedWorkout = response
                            self.workouts = self.workouts.sorted(by: {
                                $0.date.compare($1.date) == .orderedDescending
                            })
                        
                            case .failure(let error):
                                print(error)
                        }
                    }
            }
        }
        
        
    }

    func update(_ workout: Workout) {
        
        if (preview) {
            if let index = workouts.firstIndex(where: {$0.uuid == workout.uuid}) {
                movedWorkout = workouts[index]
                workouts[index].date = workout.date
                workouts[index].title = workout.title
                changedWorkout = workout
            }
            
        }
        else {
            if let index = workouts.firstIndex(where: {$0.uuid == workout.uuid}) {
                movedWorkout = workouts[index]
                workouts[index] = workout
                changedWorkout = workout
                
                dataService.updateWorkout(
                    workout: workout) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                print(response)
                                case .failure(let error):
                                    print(error)
                            }
                        }
                }
            }
            else {
                print("didn't update, fail to find matching workout")
            }
        }
    }
}
