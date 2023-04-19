//
//  PlayBookStore.swift
//  WWDCCodingChalenge
//
//  Created by Lorenzo Brescanzin on 13/04/23.
//

import Combine

final class PlayBookStore: ObservableObject {
    @Published var selectedPlayName: String = Play.evenZoneOffense.name
    
    var currentPlay: Play {
        plays.first(where: { $0.name == selectedPlayName})!
    }
    
    let plays: [Play] = [.evenZoneOffense, .oddZoneOffense]
}
