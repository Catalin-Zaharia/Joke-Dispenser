//
//  DogsView.swift
//  app1
//
//  Created by user217573 on 4/6/22.
//

import SwiftUI

import UIKit
import AVKit

struct Content: Codable{
    var url: String
}

struct DogsView: View {
    @State private var player = AVPlayer()
    @State private var contentUrl : String = "..."
    var body: some View {
        let ext = contentUrl.components(separatedBy: ".")[2]
        if ext == "mp4" {
            VideoPlayer(player: player)
                .onAppear() {
                    player = AVPlayer(url: URL(string: contentUrl)!)
                    player.play()
                }
                .task {
                    await loadData()
                    print(ext)
                }
            }
        
        else{
            AsyncImage(
                    url: URL(string: contentUrl),
                    content: {image in
                        image.resizable()
                        .aspectRatio(contentMode: .fit)
                        },
                    placeholder:{
                        ProgressView()
                    }
                            )
            .task {
                await loadData()
                print(ext)
            }
        }
        
    }
        
    func showText(text: String) {
        print(text)
    }
    
    func loadData() async {
        let urlstring3 = "https://random.dog/woof.json"
        
        guard let url = URL(string: urlstring3) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            contentUrl = try! JSONDecoder().decode(Content.self, from: data).url
        }
        catch{
            print("Invalid data")
        }
    }
        
}

struct DogsView_Previews: PreviewProvider {
    static var previews: some View {
        DogsView()
    }
}
