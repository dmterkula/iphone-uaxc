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
    
    func getBackEndAppInfo(
        completition: @escaping (Result<BackEndInfoDTO, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/actuator/info"
        
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
                let response = try JSONDecoder().decode(BackEndInfoDTO.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
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
    
    func fetchRunnerProfileV2(runnerId: Int, season: String, completition: @escaping (Result<RunnerProfileDTOV2, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runnerProfileV2/"
        
        
        let runnerQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
        let seasonQueryItem = URLQueryItem(name: "season", value: season)
        
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
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let runnerProfileResponse = try decoder.decode(RunnerProfileDTOV2.self, from: validData)
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
    
    func fetchGoalsForRunnersV2(runnerId: Int, season: String, completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/getV2"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runnerId", value: String(runnerId))
        
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
    
    func createGoalForRunnerV2(runnerId: Int, season: String, goalElements: [GoalElement], completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/createV2"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runnerId", value: String(runnerId))
        
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
    
    func deleteGoalForRunnerV2(runnerId: Int, season: String, goalElements: [GoalElement], completition: @escaping (Result<RunnersGoals, Error>) -> Void) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/goals/deleteV2"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let runnerQueryItem = URLQueryItem(name: "filter.runnerId", value: String(runnerId))
        
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
        workout: Workout,
        completition: @escaping (Result<Workout, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/update"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: workout.date)
        
        let idQueryItem = URLQueryItem(name: "workoutUUID", value: workout.uuid.uuidString)
        
        
        componentUrl.queryItems = [idQueryItem]
        
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
            
            let requestBody = CreateWorkoutRequest(date: dateString, title: workout.title, description: workout.description, icon: workout.icon, uuid: workout.uuid.uuidString, components: workout.components.map{ ComponentCreationElement(description: $0.description, type: $0.type, pace: $0.pace, targetDistance: $0.targetDistance, targetCount: $0.targetCount, targetPaceAdjustment: $0.targetPaceAdjustment, uuid: $0.uuid.uuidString) })
            
            let json = try JSONEncoder().encode(requestBody)
            request.httpBody = json
            print(json)
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
    
    
    func createWorkout(
        workout: Workout,
        completition: @escaping (Result<Workout, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/create"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: workout.date)
        
        
        
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
            
            let requestBody = CreateWorkoutRequest(date: dateString, title: workout.title, description: workout.description, icon: workout.icon, uuid: workout.uuid.uuidString, components: workout.components.map{ ComponentCreationElement(description: $0.description, type: $0.type, pace: $0.pace, targetDistance: $0.targetDistance, targetCount: $0.targetCount, targetPaceAdjustment: $0.targetPaceAdjustment, uuid: $0.uuid.uuidString) })
            
            let json = try JSONEncoder().encode(requestBody)
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
    
    func deleteWorkout(
        uuid: String,
        completition: @escaping (Result<WorkoutResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/delete"
        
        let uuidQueryItem = URLQueryItem(name: "uuid", value: uuid)
        
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
                let response = try decoder.decode(WorkoutResponse.self, from: validData)
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
    
    
    func createSplit(
        runnerId: Int,
        componentUUID: String,
        splits: [Split],
        completition: @escaping (Result<SplitsResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/split/create"
        
        
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
            let json = try JSONEncoder().encode(CreateSplitsRequest(runnerId: runnerId, componentUUID: componentUUID, splits: splits))
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
                
                let response = try JSONDecoder().decode(SplitsResponse.self, from: validData)
                print(response)
                
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func getSplits(
        runnerId: Int,
        componentUUID: String,
        completition: @escaping (Result<SplitsResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/splits/get"
        
        
        let runnerIdQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
        let componentUUIDQueryItem = URLQueryItem(name: "componentUuid", value: String(componentUUID))
        
        componentUrl.queryItems = [runnerIdQueryItem, componentUUIDQueryItem]
        
        
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
                let response = try JSONDecoder().decode(SplitsResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func deleteSplit(
        split: SplitElement,
        completition: @escaping (Result<SplitsResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/split/delete"
        
        let uuidQueryItem = URLQueryItem(name: "uuid", value: split.uuid)
        
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
                let response = try JSONDecoder().decode(SplitsResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getWorkoutComponentResults(
        componentUUID: String,
        completition: @escaping (Result<WorkoutComponentSplitsResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/componentResults/get"
        
        
        let componentUUIDQueryItem = URLQueryItem(name: "componentUuid", value: String(componentUUID))
        
        componentUrl.queryItems = [componentUUIDQueryItem]
        
        
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
                let response = try JSONDecoder().decode(WorkoutComponentSplitsResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func logRunnersWorkoutResults(
        runnerId: Int,
        workoutUuid: String,
        totalDistance: Double,
        componentUuidToSplits: [String: [Split]],
        completition: @escaping (Result<ARunnersWorkoutResultsResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/runner-result/put"
        
        
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
            let json = try JSONEncoder().encode(LogWorkoutRequest(runnerId: runnerId, workoutUuid: workoutUuid, totalDistance: totalDistance, componentsSplits: componentUuidToSplits.map{LogComponentsSplitsRequest(componentUUID: $0.key, splits: $0.value)}))
            
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
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(ARunnersWorkoutResultsResponse.self, from: validData)
                print(response)
                
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getARunnersWorkoutResults(
        workoutUuid: String,
        runnerId: Int,
        completition: @escaping (Result<ARunnersWorkoutResultsResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/workout/runner-result/get"
        
        
        let workoutUuidQueryItem = URLQueryItem(name: "workoutUuid", value: workoutUuid)
        let runnerIdQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
        
        componentUrl.queryItems = [workoutUuidQueryItem, runnerIdQueryItem]
        
        
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
                let response = try decoder.decode(ARunnersWorkoutResultsResponse.self, from: validData)
                print(response)
                
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getMeetsForSeason(
        season: String,
        completition: @escaping (Result<[Meet], Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meets/getBySeason"
        
        
        let seasonQueryItem = URLQueryItem(name: "season", value: String(season))
        
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
                let response = try JSONDecoder().decode([Meet].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func getMeetsBetweenDates(
        startDate: Date,
        endDate: Date,
        completition: @escaping (Result<[Meet], Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meets/getByDates"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        let startDateQueryItem = URLQueryItem(name: "startDate", value: startDateString)
        let endDateQueryItem = URLQueryItem(name: "endDate", value: endDateString)
        
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
                let response = try decoder.decode([Meet].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func createMeet(
        meetEvent: MeetEvent,
        completition: @escaping (Result<Meet, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meets/create"
        
        
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
            let json = try JSONEncoder().encode(CreateMeetRequest(name: meetEvent.title, date: meetEvent.date.getDateNoTimeString(), uuid: meetEvent.uuid, icon: meetEvent.icon))
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
                
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(Meet.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func updateMeet(
        meetEvent: MeetEvent,
        completition: @escaping (Result<Meet, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meets/update"
        
        
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
            let json = try JSONEncoder().encode(CreateMeetRequest(name: meetEvent.title, date: meetEvent.date.getDateNoTimeString(), uuid: meetEvent.uuid, icon: meetEvent.icon))
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
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(Meet.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getTrainingRunsBetweenDates(
        startDate: Date,
        endDate: Date,
        completition: @escaping (Result<TrainingRunResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/training-run/get"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        let startDateQueryItem = URLQueryItem(name: "startDate", value: startDateString)
        let endDateQueryItem = URLQueryItem(name: "endDate", value: endDateString)
        
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
                let response = try decoder.decode(TrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func createTrainingRun(
        trainingRunEvent: TrainingRunEvent,
        completition: @escaping (Result<TrainingRunResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/training-run/create"
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var timeValue: String? = nil
        var distanceValue: Double? = nil
        
        
        if (trainingRunEvent.time != nil && trainingRunEvent.time != "00:00") {
            timeValue = trainingRunEvent.time
        }
        
        if (trainingRunEvent.distance != nil && trainingRunEvent.distance != 0.0) {
            distanceValue = trainingRunEvent.distance
        }
        
        do {
            let json = try JSONEncoder().encode(CreateTrainingRunRequest(uuid: trainingRunEvent.uuid, date: trainingRunEvent.date.getDateNoTimeString(), time: timeValue, distance: distanceValue, icon: trainingRunEvent.icon, name: trainingRunEvent.title))
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
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(TrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func updateTrainingRun(
        trainingRunEvent: TrainingRunEvent,
        completition: @escaping (Result<TrainingRunResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/training-run/update"
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var timeValue: String? = nil
        var distanceValue: Double? = nil
        
        if (trainingRunEvent.time != nil && trainingRunEvent.time != "00:00") {
            timeValue = trainingRunEvent.time
        }
        
        if (trainingRunEvent.distance != nil && trainingRunEvent.distance != 0.0) {
            distanceValue = trainingRunEvent.distance
        }
        
        do {
            let json = try JSONEncoder().encode(CreateTrainingRunRequest(uuid: trainingRunEvent.uuid, date: trainingRunEvent.date.getDateNoTimeString(), time: timeValue, distance: distanceValue, icon: trainingRunEvent.icon, name: trainingRunEvent.title))
            request.httpBody = json
            request.httpBody?.printAsJSON()
            request.allHTTPHeaderFields?.printAsJSON()
            print(request.httpMethod)
        } catch {
            print("unable to serialize json body")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                data?.printAsJSON()
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                data?.printAsJSON()
                completition(.failure(error!))
                return
            }
            
            print(validData)
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode(TrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func deleteTrainingRun(
        uuid: String,
        completition: @escaping (Result<TrainingRunResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/training-run/delete"
        
        let uuidComponent = URLQueryItem(name: "uuid", value: uuid)
        componentUrl.queryItems = [uuidComponent]
        
        
        guard let validURL = componentUrl.url else {
            print("failed to create url")
            return
        }
        
        print(validURL)
        
        var request = URLRequest(url: validURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
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
                let response = try decoder.decode(TrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func getRunnersTrainingRun(
        runnerId: Int,
        trainingRunUUID: String,
        completition: @escaping (Result<RunnerTrainingRunResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners-training-run-result"
        
        let runnerIdQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
        let trainingRunUUIDQueryItem = URLQueryItem(name: "trainingRunUUID", value: trainingRunUUID)
        
        componentUrl.queryItems = [runnerIdQueryItem, trainingRunUUIDQueryItem]
        
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
                let response = try decoder.decode(RunnerTrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getAllTrainingRunResultsForGivenPractice(
        trainingRunUUID: String,
        completition: @escaping (Result<RunnerTrainingRunResponse, Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/all-runners-training-run-results/get"
        
        let trainingRunUUIDQueryItem = URLQueryItem(name: "trainingRunUUID", value: trainingRunUUID)
        
        componentUrl.queryItems = [trainingRunUUIDQueryItem]
        
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
                let response = try decoder.decode(RunnerTrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func logTrainingRun(
        viewModel: RunnersTrainingRunFormViewModel,
        completition: @escaping (Result<RunnerTrainingRunResponse, Error>) -> Void
    ) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners-training-run/create"
        
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
            let json = try JSONEncoder().encode(CreateRunnersTrainingRunRequest(uuid: viewModel.uuid, trainingRunUUID: viewModel.trainingRunUuid, runnerId: viewModel.runner.runnerId, time: viewModel.getTimeString(), distance: viewModel.calcDistance(), avgPace: viewModel.calcAveragePace()))
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
                let decoder = JSONDecoder()
                let response = try decoder.decode(RunnerTrainingRunResponse.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    
    func getPRLeaderboard(
        pageSize: Int,
        completition: @escaping (Result<[RankedPRDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/prs"
        
        let pageSizeQueryItem = URLQueryItem(name: "page.size", value: String(pageSize))
        
        componentUrl.queryItems = [pageSizeQueryItem]
        
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
                let response = try decoder.decode([RankedPRDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getRankedSplitConsistencyLeaderboard(
        season: String,
        completition: @escaping (Result<[RankedSplitConsistencyDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/race-consistency"
        
        let seasonQueryItem = URLQueryItem(name: "season", value: season)
        
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
                let decoder = JSONDecoder()

                let response = try decoder.decode([RankedSplitConsistencyDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getSBLeaderboard(
        season: String,
        completition: @escaping (Result<[RankedSBDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/sbs"
        
        let seasonQueryItem = URLQueryItem(name: "season", value: season)
        
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
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let response = try decoder.decode([RankedSBDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getTrainingDistanceLeaderboard(
        season: String?,
        page: Int?,
        completition: @escaping (Result<[RankedRunnerDistanceRunDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/distance-run"
        
        var queryItems: [URLQueryItem] = []
        
        if (page != nil) {
            queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
        }
        
        if (season != nil) {
            queryItems.append(URLQueryItem(name: "season", value: season))
        }
        
        componentUrl.queryItems = queryItems
      
        
        
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
                let response = try decoder.decode([RankedRunnerDistanceRunDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getRunnersTrainingSummary(
        season: String,
        runnerId: Int,
        timeFrame: String,
        completition: @escaping (Result<[TrainingSummaryDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/training-run/runner-summary"
        
        
        let seasonQueryItem = URLQueryItem(name: "season", value: season)
        let runnerIdQueryItem = URLQueryItem(name: "runnerId", value: String(runnerId))
        let timeFrameQueryItem = URLQueryItem(name: "timeFrame", value: timeFrame)
        
        
        componentUrl.queryItems = [seasonQueryItem, runnerIdQueryItem, timeFrameQueryItem]
        
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
                let response = try decoder.decode([TrainingSummaryDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getTotalMeetResults(
        season: String,
        meetName: String,
        completition: @escaping (Result<[RunnerTotalMeetPerformanceDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetResults"
        
        
        let seasonQueryItem = URLQueryItem(name: "filter.season", value: season)
        let meetQueryItem = URLQueryItem(name: "filter.meetName", value: meetName)
      
        
        
        componentUrl.queryItems = [seasonQueryItem, meetQueryItem]
        
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
                let response = try decoder.decode([RunnerTotalMeetPerformanceDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func createRunnersTotalMeetResults(
        createRunnerResultsRequest: CreateRunnersTotalMeetResultsRequest,
        completition: @escaping (Result<[RunnerTotalMeetPerformanceDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetResults/createForRunner"
        
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
            let json = try JSONEncoder().encode(createRunnerResultsRequest)
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
                let decoder = JSONDecoder()
                let response = try decoder.decode([RunnerTotalMeetPerformanceDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func getTotalSkullsLeaderboard(
        season: String?,
        page: Int?,
        completition: @escaping (Result<[RankedAchievementDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/total-skulls"
        
        
        var queryItems: [URLQueryItem] = []
        
        if (page != nil) {
            queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
        }
        
        if (season != nil) {
            queryItems.append(URLQueryItem(name: "season", value: season))
        }
        
        componentUrl.queryItems = queryItems
        
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
                let response = try decoder.decode([RankedAchievementDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getSkullsStreakLeaderboard(
        season: String?,
        page: Int?,
        active: Bool?,
        completition: @escaping (Result<[RankedAchievementDTO], Error>) -> Void
    ) {
        
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/leaderboard/skull-streak"
        
        
        var queryItems: [URLQueryItem] = []
        
        if (page != nil) {
            queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
        }
        
        if (active != nil) {
            queryItems.append(URLQueryItem(name: "active", value: String(active!)))
        }
        
        if (season != nil) {
            queryItems.append(URLQueryItem(name: "season", value: season))
        }
        
        componentUrl.queryItems = queryItems
      
        
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
                let response = try decoder.decode([RankedAchievementDTO].self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
    func getTotalPassesThirdMileLeaderboard(
            season: String?,
            page: Int?,
            completition: @escaping (Result<[RankedAchievementDTO], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/leaderboard/passes-last-mile"
            
            
            var queryItems: [URLQueryItem] = []
            
            if (page != nil) {
                queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
            }
            
            if (season != nil) {
                queryItems.append(URLQueryItem(name: "season", value: season))
            }
            
            componentUrl.queryItems = queryItems
          
            
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
                    let response = try decoder.decode([RankedAchievementDTO].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func getRaceSplitConsistencyAchievementLeaderboard(
            season: String?,
            page: Int?,
            completition: @escaping (Result<[RankedAchievementDTO], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/leaderboard/consistent-race-splits-achievement"
            
            
            var queryItems: [URLQueryItem] = []
            
            if (page != nil) {
                queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
            }
            
            if (season != nil) {
                queryItems.append(URLQueryItem(name: "season", value: season))
            }
            
            componentUrl.queryItems = queryItems
          
            
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
                    let response = try decoder.decode([RankedAchievementDTO].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func getLoggedRunCountAchievementLeaderboard(
            season: String?,
            page: Int?,
            completition: @escaping (Result<[RankedAchievementDTO], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/leaderboard/logged-run-count"
            
            
            var queryItems: [URLQueryItem] = []
            
            if (page != nil) {
                queryItems.append(URLQueryItem(name: "page.size", value: String(page!)))
            }
            
            if (season != nil) {
                queryItems.append(URLQueryItem(name: "season", value: season))
            }
            
            componentUrl.queryItems = queryItems
          
            
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
                    let response = try decoder.decode([RankedAchievementDTO].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func updateCredentials(
            username: String,
            newUsername: String,
            password: String,
            completition: @escaping (Result<ChangeLoginResponse, Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/authenticate/change-credentials"
            
            
            var queryItems: [URLQueryItem] = []
            
            
            queryItems.append(URLQueryItem(name: "username", value: username))
            queryItems.append(URLQueryItem(name: "newUsername", value: newUsername))
            queryItems.append(URLQueryItem(name: "password", value: password))
            
            
            componentUrl.queryItems = queryItems
          
            
            guard let validURL = componentUrl.url else {
                print("failed to create url")
                return
            }
            
            print(validURL)
            
            var request = URLRequest(url: validURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("API status: \(httpResponse.statusCode)")
                }
                
                guard let validData = data, error == nil else {
                    completition(.failure(error!))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let response = try decoder.decode(ChangeLoginResponse.self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func getAllExistingUserNames(
            completition: @escaping (Result<[String], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/authenticate/get-all-usernames"
            
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
                    let response = try decoder.decode([String].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    
    func getRunnersWithoutAccountForSeason(
            season: String,
            completition: @escaping (Result<[Runner], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/appUsers/runnersWithoutAccount"
            
            var queryItems: [URLQueryItem] = []
            
            
            queryItems.append(URLQueryItem(name: "season", value: season))
            
            componentUrl.queryItems = queryItems
            
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
                
                do {
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let response = try decoder.decode([Runner].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func getAllRunnerAccounts(
            completition: @escaping (Result<[RunnerAccount], Error>) -> Void
        ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/appUsers/runners"
            
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
                    let response = try decoder.decode([RunnerAccount].self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func deleteAppUser(
        createAppUserRequest: CreateAppUserRequest,
        completition: @escaping (Result<AppUser, Error>) -> Void
    ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/appUsers/delete"
            
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
                
                let json = try JSONEncoder().encode(createAppUserRequest)
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
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let response = try decoder.decode(AppUser.self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func createAppUser(
        createAppUserRequest: CreateAppUserRequest,
        completition: @escaping (Result<AppUser, Error>) -> Void
    ) {
            
            var componentUrl = URLComponents()
            componentUrl.scheme = "https"
            componentUrl.host = baseUrlString
            componentUrl.path = "/xc/appUsers/create"
            
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
                
                let json = try JSONEncoder().encode(createAppUserRequest)
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
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let response = try decoder.decode(AppUser.self, from: validData)
                    print(response)
                    completition(.success(response))
                } catch let serializationError {
                    completition(.failure(serializationError))
                }
                
            }.resume()
                
        }
    
    func getPersonalizedSplitsDTO(
        runnerId: Int,
        lastNRaces: Int?,
        inputTime: String,
        completition: @escaping (Result<PersonalizedSplitDTO, Error>) -> Void
    ) {
            
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/meetSplit/personalized"
    
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: "runnerId", value: String(runnerId)))
        queryItems.append(URLQueryItem(name: "time", value: inputTime))
  
        if (lastNRaces != nil) {
            queryItems.append(URLQueryItem(name: "lastNRaces", value: String(lastNRaces!)))
        }
        
        componentUrl.queryItems = queryItems
        
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
                let response = try decoder.decode(PersonalizedSplitDTO.self, from: validData)
                print(response)
                completition(.success(response))
            } catch let serializationError {
                completition(.failure(serializationError))
            }
            
        }.resume()
            
    }
    
}
