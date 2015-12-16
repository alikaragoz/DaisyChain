//
//  SimpleChainViewController.swift
//  Showcase
//
//  Created by Ali Karagoz on 16/12/15.
//  Copyright © 2015 Ali Karagoz. All rights reserved.
//

import Foundation
import UIKit

import DaisyChain

class SimpleChainViewController: UIViewController {
  
  @IBOutlet weak var shape: UIView!
  @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shape.layer.cornerRadius = 50.0
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.animate()
  }
  
  func animate() {
    let chain = DaisyChain()
    chain.animateWithDuration(
      0.6,
      delay: 0.0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 1.2,
      options: .CurveEaseInOut,
      animations: {
        self.centerYConstraint.constant = 150.0
        self.view.layoutIfNeeded()
      },
      completion: nil)
    
    chain.animateWithDuration(
      0.6,
      delay: 0.0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 1.2,
      options: .CurveEaseInOut,
      animations: {
        self.centerYConstraint.constant = -150.0
        self.view.layoutIfNeeded()
      },
      completion: { _ in
        self.animate()
    })
  }
}
