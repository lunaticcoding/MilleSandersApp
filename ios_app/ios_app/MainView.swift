//
//  main.swift
//  ios_app
//
//  Created by Marco  Papula on 04.05.20.
//  Copyright © 2020 Marco  Papula. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            TabView{
                
                IntroductionView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("First Tab")
                }
                
                Text("The content of the second view")
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Second Tab")
                }
            }
            .navigationBarItems(leading: Text("Mille Sanders"), trailing: HStack{
                SocialMediaButton(icon: "facebook", url: "https://www.facebook.com/millesandersaustria/")
                
                SocialMediaButton(icon: "linkedin", url: "https://www.linkedin.com/company/millesanders-com")
                
                SocialMediaButton(icon: "pinterest", url: "https://www.pinterest.at/millesanders/")
                
                SocialMediaButton(icon: "instagram", url: "https://www.instagram.com/mille_sanders/")
            })
        }
        
    }
}

struct main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct SocialMediaButton : View {
    let icon: String
    let url: String

    var body: some View{
        Image(icon)
            .resizable()
            .scaledToFill()
            .frame(height: 15)
            .onTapGesture {
                if let url = URL(string: self.url) {
                    UIApplication.shared.open(url)
                }
        }
    }
    
}

