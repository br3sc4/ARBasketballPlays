//
//  PlayBookARView.swift
//  
//
//  Created by Lorenzo Brescanzin on 19/04/23.
//

import SwiftUI

struct PlayBookARView: UIViewControllerRepresentable {
    @ObservedObject private var store: PlayBookStore

    init(store: PlayBookStore) {
        self.store = store
    }
    
    func makeUIViewController(context: Context) -> PlayBookARViewController {
        let vc = PlayBookARViewController(play: store.currentPlay)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: PlayBookARViewController, context: Context) {
        uiViewController.play = store.currentPlay
        uiViewController.resetScene()
    }
    
    typealias UIViewControllerType = PlayBookARViewController
}

#if DEBUG
struct PlayBookAR_Previews: PreviewProvider {
    static var previews: some View {
        PlayBookARView(store: PlayBookStore())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
