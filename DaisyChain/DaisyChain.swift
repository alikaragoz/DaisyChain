//
//  DaisyChain.swift
//  DaisyChain
//
//  Created by Ali Karagoz on 15/12/15.
//  Copyright © 2015 Ali Karagoz. All rights reserved.
//

import Foundation
import UIKit

/**
 Responsible for managing the queue of animations and their sequencing.
 */
public class DaisyChain {

    private let queue: DispatchQueue
    private var semaphore: DispatchSemaphore
  
   /**
    A boolean value which allows you to break a chain of execution by setting it to `true`. Setting it back to `false`
    does not restart the chain of execution.
    */
    public var broken: Bool = false
  
  // MARK: Init
  
   /**
    Initialises and returns a newly allocated DaisyChain object.
  
    - returns: An initialised DaisyChain object.
    */
    public init() {
        queue = DispatchQueue(label: "DaisyChain")
        semaphore = DispatchSemaphore(value: 0)
    }
  
    // MARK: Queue Handling
  
    /**
     Performs the block passed in parameter and waits until the DaisyChain is resumed.
    */
    private func performAndWait(_ completion: @escaping () -> Void) {
        queue.async {

            // If the chain is broken, we do not execute anything
            if (self.broken) {
                return;
            }

            DispatchQueue.main.async(execute: completion)
            _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
        }
    }
  
    /**
     Resumes the previously waiting process.
    */
    private func resume(_ completion: ((Bool) -> Void)?, finished: Bool) {
        completion?(finished)
        semaphore.signal()
    }
  
    // MARK: Animating
  
    /**
     Sequentially animates changes to one or more views using the specified duration.
  
     - parameter duration:   The total duration of the animations, measured in seconds. If you  specify a negative value or
                             `0`, the changes are made without animating them.
     - parameter animations: A block object containing the changes to commit to the views. This is  where you
                             programmatically change any animatable properties of the views in your view hierarchy. This
                             block takes no parameters and has no return value. This parameter must not be `NULL`.
     - returns:              The current DaisyChain instance.
    */
    @discardableResult public func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> DaisyChain {
        performAndWait {
            UIView.animate(withDuration: duration, animations: animations, completion: { finished -> Void in
                self.resume(nil, finished: finished)
            })
        }
        return self
    }
  
    /**
     Sequentially animate changes to one or more views using the specified duration and completion
     handler.
   
     - parameter duration:   The total duration of the animations, measured in seconds. If you specify a negative value or
                             `0`, the changes are made without animating them.
     - parameter animations: A block object containing the changes to commit to the views. This is where you
                             programmatically change any animatable properties of the views in your view hierarchy. This
                             block takes no parameters and has no return value. This parameter must not be `NULL`.
     - parameter completion: A block object to be executed when the animation sequence ends. This block has no return
                             value and takes a single Boolean argument that indicates whether or not the animations
                             actually finished before the completion handler was called. If the duration of the animation
                             is `0`, this block is performed at the beginning of the next run loop cycle. This parameter
                             may be `NULL`.
     - returns:              The current DaisyChain instance.
    */
    @discardableResult public func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) -> DaisyChain {
        performAndWait {
            UIView.animate(withDuration: duration, animations: animations, completion: { finished -> Void in
                self.resume(completion, finished: finished)
            })
        }
        return self
    }
  
    /**
     Sequentially animate changes to one or more views using the specified duration, delay, options,
     and completion handler.
   
     - parameter duration:   The total duration of the animations, measured in seconds. If you specify a negative value or
                             `0`, the changes are made without animating them.
     - parameter delay:      The amount of time (measured in seconds) to wait before beginning the animations. Specify a
                             value of `0` to begin the animations immediately.
     - parameter options:    A mask of options indicating how you want to perform the animations. For a list of valid
                             constants, see `UIViewAnimationOptions`.
     - parameter animations: A block object containing the changes to commit to the views. This is where you
                             programmatically change any animatable properties of the views in your view hierarchy. This
                             block takes no parameters and has no return value. This parameter must not be `NULL`.
     - parameter completion: A block object to be executed when the animation sequence ends. This block has no return
                             value and takes a single Boolean argument that indicates whether or not the animations
                             actually finished before the completion handler was called. If the duration of the animation
                             is `0`, this block is performed at the beginning of the next run loop cycle. This parameter
                             may be `NULL`.
     - returns:              The current DaisyChain instance.
    */
    @discardableResult public func animate(withDuration duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) -> DaisyChain {
        performAndWait {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations, completion: { finished in
                self.resume(completion, finished: finished)
            })
        }
        return self
    }
  
    /**
     Sequentially performs a view animation using a timing curve corresponding to the motion of a
     physical spring.

     - parameter duration:               The total duration of the animations, measured in seconds. If you specify a
                                         negative value or `0`, the changes are made without animating them.
     - parameter delay:                  The amount of time (measured in seconds) to wait before beginning the animations.
                                         Specify a value of `0` to begin the animations immediately.
     - parameter usingSpringWithDamping: The damping ratio for the spring animation as it approaches its quiescent state.
   
                                         To smoothly decelerate the animation without oscillation, use a value of `1`.
                                         Employ a damping ratio closer to zero to increase oscillation.
     - parameter initialSpringVelocity:  The initial spring velocity. For smooth start to the animation, match this value
                                         to the view’s velocity as it was prior to attachment.
   
                                         A value of `1` corresponds to the total animation distance traversed in one
                                         second. For example, if the total animation distance is 200 points and you want
                                         the start of the animation to match a view velocity of 100 pt/s, use a value of
                                         `0.5`.
     - parameter options:                A mask of options indicating how you want to perform the animations. For a list
                                         of valid constants, see `UIViewAnimationOptions`.
     - parameter animations:             A block object containing the changes to commit to the views. This is where you
                                         programmatically change any animatable properties of the views in your view
                                         hierarchy. This block takes no parameters and as no return value. This parameter
                                         must not be `NULL`.
     - parameter completion:             A block object to be executed when the animation sequence ends. This block has no
                                         return value and takes a single Boolean argument that indicates whether or not
                                         the animations actually finished before the completion handler was called. If the
                                         duration of the animation is `0`,this block is performed at the beginning of the
                                         next run loop cycle. This parameter may be `NULL`.
     - returns:                          The current DaisyChain instance.
    */
    @discardableResult public func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) -> DaisyChain {
        performAndWait {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations, completion: { finished -> Void in
                self.resume(completion, finished: finished)
            })
        }
        return self
    }
}
