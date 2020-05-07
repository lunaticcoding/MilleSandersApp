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
        Text((decks.sections.count > 0 ? decks.sections[0].sectionName : "0")).onAppear(perform: decks.getData)
    }
}

struct DeckSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DeckSelectionView()
    }
}
