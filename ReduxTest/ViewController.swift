//
//  ViewController.swift
//  ReduxTest
//
//  Created by Leonid Nifantyev on 11/3/19.
//  Copyright © 2019 Lion. All rights reserved.
//

import UIKit

struct CounterState: State {
  var counter: Int = 0
}

struct InscreaseAction: Action {
  let increaseBy: Int
}

struct DecreaseAction: Action {
  let decreaseBy: Int
}

class ViewController: UIViewController, StoreSubscirber {
  
  @IBOutlet weak var valueLabel: UILabel!
  var store: Store?
  var counterState = CounterState()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.store = Store(reducer: reducer, state: nil)
    store?.suscribe(new: self)
  }
  
  
  @IBAction func plusTapped(_ sender: UIButton) {
    store?.dispatch(action: InscreaseAction(increaseBy: 1))
  }
  
  @IBAction func minuesTapped(_ sender: UIButton) {
    store?.dispatch(action: DecreaseAction(decreaseBy: 1))
  }
  
  func news(state: State) {
    self.counterState = state as! CounterState
    valueLabel.text = "\(counterState.counter)"
  }
  
  func reducer(_ action: Action, _ state: State?) -> State {
    
    var newstate = state as? CounterState ?? CounterState()
    
    switch action {
    case let action as InscreaseAction:
      newstate.counter += action.increaseBy
    case let action as DecreaseAction:
      newstate.counter -= action.decreaseBy
    default:
      fatalError()
    }
    
    return newstate
  }
}

