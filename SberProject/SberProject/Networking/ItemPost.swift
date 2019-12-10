//
//  ItemPost.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 06.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

typealias Parameters = [String: String]
 let secondVC = TableViewController()

enum ItemsError:Error {
    case noDataAvailable
    case canNotProcData
}

class ItemPost {
    func Post(withmedia image:UIImage, completion: @escaping(Result<[Items], ItemsError>) -> Void) {
        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }

        guard let url = URL(string: "http://89.108.90.8:5001/photo") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = generateBoundary()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let dataBody = createDataBody(withParameters: nil, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
        }
        
            if let data = data {
                do {
                    print(data)
                    let json = try JSONDecoder().decode(JSData.self, from: data)
                    print(json)
                    let jsonData = json.data
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(.canNotProcData))
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
                        secondVC.present(alert, animated: true, completion: nil)
                    }
                }
            }
            }.resume()
    }
    
    func PostID(withparameter parameter:String, completion: @escaping(Result<SingleItem, ItemsError>) -> Void) {
        
        let parameters = ["itemID":parameter]
      //  guard let mediaImage = Media(withImage: #imageLiteral(resourceName: "testImage"), forKey: "file") else { return }
        
        guard let url = URL(string: "http://89.108.90.8:5001/item") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = generateBoundary()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let dataBody = createDataBody(withParameters: parameters, media: nil, boundary: boundary)
        request.httpBody = dataBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
        }
        
            if let data = data {
                print(data)
                do {
                    let json = try JSONDecoder().decode(JSSingleData.self, from: data)
                    let jsonData = json.data
                    print(jsonData)
                    completion(.success(jsonData))
                } catch {
                    
                    completion(.failure(.canNotProcData))
                    print(error)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    }
                   
                }
            }
            }.resume()
    }

    func generateBoundary() -> String {
           return "Boundary-\(NSUUID().uuidString)"
       }
       
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
              
              let lineBreak = "\r\n"
              var body = Data()
              if let parameters = params {
                  for (key, value) in parameters {
                      body.append("--\(boundary + lineBreak)")
                      body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                      body.append("\(value + lineBreak)")
                  }
              }
              
              if let media = media {
                  for photo in media {
                      body.append("--\(boundary + lineBreak)")
                      body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                      body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                      body.append(photo.data)
                      body.append(lineBreak)
                  }
              }
              body.append("--\(boundary)--\(lineBreak)")
              return body
          }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
