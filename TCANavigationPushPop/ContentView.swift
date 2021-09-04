//
//  ContentView.swift
//  TCANavigationPushPop
//
//  Created by Prasath Srithar on 24/08/2021.
//

import SwiftUI
import ComposableArchitecture


struct AppEnvironment :Equatable {}

struct ContentView: View {
    
    let store: Store<ParentState, ParentAction>
    
    init(store: Store<ParentState, ParentAction>) {
        self.store = store
    }
    
    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                
                Button(action: {
                    
                    viewStore.send(.pushChildView)
                },
                label: {
                    Text("Push via TCA")
                }
                )
                .sheet(isPresented: viewStore.binding(
                        get: { $0.shouldPresentChild },
                        send: ParentAction.popChildView),
                       content: {
                        IfLetStore(
                            store.scope(state: \.childState,
                                        action: ParentAction.childAction),
                            then: ChildView.init
                        )
                       }
                )
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(store: .init(initialState: ParentState(), reducer: mainReducer, environment: AppEnvironment()))
//    }
//}

struct ParentState: Equatable {
    var childState: ChildState?
    
    var shouldPresentChild: Bool {
        childState != nil
    }
}

enum ParentAction: Equatable {
    case pushChildView
    case popChildView
    case childAction(ChildAction)
}

let appReducer = Reducer<ParentState, ParentAction, AppEnvironment>
    .combine(
        ChildReducer
            .optional()
            .pullback(state: \.childState,
                      action: /ParentAction.childAction,
                      environment: { _ in }
            ),
        parentReducer
    )

let parentReducer = Reducer<ParentState, ParentAction, AppEnvironment> { state, action, appEnvironment in
    switch action {
    
    case .pushChildView:
        state.childState = ChildState()
        return .none
        
    case .popChildView:
        state.childState = nil
        return .none
        
    case .childAction(.popPushedView):
        state.childState = nil
        return .none
    }
}
.debug()
