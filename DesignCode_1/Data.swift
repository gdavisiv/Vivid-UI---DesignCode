//
//  Data.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/5/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPost(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Come back to FULL understand the importance of this!! and Comment it!
        //This is about optionals and working with APIs
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    .resume()
    }
}
