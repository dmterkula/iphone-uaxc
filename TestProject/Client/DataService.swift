//
//  DataService.swift
//  TestProject
//
//  Created by David  Terkula on 8/23/22.
//

import Foundation

class DataService {
    static let dataService = DataService()
    fileprivate let baseUrlString = "7uyfdpbnyj.execute-api.us-east-2.amazonaws.com"
    
    enum APIError: Error {
        case error
    }
    
    func fetchPRs(lastIncludedGradClass: String, completition: @escaping (Result<PRDTO, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/PRs/forAll"
        
        let queryItem = URLQueryItem(name: "filter.gradClassAfter", value: lastIncludedGradClass)
        componentUrl.queryItems = [queryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let prDTO = try JSONDecoder().decode(PRDTO.self, from: validData)
                print(prDTO.PRs)
                
                completition(.success(prDTO))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
        
        
    }
    
    
    
    func fetchMeetResults(meetName: String, year: String, completition: @escaping (Result<MeetPerformanceResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/getMeetResultByMeetName"
        
        let meetQueryItem = URLQueryItem(name: "filter.meetName", value: meetName)
        let startYearQueryItem = URLQueryItem(name: "filter.startSeason", value: year)
        let endYearQueryItem = URLQueryItem(name: "filter.endSeason", value: year)
        let pageQueryItem = URLQueryItem(name: "page.size", value: "50")
        componentUrl.queryItems = [meetQueryItem, startYearQueryItem, endYearQueryItem, pageQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let meetPerformanceResponse = try JSONDecoder().decode(MeetPerformanceResponse.self, from: validData)
                
                completition(.success(meetPerformanceResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func fetchMeetSplitsForRunner(runnerName: String, year: String, completition: @escaping (Result<MeetSplitsResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetMileSplits/forRunner"
        
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runnerName)
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: year)
        componentUrl.queryItems = [runnerQueryItem, seasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let meetSplitResponse = try JSONDecoder().decode(MeetSplitsResponse.self, from: validData)
                
                completition(.success(meetSplitResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
        
        
    }
    
    
    func fetchMeetSumary(meetName: String, year: String, resultsPerCategory: String, completition: @escaping (Result<MeetSummaryResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetSummary"
        
        let runnerQueryItem = URLQueryItem(name: "filter.meet", value: meetName)
        let seasonQueryItem = URLQueryItem(name: "season", value: year)
        let pageQueryItem = URLQueryItem(name: "page.size", value: resultsPerCategory)
        componentUrl.queryItems = [runnerQueryItem, seasonQueryItem, pageQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let meetSummaryResponse = try JSONDecoder().decode(MeetSummaryResponse.self, from: validData)
                print(meetSummaryResponse)
                completition(.success(meetSummaryResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
        
        
    }
    
    func fetchRunnerProfile(runnerName: String, completition: @escaping (Result<RunnerProfileResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runnerProfile/"
        
        let runnerQueryItem = URLQueryItem(name: "filter.name", value: runnerName)
    
        componentUrl.queryItems = [runnerQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let runnerProfileResponse = try JSONDecoder().decode(RunnerProfileResponse.self, from: validData)
                print(runnerProfileResponse)
                completition(.success(runnerProfileResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchMeetResultsByRunnerName(runnerName: String, startSeason: String, endSeason: String, completition: @escaping (Result<MeetResultsForRunnerResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/getMeetResultByName"
        
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runnerName)
        let startSeasonQueryItem = URLQueryItem(name: "filter.startSeason", value: startSeason)
        let endSeasonQueryItem = URLQueryItem(name: "filter.endSeason", value: endSeason)
    
        componentUrl.queryItems = [runnerQueryItem, startSeasonQueryItem, endSeasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let runnerProfileResponse = try JSONDecoder().decode(MeetResultsForRunnerResponse.self, from: validData)
                print(runnerProfileResponse)
                completition(.success(runnerProfileResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchAggregateStats(completition: @escaping (Result<AggregateStatsResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/aggregateStats"
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let aggregateStatsResponse = try JSONDecoder().decode(AggregateStatsResponse.self, from: validData)
                print(aggregateStatsResponse)
                completition(.success(aggregateStatsResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
        
        
    }
    
    func fetchHistoricalMeetComparison(baseMeet: String, comparisonMeet: String, completition: @escaping (Result<HistoricalMeetComparisonResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/historicallyCompareMeets"
        
        let baseMeetQueryItem = URLQueryItem(name: "baseMeetName", value: baseMeet)
        let comparisonMeetQueryItem = URLQueryItem(name: "compareMeetName", value: comparisonMeet)
    
        componentUrl.queryItems = [baseMeetQueryItem, comparisonMeetQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let aggregateStatsResponse = try JSONDecoder().decode(HistoricalMeetComparisonResponse.self, from: validData)
                print(aggregateStatsResponse)
                completition(.success(aggregateStatsResponse))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
        
        
    }
    
    
    func fetchTimeTrialResults(season: String, scaleTo5k: String, completition: @escaping (Result<[TimeTrialResultsDTO], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/timeTrialResults"
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let scaleTo5kQueryItem = URLQueryItem(name: "filter.scaleTo5k", value: scaleTo5k)
    
        componentUrl.queryItems = [seasonQueryItem, scaleTo5kQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode([TimeTrialResultsDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchMeetInfo(completition: @escaping (Result<MeetInfoResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/getMeetNames"
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode(MeetInfoResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchPossibleRunners(season: String, filterForIsActive: Bool, completition: @escaping (Result<[Runner], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let isActiveQueryItem = URLQueryItem(name: "filter.active", value: String(filterForIsActive))
    
        componentUrl.queryItems = [seasonQueryItem, isActiveQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode([Runner].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchTimeTrialProgressions(season: String, adjustMeetDistance: String, completition: @escaping (Result<TimeTrialProgressionResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/timeTrial/progression"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let adjustQueryItem = URLQueryItem(name: "adjustForMeetDistance", value: adjustMeetDistance)
    
        componentUrl.queryItems = [seasonQueryItem, adjustQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode(TimeTrialProgressionResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchTimeTrialComparisonsForRunners(season: String, completition: @escaping (Result<[RunnerTimeTrialComparisonToPreviousYearDTO], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/timeTrialResults/compareRunnersBetweenYears"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
    
        componentUrl.queryItems = [seasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode([RunnerTimeTrialComparisonToPreviousYearDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func fetchMeetSplitsTTestForAllMeetsInSeasons(baseSeason: String, comparisonSeason: String, comparisonPace: String, completition: @escaping (Result<[TTestDTO], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetSplit/YearComparisonTTest/allMeets"
        
        
        let baseSeasonQueryItem = URLQueryItem(name: "filter.baseSeason", value: baseSeason)
        let comparisonSeasonQueryItem = URLQueryItem(name: "filter.comparisonSeason", value: comparisonSeason)
        let comparisonPaceQueryItem = URLQueryItem(name: "comparisonPace", value: comparisonPace)
    
        componentUrl.queryItems = [baseSeasonQueryItem, comparisonSeasonQueryItem, comparisonPaceQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                //let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let response = try JSONDecoder().decode([TTestDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchGoalsForRunners(runner: String, season: String, completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/forRunner"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runner)
    
        componentUrl.queryItems = [seasonQueryItem, runnerQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(RunnersGoals.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func createGoalForRunner(runner: String, season: String, goalElements: [GoalElement], completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/create"
        

        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runner)
    
        componentUrl.queryItems = [seasonQueryItem, runnerQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
           
            let json = try JSONEncoder().encode(GoalsPostBody(goals: goalElements))
            request.httpBody = json
        } catch {
            print("unable to serialize json body")
        }
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(RunnersGoals.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func deleteGoalForRunner(runner: String, season: String, goalElements: [GoalElement], completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/delete"
        

        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runner)
    
        componentUrl.queryItems = [seasonQueryItem, runnerQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
           
            let json = try JSONEncoder().encode(GoalsPostBody(goals: goalElements))
            request.httpBody = json
        } catch {
            print("unable to serialize json body")
        }
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(RunnersGoals.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func updateGoalForRunner(
        runner: String,
        season: String,
        existingGoal: GoalElement,
        updatedGoal: GoalElement,
        completition: @escaping (Result<RunnersGoals, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/update"
        

        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runner", value: runner)
    
        componentUrl.queryItems = [seasonQueryItem, runnerQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
           
            let json = try JSONEncoder().encode(UpdateGoalsPostBody(existingGoal: existingGoal, updatedGoal: updatedGoal))
            request.httpBody = json
        } catch {
            print("unable to serialize json body")
        }
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(RunnersGoals.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchMetTimeGoals(season: String, completition: @escaping (Result<NewlyMetGoalsResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/metThisSeason"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
    
        componentUrl.queryItems = [seasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(NewlyMetGoalsResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchUnmetTimeGoals(season: String, completition: @escaping (Result<RunnerToUnmetGoalsResponse, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/notMetThisSeason"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
    
        componentUrl.queryItems = [seasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(RunnerToUnmetGoalsResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchAllGoals(season: String, completition: @escaping (Result<GoalsForSeason, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/forSeason"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
    
        componentUrl.queryItems = [seasonQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(GoalsForSeason.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func fetchAllWorkouts(startDate: String, endDate: String, completition: @escaping (Result<[Workout], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/get"
        
        
        let startDateQueryItem = URLQueryItem(name: "startDate", value: startDate)
        let endDateQueryItem = URLQueryItem(name: "endDate", value: endDate)
    
        componentUrl.queryItems = [startDateQueryItem, endDateQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode([Workout].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    
    func updateWorkout(
        date: Date,
        title: String,
        description: String,
        type: String,
        pace: String,
        distance: Int,
        duration: String,
        targetCount: Int,
        uuid: UUID,
        icon: String,
        paceAdjustment: String,
        completition: @escaping (Result<Workout?, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/update"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        let dateQueryItem = URLQueryItem(name: "date", value: dateString)
        let titleQueryItem = URLQueryItem(name: "title", value: title)
        let descriptionQueryItem = URLQueryItem(name: "description", value: description)
        let typeQueryItem = URLQueryItem(name: "type", value: type)
        let durationQueryItem = URLQueryItem(name: "duration", value: duration)
        let paceQueryItem = URLQueryItem(name: "pace", value: pace)
        let targetCountQueryItem = URLQueryItem(name: "count", value: String(targetCount))
        let distanceQueryItem = URLQueryItem(name: "distance", value: String(distance))
        let iconQueryItem = URLQueryItem(name: "icon", value: icon)
        let uuidQueryItem = URLQueryItem(name: "uuid", value: uuid.uuidString)
        let paceAdjustmentQueryItem = URLQueryItem(name: "paceAdjustment", value: paceAdjustment)
    
        componentUrl.queryItems = [dateQueryItem, titleQueryItem, descriptionQueryItem, typeQueryItem, durationQueryItem, paceQueryItem, targetCountQueryItem, distanceQueryItem, iconQueryItem, uuidQueryItem, paceAdjustmentQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(Workout?.self, from: validData)
                if (response != nil) {
                    print(response!)
                }
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func createWorkout(
        workout: Workout,
        completition: @escaping (Result<WorkoutResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/create"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: workout.date)
        
        let dateQueryItem = URLQueryItem(name: "date", value: dateString)
        let titleQueryItem = URLQueryItem(name: "title", value: workout.title)
        let descriptionQueryItem = URLQueryItem(name: "description", value: workout.description)
        let typeQueryItem = URLQueryItem(name: "type", value: workout.type)
        let durationQueryItem = URLQueryItem(name: "duration", value: workout.duration)
        let paceQueryItem = URLQueryItem(name: "pace", value: workout.pace)
        let targetCountQueryItem = URLQueryItem(name: "count", value: String(workout.targetCount))
        let distanceQueryItem = URLQueryItem(name: "distance", value: String(workout.targetDistance))
        let iconQueryItem = URLQueryItem(name: "icon", value: workout.icon)
        let uuidQueryItem = URLQueryItem(name: "uuid", value: workout.uuid.uuidString)
        let paceAdjustmentQueryItem = URLQueryItem(name: "paceAdjustment", value: workout.paceAdjustment)
        
    
        componentUrl.queryItems = [dateQueryItem, titleQueryItem, typeQueryItem, durationQueryItem, paceQueryItem, descriptionQueryItem, targetCountQueryItem, distanceQueryItem, iconQueryItem, uuidQueryItem, paceAdjustmentQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(WorkoutResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func deleteWorkout(
        workout: Workout,
        completition: @escaping (Result<Workout, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/delete"
        
        let uuidQueryItem = URLQueryItem(name: "uuid", value: workout.uuid.uuidString)
        
        componentUrl.queryItems = [uuidQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(Workout.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getWorkoutPlan(
        workout: Workout,
        completition: @escaping (Result<WorkoutPlanResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/plan"
        
        let uuidQueryItem = URLQueryItem(name: "uuid", value: workout.uuid.uuidString)
        
        componentUrl.queryItems = [uuidQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(WorkoutPlanResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func authenticateUser(
        credentials: Credentials,
        completition: @escaping (Result<AuthenticationResponse, Authentication.AuthenticationError>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/authenticate"
        
        let usernameQueryItem = URLQueryItem(name: "username", value: credentials.username)
        let passwordQueryItem = URLQueryItem(name: "password", value: credentials.password)
        
        componentUrl.queryItems = [usernameQueryItem, passwordQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(.invalidCredentials))
                return
            }
            
            print(validData)
            
            do {
                let response = try JSONDecoder().decode(AuthenticationResponse.self, from: validData)
                print(response)

                if (response.authenticated) {
                    completition(.success(response))
                } else {
                    completition(.failure(.invalidCredentials))
                }
                
               
            } catch _ {
                completition(.failure(.invalidCredentials))
            }
            
        }.resume()
    }
    
    func updateRunner(
        name: String,
        runnerId: Int,
        graduatingClass: String,
        isActive: Bool,
        completition: @escaping (Result<Runner?, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners/update"
        
        let runnerIdQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
       
    
        componentUrl.queryItems = [runnerIdQueryItem]
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
           
            let json = try JSONEncoder().encode(RunnerRequestBody(name: name, graduatingClass: graduatingClass, active: isActive))
            request.httpBody = json
        } catch {
            print("unable to serialize json body")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
       
                let response = try JSONDecoder().decode(Runner?.self, from: validData)
                if (response != nil) {
                    print(response!)
                }
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func createRunner(
        name: String,
        graduatingClass: String,
        isActive: Bool,
        completition: @escaping (Result<Runner?, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners/create"
        
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
           
            let json = try JSONEncoder().encode(RunnerRequestBody(name: name, graduatingClass: graduatingClass, active: isActive))
            request.httpBody = json
        } catch {
            print("unable to serialize json body")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
       
                let response = try JSONDecoder().decode(Runner?.self, from: validData)
                if (response != nil) {
                    print(response!)
                }
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
}
