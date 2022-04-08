//
//  RootView.swift
//  app1
//
//  Created by user217573 on 4/6/22.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { granted, error in
            
            if error != nil {
                print("error")
            }
            else {
                print("success")
                
            }
        }
    }

    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "wanna hear a joke?"
        content.subtitle = "click me"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 43200, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        print("scheduled")
    }
    
}


struct RootView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                VStack(spacing: 40){
                                    
                    NavigationLink(destination: JokeView(jokeType: "single")){
                        Text("one-liner").font(.headline)
                    }
                    
                    
                    NavigationLink(destination: JokeView(jokeType: "twopart")){
                        Text("two-liner").font(.headline)
                    }
                    
                    NavigationLink(destination: DogsView() ){
                        Text("dogs").font(.headline)
                    }
                }
                
                Spacer()
                
            }
            
        }
        .onAppear(){
            NotificationManager.instance.requestAuthorization()
            NotificationManager.instance.scheduleNotification()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
