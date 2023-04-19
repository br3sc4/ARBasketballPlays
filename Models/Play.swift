//
//  Play.swift
//  
//
//  Created by Lorenzo Brescanzin on 19/04/23.
//

import Foundation

struct Play {
    let name: String
    let players: Set<Player>
    let movements: [Movement]
    let ballPosition: SIMD3<Float>
}

extension Play {
    static var evenZoneOffense: Play {
        Play(
            name: "Zone 2-3 offense",
            players: [
                Player(position: [0, 0.09, 0.3], entity: PlayerEntity(name: EntityType.pg.rawValue, team: .teamA)),
                Player(position: [0.45, 0.09, 0.1], entity: PlayerEntity(name: EntityType.sg.rawValue, team: .teamA)),
                Player(position: [-0.45, 0.09, 0.1], entity: PlayerEntity(name: EntityType.sf.rawValue, team: .teamA)),
                Player(position: [0, 0.09, -0.1], entity: PlayerEntity(name: EntityType.pf.rawValue, team: .teamA)),
                Player(position: [0.25, 0.09, -0.4], entity: PlayerEntity(name: EntityType.c.rawValue, team: .teamA)),
                Player(position: [-0.2, 0.09, 0.1], entity: PlayerEntity(team: .teamB)),
                Player(position: [0.2, 0.09, 0.1], entity: PlayerEntity(team: .teamB)),
                Player(position: [0.425, 0.09, -0.4], entity: PlayerEntity(team: .teamB)),
                Player(position: [-0.425, 0.09, -0.4], entity: PlayerEntity(team: .teamB)),
                Player(position: [0, 0.09, -0.4], entity: PlayerEntity(team: .teamB))
            ],
            movements: [
                Movement(type: .ball, position: [0.45, 0.09, 0.1]),     // Pass to sg
                Movement(type: .ball, position: [0.25, 0.09, -0.4]),    // Pass to c
                Movement(type: .ball, position: [0, 0.09, 0.3]),        // Pass to pg
                Movement(type: .ball, position: [-0.45, 0.09, 0.1]),    // Pass to sf
                Movement(type: .ball, position: [0, 0.09, -0.1]),       // Pass to pf
                Movement(type: .ball, position: [0, 0.09, 0.3]),        // Pass to pg
                Movement(type: .ball, position: [0.45, 0.09, 0.1]),     // Pass to sg
                Movement(type: .ball, position: [0.25, 0.09, -0.4]),    // Pass to c
                Movement(type: .pf, position: [0, 0.09, -0.3]),         // Move pf
                Movement(type: .ball, position: [0, 0.09, -0.3]),       // Pass to pf
                Movement(type: .ball, position: [0, 0.09, 0.3]),        // Pass to pg
                Movement(type: .pf, position: [0, 0.09, -0.1])          // Move pf
            ],
            ballPosition: [0, 0.09, 0.3]
        )
    }
    
    static var oddZoneOffense: Play {
        Play(
            name: "Zone 3-2 offense",
            players: [
                Player(position: [-0.25, 0.09, 0.3], entity: PlayerEntity(name: EntityType.pg.rawValue, team: .teamA)),
                Player(position: [0.25, 0.09, 0.3], entity: PlayerEntity(name: EntityType.sg.rawValue, team: .teamA)),
                Player(position: [-0.5, 0.09, -0.4], entity: PlayerEntity(name: EntityType.sf.rawValue, team: .teamA)),
                Player(position: [0, 0.09, -0.1], entity: PlayerEntity(name: EntityType.pf.rawValue, team: .teamA)),
                Player(position: [-0.3, 0.09, -0.4], entity: PlayerEntity(name: EntityType.c.rawValue, team: .teamA)),
                Player(position: [-0.2, 0.09, -0.4], entity: PlayerEntity(team: .teamB)),
                Player(position: [0.2, 0.09, -0.4], entity: PlayerEntity(team: .teamB)),
                Player(position: [0.425, 0.09, 0.1], entity: PlayerEntity(team: .teamB)),
                Player(position: [-0.425, 0.09, 0.1], entity: PlayerEntity(team: .teamB)),
                Player(position: [0, 0.09, 0.1], entity: PlayerEntity(team: .teamB))
            ],
            movements: [
                Movement(type: .ball, position: [0.25, 0.09, 0.3]),     // Pass to sg
                Movement(type: .pf, position: [0.3, 0.09, -0.4]),       // Move pf
                Movement(type: .c, position: [0, 0.09, -0.1]),          // Move c
                Movement(type: .sf, position: [0.5, 0.09, -0.4]),       // Move sf
                Movement(type: .ball, position: [-0.25, 0.09, 0.3]),    // Pass to pg
                Movement(type: .c, position: [-0.3, 0.09, -0.4]),       // Move c
                Movement(type: .pf, position: [0, 0.09, -0.1]),         // Move pf
                Movement(type: .sf, position: [-0.5, 0.09, -0.4]),      // Move sf
                Movement(type: .ball, position: [-0.5, 0.09, -0.4]),    // Pass to sf
                Movement(type: .ball, position: [0, 0.09, -0.1]),       // Pass to pf
                Movement(type: .c, position: [0, 0.09, -0.3]),          // Move c
                Movement(type: .ball, position: [0, 0.09, -0.3]),       // Pass to c
                Movement(type: .sf, position: [0.5, 0.09, -0.4]),       // Move sf
                Movement(type: .ball, position: [0.5, 0.09, -0.4]),     // Pass to sf
                Movement(type: .pf, position: [0.3, 0.09, -0.4]),       // Move pf
                Movement(type: .c, position: [0, 0.09, -0.1]),          // Move c
                Movement(type: .ball, position: [0.25, 0.09, 0.3]),     // Pass to sg
                Movement(type: .ball, position: [-0.25, 0.09, 0.3]),    // Pass to pg
                Movement(type: .sf, position: [-0.5, 0.09, -0.4]),      // Move sf
                Movement(type: .c, position: [-0.3, 0.09, -0.4]),       // Move c
                Movement(type: .pf, position: [0, 0.09, -0.1])          // Move pf
            ],
            ballPosition: [-0.25, 0.09, 0.3]
        )
    }
}
