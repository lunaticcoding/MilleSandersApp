//
//  DeckSelectionView.swift
//  ios_app
//
//  Created by Marco  Papula on 06.05.20.
//  Copyright © 2020 Marco  Papula. All rights reserved.
//

import SwiftUI

struct DeckSelectionView: View {
        
    @EnvironmentObject var decks: Decks

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Heute möchte ich...").fontWeight(.bold)
                    .padding(.top, 20)
                VStack(alignment: .leading) {
                    if (decks.sections.count > 0) {
                        ForEach(self.decks.sections, id: \.id) { section in
                            VStack(alignment: .leading){
                                Text(section.sectionName)
                                    .padding(.top, 10)
                                                            
                                HStack{
                                    ForEach((0..<section.decks.count)) {_ in
                                        RoundedRectangleCard(color: Color.green) {
                                            ZStack{
                                                Text("Hello")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Text("Replace with Loading indicator/error message")
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20.0)
            }.onAppear {
                self.decks.getData()
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
    
}

/*
 Text((decks.sections.count > 0 ? decks.sections[0].sectionName : "0")).onAppear(perform: decks.getData)
 */
struct DeckSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DeckSelectionView()
    }
}

struct RoundedRectangleCard<Content>: View where Content: View {
    let content: Content
    let color: Color
    
    init(color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.color = color
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(color)
                .frame(width: 150, height: 150)
        
            content
        }
    }
}
