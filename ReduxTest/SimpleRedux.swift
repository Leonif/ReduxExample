//
//  SimpleRedux.swift
//  ReduxTest
//
//  Created by Leonid Nifantyev on 11/3/19.
//  Copyright © 2019 Lion. All rights reserved.
//

import Foundation

protocol Action {}

protocol State {}

typealias Reducer = (_ action: Action, _ state: State?) -> State

protocol StoreSubscirber {
  func news(state: State)
}

class Store {
  let reducer: Reducer
  var state: State?
  var subscribers: [StoreSubscirber] = []
  
  init(reducer: @escaping Reducer, state: State?) {
      self.reducer = reducer
      self.state = state
  }
  
  func dispatch(action: Action) {
    state = reducer(action, state)
    subscribers.forEach { $0.news(state: state!) }
  }
  
  func suscribe(new subscriber: StoreSubscirber) {
    subscribers.append(subscriber)
  }
}
