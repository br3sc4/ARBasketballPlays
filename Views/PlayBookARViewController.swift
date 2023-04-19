//
//  PlayBookARViewController.swift
//  WWDCCodingChalenge
//
//  Created by Lorenzo Brescanzin on 06/04/23.
//

import RealityKit
import ARKit
import Combine

class PlayBookARViewController: UIViewController {
    private let arView: ARView = {
        let view = ARView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var play: Play {
        didSet {
            currentMovement = play.movements.makeIterator()
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var anchorEntity: AnchorEntity = AnchorEntity()
    
    private var currentMovement: IndexingIterator<[Movement]>
    
    init(play: Play) {
        self.play = play
        currentMovement = play.movements.makeIterator()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(arView)
        
        setupARView()
        setupCoachingOverlay()
        
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    private func setupARView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
        }
        
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func resetScene() {
        guard !arView.scene.anchors.isEmpty else { return }
        cancellables.forEach { $0.cancel() }
        arView.scene.removeAnchor(anchorEntity)
        setupARView()
    }
    
    private func setupARScene() {
        let courtEntity = CourtEntity(width: 15.24/10, depth: 14.325/10)
        
        for player in play.players {
            player.entity.setPosition(player.position, relativeTo: courtEntity)
            player.entity.setParent(courtEntity)
        }
        
        let ballEntity: BallEntity = BallEntity()
        ballEntity.setPosition(play.ballPosition, relativeTo: courtEntity)
        ballEntity.setParent(courtEntity)
        
        anchorEntity = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: .zero))
        anchorEntity.addChild(courtEntity)
        
        arView.scene.subscribe(to: CollisionEvents.Began.self, on: ballEntity) { event in
            guard let playerEntity = event.entityB as? PlayerEntity else { return }
            guard case .teamA = playerEntity.team else { return }
            playerEntity.model?.materials = [SimpleMaterial(color: .orange, isMetallic: false)]
        }.store(in: &cancellables)
        
        arView.scene.subscribe(to: CollisionEvents.Ended.self, on: ballEntity) { event in
            guard let playerEntity = event.entityB as? PlayerEntity else { return }
            guard case .teamA = playerEntity.team else { return }
            playerEntity.reset()
        }.store(in: &cancellables)
        
        arView.scene.subscribe(to: SceneEvents.AnchoredStateChanged.self) { [weak self] event in
            guard let self else { return }
            guard event.isAnchored else { return }
            guard let movement = self.currentMovement.next() else { return }
            self.moveEntity(to: movement.position, type: movement.type, relativeTo: courtEntity)
        }.store(in: &cancellables)
        
        arView.scene.subscribe(to: AnimationEvents.PlaybackCompleted.self) { [weak self] _ in
            guard let self else { return }
            if let movement = self.currentMovement.next() {
                self.moveEntity(to: movement.position, type: movement.type, relativeTo: courtEntity)
            } else {
                self.currentMovement = self.play.movements.makeIterator()
                guard let movement = self.currentMovement.next() else { return }
                self.moveEntity(to: movement.position, type: movement.type, relativeTo: courtEntity)
            }
        }.store(in: &cancellables)
        
        arView.installGestures([.all], for: courtEntity)
        
        arView.scene.addAnchor(anchorEntity)
    }
    
    private func moveEntity(to position: SIMD3<Float>, type: EntityType, relativeTo court: Entity) {
        guard let entity = court.findEntity(named: type.rawValue) else { return }
                
        let transform = Transform(
            scale: .one,
            rotation: simd_quatf(),
            translation: position
        )
        
        entity.move(
            to: transform,
            relativeTo: court,
            duration: 1.5,
            timingFunction: .linear
        )
    }
    
    private func setupCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = arView.session
        coachingOverlay.delegate = self
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.topAnchor.constraint(equalTo: arView.topAnchor),
            coachingOverlay.trailingAnchor.constraint(equalTo: arView.trailingAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: arView.bottomAnchor),
            coachingOverlay.leadingAnchor.constraint(equalTo: arView.leadingAnchor)
        ])
    }
}

// MARK: - ARCoachingOverlayViewDelegate
extension PlayBookARViewController: ARCoachingOverlayViewDelegate {
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        setupARScene()
    }
}
