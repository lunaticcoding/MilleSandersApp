//
//  Cards.swift
//  ios_app
//
//  Created by Marco  Papula on 06.05.20.
//  Copyright © 2020 Marco  Papula. All rights reserved.
//

import SwiftUI
import Combine

class Decks: ObservableObject {
    
    @Published var sections: [String] = ["Hello", "Test"]
}
