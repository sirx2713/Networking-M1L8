//
//  ContentView.swift
//  Networking M1L6
//
//  Created by Chris Ching on 2023-08-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            
            Task {
                await apiCall()
            }
            
        }
    }
    
    func apiCall() async {
        
        // 1. URL
        if let url = URL(string: "https://api.pexels.com/v1/search?query=trees&per_page=1") {
            
            // 2. URLRequest
            var request = URLRequest(url: url)
            request.addValue("PWUp6sAtMGRrY1HPn8r6nOw8qOCdsc136yAdSyL6Y5m1WEDSc2cCitjh", forHTTPHeaderField: "Authorization")
            
            // 3. URLSession
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // 4. Parse the JSON
                let decoder = JSONDecoder()
                do {
                   let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    
                    for photo in searchResponse.photos {
                        print(photo)
                    }
                }
                catch {
                    print(error)
                }
            }
            catch {
                print(error)
            }
            
        }
        
        
    }
}

