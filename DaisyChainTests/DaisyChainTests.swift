//
//  DaisyChainTests.swift
//  DaisyChainTests
//
//  Created by Ali Karagoz on 15/12/15.
//  Copyright © 2015 Ali Karagoz. All rights reserved.
//

import XCTest
@testable import DaisyChain

class DaisyChainTests: XCTestCase {
  
  var daisyChain: DaisyChain!
  
  override func setUp() {
    daisyChain = DaisyChain()
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testSerialAnimation() {
    
    let expectation = expectationWithDescription("Animation Expectations")
    let view: UIView = UIView()
    var positions: [CGFloat] = []
    
    daisyChain.animateWithDuration(0.1,
      animations: {
        view.frame.origin.x = 10
      },
      completion: { _ in
        positions.append(view.frame.origin.x)
    })
    
    daisyChain.animateWithDuration(0.1,
      animations: {
        view.frame.origin.x = 20
      },
      completion: { _ in
        positions.append(view.frame.origin.x)
    })
    
    daisyChain.animateWithDuration(0.1,
      animations: {
        view.frame.origin.x = 30
      },
      completion: { _ in
        positions.append(view.frame.origin.x)
        
        XCTAssert(positions[0] == 10 && positions[1] == 20 && positions[2] == 30, "Animations did not perform serially")
        expectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(1.0, handler: nil)
    
  }
  
  func testSerialCompletion() {
    
    let expectation = expectationWithDescription("Swift Expectations")
    var counter: Int = 0
    
    daisyChain.animateWithDuration(2.0, animations: {}, completion: { _ in counter++ })
    daisyChain.animateWithDuration(1.0, animations: {}, completion: { _ in counter++ })
    daisyChain.animateWithDuration(0.5, animations: {}, completion: { _ in counter++ })
    daisyChain.animateWithDuration(0.1, animations: {}, completion: { _ in
      XCTAssert(counter == 3, "Animations did not call completion serially")
      expectation.fulfill()
    })
    
    waitForExpectationsWithTimeout(5.0, handler: nil)
  }
  
  func testBreakableChain() {
    
    daisyChain.animateWithDuration(0.1, animations: {}, completion: nil)
    
    daisyChain.animateWithDuration(0.1, animations: {}, completion: { _ in
      self.daisyChain.broken = true
    })
    
    daisyChain.animateWithDuration(0.1,
      animations: {
        XCTAssert(false, "Animation block should not be executed")
      },
      completion: { _ in
        XCTAssert(false, "Completion block should not be executed")
    })
  }
}
