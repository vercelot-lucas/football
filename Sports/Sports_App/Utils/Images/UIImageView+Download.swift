//
//  UIImageView+Download.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    enum ImageDownloadError: Error {
        case downloadError
        case dataError
    }
    
    func setImageFromURL(_ url: URL, completion: @escaping (Result<UIImage?, ImageDownloadError>) -> Void) {
        
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            
            guard error == nil else {
                completion(.failure(.downloadError))
                return
            }
            
            if let httpURLResponse = urlResponse as? HTTPURLResponse,
               httpURLResponse.statusCode != 200 {
                completion(.failure(.downloadError))
                return
            }
            
            guard let localURL = localURL,
                  let imageData = try? Data(contentsOf: localURL) else {
                      completion(.failure(.dataError))
                      return
                  }
            
            let image = UIImage(data: imageData)
            completion(.success(image))
        }
        task.resume()
    }
}
