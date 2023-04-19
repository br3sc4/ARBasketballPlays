//
//  CourtEntity.swift
//  
//
//  Created by Lorenzo Brescanzin on 15/04/23.
//

import Foundation
import RealityKit

final class CourtEntity: Entity, HasModel, HasCollision {
    init(width: Float, depth: Float) {
        super.init()
        
        var material = SimpleMaterial(color: .brown, isMetallic: false)
        
        if let url = Bundle.main.url(forResource: "HalfCourt", withExtension: "png"),
           let texture = try? TextureResource.load(contentsOf: url, withName: nil) {

            material.color = PhysicallyBasedMaterial.BaseColor(
                texture: MaterialParameters.Texture(texture)
            )
        }
        
        components[ModelComponent.self] = ModelComponent(
            mesh: .generatePlane(width: width, depth: depth),
            materials: [material]
        )
        
        generateCollisionShapes(recursive: true)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
