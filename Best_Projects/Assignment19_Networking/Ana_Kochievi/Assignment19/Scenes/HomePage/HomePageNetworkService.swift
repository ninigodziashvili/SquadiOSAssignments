//
//  HomePageNetworkService.swift
//  Assignment19
//
//  Created by MacBook on 31.10.24.
//

import Foundation

enum CustomErrors: Error {
    case wrongResponse
    case statusCode
}

final class NetworkService {
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomErrors.wrongResponse))
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(CustomErrors.wrongResponse))
                
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(CustomErrors.statusCode))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomErrors.wrongResponse))
                
                return
            }
            
            do {
                let newsResponseData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newsResponseData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
