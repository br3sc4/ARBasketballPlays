//
//  TeamComponent.swift
//  
//
//  Created by Lorenzo Brescanzin on 18/04/23.
//

import RealityKit

struct TeamComponent: Component {
    let team: Team
}

protocol HasTeam {}

extension HasTeam where Self : Entity {
    var teamComponent: TeamComponent {
        get { components[TeamComponent.self] ?? TeamComponent(team: .teamA) }
        set { components[TeamComponent.self] = newValue }
    }
    
    var team: Team {
        teamComponent.team
    }
    
    var teamColor: Material.Color {
        switch team {
        case .teamA: return .green
        case .teamB: return .gray
        }
    }
}
