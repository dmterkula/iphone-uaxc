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
    
    func fetchPossibleRunners(season: String, completition: @escaping (Result<[Runner], Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "https"
        componentUrl.host = baseUrlString
        componentUrl.path = "/xc/runners"
        
        
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
    
}
