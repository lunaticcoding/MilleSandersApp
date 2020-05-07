//
//  Cards.swift
//  ios_app
//
//  Created by Marco  Papula on 06.05.20.
//  Copyright © 2020 Marco  Papula. All rights reserved.
//

import RxSwift
import SwiftUI
import Combine
import Firebase
import RxFirebase
import CodableFirebase

class Decks: ObservableObject {
    @Published var sections: [Section]
    private var db: Firestore?
    private let disposeBag = DisposeBag()
    
    init() {
        db = Firestore.firestore()
        sections = [Section]()
    }
    
    func getData() {
        let _ = db!.collection("sections").rx
            .getDocuments()
            .subscribe(
                onNext: { snapshot in
                    var tmpSections = [Section]()
                    for document in snapshot.documents {
                        let section = try! FirebaseDecoder().decode(Section.self, from: document.data())

                        tmpSections.append(section)
                    }
                    self.sections = tmpSections
                }, onError: { error in
                    print("Error fetching snapshots: \(error)")
                })
            .disposed(by: disposeBag)
        
    }
    
}


struct Section: Codable {
    var id: Int
    var sectionName: String
    var decks: [Deck]
}

struct Deck: Codable {
    var deckName: String
    var icon: String
    var color: String
    var filterIcons: [String]
    var cards: [Card]
}

struct Card: Codable {
    var text: String
    var color: String
    var filter: [String]
}
