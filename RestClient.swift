//
//  RestClient.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 04.08.2024.
//

import UIKit

class RestClient {

    func makeGetRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error.")
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
