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
                    Image("millesanderslogo")
                    .font(.system(size: 22, weight: .medium))
                }
               
                Text("The content of the second view")
                .tabItem {
                    Image("noun_blog")
                    .font(.system(size: 22, weight: .medium))
                }
                
                DeckSelectionView()
                .tabItem {
                    Image("noun_overview")
                    .font(.system(size: 22, weight: .medium))
                }
                
                Text("The content of the second view")
                .tabItem {
                    Image("noun_shop")
                    .font(.system(size: 22, weight: .medium))
                }
                
                Text("The content of the second view")
                .tabItem {
                    Image(systemName: "info.circle")
                    .font(.system(size: 20, weight: .medium))
                }
            
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading:
        
                Text("Mille Sanders").font(.custom("BebasNeue-Regular", size: 18)),
                                
                trailing: HStack{
                    
                    SocialMediaButton(icon: "facebook", url: "https://www.facebook.com/millesandersaustria/")
                    
                    SocialMediaButton(icon: "linkedin", url: "https://www.linkedin.com/company/millesanders-com")
                    
                    SocialMediaButton(icon: "pinterest", url: "https://www.pinterest.at/millesanders/")
                    
                    SocialMediaButton(icon: "instagram", url: "https://www.instagram.com/mille_sanders/")
                }
            )
        
        }.accentColor(Color.black)
    
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
    let width: CGFloat? = nil
    let height: CGFloat? = 15

    var body: some View{
        Image(icon)
            .resizable()
            .scaledToFill()
            .frame(height: self.height)
            .onTapGesture {
                if let url = URL(string: self.url) {
                    UIApplication.shared.open(url)
                }
            }
    }
}

