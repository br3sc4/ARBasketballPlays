import SwiftUI

struct ContentView: View {
    @StateObject private var store: PlayBookStore = PlayBookStore()
    
    var body: some View {
        PlayBookARView(store: store)
            .edgesIgnoringSafeArea(.top)
            .safeAreaInset(edge: .bottom) {
                Picker("Select a play", selection: $store.selectedPlayName) {
                    ForEach(store.plays, id: \.name) { play in
                        Text(play.name)
                            .tag(play.name)
                    }
                }
               .pickerStyle(.segmented)
               .padding(.horizontal)
            }
    }
}
