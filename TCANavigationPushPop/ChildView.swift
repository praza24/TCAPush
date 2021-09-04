//
//  ChildView:.swift
//  TCANavigationPushPop
//
//  Created by Prasath Srithar on 24/08/2021.
//

import SwiftUI
import ComposableArchitecture

struct ChildView: View {
    
    let store: Store<ChildState, ChildAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                Text("Hello")
                    .navigationBarItems(trailing:
                                            Button(
                                                action: {
                                                   viewStore.send(.popPushedView)
                                                }, label: {
                                                    Text("Dismiss Child View")
                                                }
                                            )
                    )
            }
        }
    }
}

//struct PushedView_Previews: PreviewProvider {
//    static var previews: some View {
//        PushedView()
//    }
//}

struct ChildState: Equatable { }

enum ChildAction: Equatable {
    case popPushedView
    
}

let ChildReducer = Reducer<ChildState, ChildAction, Void> { state, action, AppEnvironment in
    switch action {
    
    case .popPushedView:
        return .none
    }
}
.debug()
