//
//  File.swift
//  
//
//  Created by Lorenzo Brescanzin on 15/04/23.
//

import RealityKit

final class BallEntity: Entity, HasModel, HasCollision {
    required init() {
        super.init()
        
        components[ModelComponent.self] = ModelComponent(
            mesh: .generateSphere(radius: 0.25/10),
            materials: [SimpleMaterial(color: .orange, isMetallic: false)]
        )
        
        components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateSphere(radius: Float(0.25/10))],
            mode: .trigger,
            filter: .sensor
        )
        
        name = "ball"
    }
}
