//
//  DataService.swift
//  TestProject
//
//  Created by David  Terkula on 8/23/22.
//

import Foundation

class DataService {
    static let dataService = DataService()
    fileprivate let baseUrlString = "http://ec2-3-14-8-216.us-east-2.compute.amazonaws.com"
    
    func fetchPRs(lastIncludedGradClass: String, completition: @escaping (Result<PRDTO, Error>) -> Void) {
        var componentUrl = URLComponents()
        componentUrl.scheme = "http"
        componentUrl.host = "ec2-3-14-8-216.us-east-2.compute.amazonaws.com"
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
        componentUrl.scheme = "http"
        componentUrl.host = "ec2-3-14-8-216.us-east-2.compute.amazonaws.com"
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
        componentUrl.scheme = "http"
        componentUrl.host = "ec2-3-14-8-216.us-east-2.compute.amazonaws.com"
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
        componentUrl.scheme = "http"
        componentUrl.host = "ec2-3-14-8-216.us-east-2.compute.amazonaws.com"
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
    
}
