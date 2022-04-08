//
//  JokeView.swift
//  app1
//
//  Created by user217573 on 4/6/22.
//

import SwiftUI

struct Twopart: Codable{
    var setup : String
    var delivery : String
}


struct Single: Codable{
    var joke: String
}

struct JokeView: View {
    let jokeType: String
    
    @State private var joke = "this is where the joke will be"
    
    var body: some View {
        
        Text(joke).font(.headline).task {
            await loadData()
        }
        
    }
    
    func loadData() async {
        let urlstring3 = "https://v2.jokeapi.dev/joke/Any?type="+jokeType
        print(urlstring3)
        
        guard let url = URL(string: urlstring3) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if jokeType == "single" {
                joke = try! JSONDecoder().decode(Single.self, from: data).joke
            }
            else {
                let decoded = try! JSONDecoder().decode(Twopart.self, from: data)
                joke = decoded.setup + "\n\n" + decoded.delivery
            }
            
            
        }
        catch{
            print("Invalid data")
        }
    }
    
    
}



struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JokeView(jokeType: "single").previewInterfaceOrientation(.portrait)
        }
    }
}

