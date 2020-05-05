//
//  IntroductionView.swift
//  ios_app
//
//  Created by Marco  Papula on 04.05.20.
//  Copyright © 2020 Marco  Papula. All rights reserved.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        ScrollView{
            Image("DuHastDenWillen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 10.0)
            
            VStack(alignment: .leading) {
                Text("Danke, dass du Teil unserer Community bist!\n")

                Text("Mille Sanders dreht sich rund um die Themen ") +
                    Text("Organisation, Produktivität und Planung.\n").bold()
                
                Text("Es geht um deine ") +
                Text("Träume und Ziele. ").bold() +
                Text("Wir wollen dich motivieren, diese zu erreichen und ") +
                    Text("dir hilfreiche Tools dafür zur Verfügung stellen.\n").bold()
                
                (Text("In unserem Sitz ") +
                Text("in Tirol ") +
                Text("designen wir einige unserer Produkte und verwalten von dort aus auch unseren Shop."))
                
                VStack(alignment: .leading) {
                    IconBulletPoint(icon: "hand.raised", text:  "handverlesenes Sortiment")
                        
                    IconBulletPoint(icon: "person.2", text:  "persöhnliche Beratung")
                    
                    IconBulletPoint(icon: "paperplane", text:  "Versand nach DE und AT")
                    
                    IconBulletPoint(icon: "leaf.arrow.circlepath", text:  "klein & nachhaltig")
                    
                }
                .padding(.horizontal, 40.0)
                .padding(.bottom, 15)
                .padding(.top, 10)
                
            }.padding(.horizontal, 20.0)
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            
            HStack{
                Text("Kontakt")
                    .font(.system(size: 18))

                Image(systemName: "message.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        if let url = URL(string: "http://m.me/millesandersaustria") {
                            UIApplication.shared.open(url)
                        }
                    }
                
                Image(systemName: "envelope.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        if let url = URL(string: "mailto:contact@millesanders.com") {
                            UIApplication.shared.open(url)
                        }
                    }
            }
            .padding(.bottom, 20)
                        
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}

struct IconBulletPoint: View{
    let icon: String;
    let text: String;
    
    var body: some View{
        HStack{
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
            
            Text(text)
                .font(.custom("", size: 17))
            
        }
    }
}

