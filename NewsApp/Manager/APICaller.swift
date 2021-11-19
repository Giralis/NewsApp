//
//  APICaller.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 18.11.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=e0b6bb7250244beab03ec24c16d1b412")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
