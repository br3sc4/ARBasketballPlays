//
//  PlayerEntity.swift
//  
//
//  Created by Lorenzo Brescanzin on 15/04/23.
//

import RealityKit

@frozen enum Team {
    case teamA, teamB
}

final class PlayerEntity: Entity, HasModel, HasCollision, HasTeam {
    init(name: String = "", team: Team) {
        super.init()
        
        self.name = name
        
        components[TeamComponent.self] = TeamComponent(team: team)
        
        components[ModelComponent.self] = ModelComponent(
            mesh: .generateBox(width: 0.5/10, height: 1.8/10, depth: 0.5/10),
            materials: [SimpleMaterial(color: teamColor, isMetallic: false)]
        )
        
        generateCollisionShapes(recursive: true)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func reset() {
        model?.materials = [SimpleMaterial(color: teamColor, isMetallic: false)]
    }
}
