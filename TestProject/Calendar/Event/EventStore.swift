//
//  EventStore.swift
//  UAXC
//
//  Created by David  Terkula on 11/12/22.
//


import Foundation

@MainActor
class EventStore: ObservableObject {
    @Published var events = [Event]()
    @Published var preview: Bool
    @Published var changedEvent: Event?
    @Published var movedEvent: Event?
    
    
    let dataService = DataService()

    init(preview: Bool = false) {
        self.preview = preview
        fetchEvents()
    }

    func fetchEvents() {
        if preview {
            events = Workout.sampleWorkouts.map { WorkoutEvent(workout: $0) }
        } else {
            let startDate = Date().diff(numDays: -150)
            let endDate = Date().diff(numDays: 150)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            
            dataService.fetchAllWorkouts(startDate: startDateString, endDate: endDateString) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.events.append(contentsOf: response.map { WorkoutEvent(workout: $0) })
                        self.events = self.events.unique{$0.uuid}
                        case .failure(let error):
                            print(error)
                    }
                }
            }
            
            dataService.getMeetsBetweenDates(startDate: startDate, endDate: endDate) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.events.append(contentsOf: response.map { MeetEvent(meet: $0) })
                        self.events = self.events.unique{$0.uuid}
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
            
            dataService.getTrainingRunsBetweenDates(startDate: startDate, endDate: endDate) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.events.append(contentsOf: response.trainingRuns.map { TrainingRunEvent(trainingRun: $0) })
                        self.events = self.events.unique{$0.uuid}
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }

    func delete(_ event: Event) {
        
        if (preview) {
            if let index = events.firstIndex(where: {$0.uuid == event.uuid}) {
                changedEvent = events.remove(at: index)
            }
        } else {
            
            if let index = self.events.firstIndex(where: {$0.uuid == event.uuid}) {
                self.changedEvent = self.events.remove(at: index)
            }
            
    
            if (event.type == EventType.workout) {
                
                dataService.deleteWorkout(uuid: event.uuid) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(_):
                                self.events = self.events.sorted(by: {
                                    $0.date.compare($1.date) == .orderedDescending
                                })
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
            } else if (event.type == EventType.training) {
                dataService.deleteTrainingRun(uuid: event.uuid) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(_):
                                self.events = self.events.sorted(by: {
                                    $0.date.compare($1.date) == .orderedDescending
                                })
                                
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
            }

        }
       
    }

    func add(_ event: Event) {
        
        if (preview) {
            events.append(event)
            changedEvent = event
        } else {
            
        
            if let workoutEvent = event as? WorkoutEvent {
                dataService.createWorkout(workout: workoutEvent.toWorkout()) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            let newWorkout = WorkoutEvent(workout: response).toWorkout()
                            self.events.append(WorkoutEvent(workout: newWorkout))
                            self.changedEvent = WorkoutEvent(workout: newWorkout)
                            self.events = self.events.sorted(by: {
                                $0.date.compare($1.date) == .orderedDescending
                            })
                        
                            case .failure(let error):
                                print(error)
                        }
                    }
                }
                
            } else if let meetEvent = event as? MeetEvent {
                dataService.createMeet(meetEvent: meetEvent) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            let newMeetEvent = MeetEvent(meet: response)
                            self.events.append(newMeetEvent)
                            self.changedEvent = newMeetEvent
                            self.events = self.events.sorted(by: {
                                $0.date.compare($1.date) == .orderedDescending
                            })
                        
                            case .failure(let error):
                                print(error)
                        }
                    }
                }
            } else if let trainingRunEvent = event as? TrainingRunEvent {
                dataService.createTrainingRun(trainingRunEvent: trainingRunEvent) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            if (response.trainingRuns.count > 0) {
                                let newTrainingRunEvent = TrainingRunEvent(trainingRun: response.trainingRuns[0])
                                self.events.append(newTrainingRunEvent)
                                self.changedEvent = newTrainingRunEvent
                                self.events = self.events.sorted(by: {
                                    $0.date.compare($1.date) == .orderedDescending
                                })
                            } else {
                                print("not able to create training run")
                            }
                            case .failure(let error):
                                print(error)
                        }
                    }
                }
            }
        }
    }

    func update(_ event: Event) {
        
        if (preview) {
            if let index = events.firstIndex(where: {$0.uuid == event.uuid}) {
                movedEvent = events[index]
                events[index].date = event.date
                events[index].title = event.title
                changedEvent = event
            }
            
        }
        else {
            if let index = events.firstIndex(where: {$0.uuid == event.uuid}) {
                movedEvent = events[index]
//                events[index].date = event.date
//                events[index].date = event.icon
//                events[index].date = event.title
                // the above keeps the sheet view correct, but back on the list view it is not updated.
                events[index] = event
                changedEvent = event
                
                
                if let workoutEvent = event as? WorkoutEvent {
                    dataService.updateWorkout(
                        workout: workoutEvent.toWorkout()) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    print(response)
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                    }
                } else if let meetEvent = event as? MeetEvent {
                    dataService.updateMeet(
                        meetEvent: meetEvent) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    print(response)
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                    }
                } else if let trainingRunEvent = event as? TrainingRunEvent {
                    dataService.updateTrainingRun(
                        trainingRunEvent:trainingRunEvent) { (result) in
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
   
            }
            else {
                print("didn't update, fail to find matching event")
            }
        }
    }
}
