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
class DaisyChain {
    
    private let queue: dispatch_queue_t
    private var semaphore: dispatch_semaphore_t
    
    // MARK: Init
    
    /**
    Initialises and returns a newly allocated DaisyChain object.
    
    - returns: An initialised DaisyChain object.
    */
    init() {
        queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)
        semaphore = dispatch_semaphore_create(0)
    }
    
    // MARK: Queue Handling
    
    /**
    Performs the block passed in parameter and waits until the DaisyChain is resumed.
    */
    private func performAndWait(completion: () -> Void) {
        dispatch_async(queue) {
            dispatch_async(dispatch_get_main_queue(), completion)
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
        }
    }
    
    /**
    Resumes the previously waiting process.
    */
    private func resume(completion: ((Bool) -> Void)?, finished: Bool) {
        completion?(finished)
        dispatch_semaphore_signal(semaphore)
    }
    
    // MARK: Animating
    
    /**
    Sequentially animates changes to one or more views using the specified duration.
    
    - parameter duration:   The total duration of the animations, measured in seconds. If you 
                            specify a negative value or `0`, the changes are made without animating 
                            them.
    - parameter animations: A block object containing the changes to commit to the views. This is 
                            where you programmatically change any animatable properties of the views 
                            in your view hierarchy. This block takes no parameters and has no return
                            value. This parameter must not be `NULL`.
    */
    internal func animateWithDuration(duration: NSTimeInterval, animations: () -> Void) {
        performAndWait {
            UIView.animateWithDuration(duration, animations: animations, completion: { finished -> Void in
                self.resume(nil, finished: finished)
            })
        }
    }
    
    /**
    Sequentially animate changes to one or more views using the specified duration and completion
    handler.
     
    - parameter duration:   The total duration of the animations, measured in seconds. If you
                            specify a negative value or `0`, the changes are made without animating
                            them.
    - parameter animations: A block object containing the changes to commit to the views. This is
                            where you programmatically change any animatable properties of the views
                            in your view hierarchy. This block takes no parameters and has no return
                            value. This parameter must not be `NULL`.
    - parameter completion: A block object to be executed when the animation sequence ends. This 
                            block has no return value and takes a single Boolean argument that 
                            indicates whether or not the animations actually finished before the 
                            completion handler was called. If the duration of the animation is `0`,
                            this block is performed at the beginning of the next run loop cycle. 
                            This parameter may be `NULL`.
    */
    internal func animateWithDuration(duration: NSTimeInterval, animations: () -> Void, completion: ((Bool) -> Void)?) {
        performAndWait {
            UIView.animateWithDuration(duration, animations: animations, completion: { finished -> Void in
                self.resume(completion, finished: finished)
            })
        }
    }
    
    /**
    Sequentially animate changes to one or more views using the specified duration, delay, options,
    and completion handler.
     
    - parameter duration:   The total duration of the animations, measured in seconds. If you
                            specify a negative value or `0`, the changes are made without animating
                            them.
    - parameter delay:      The amount of time (measured in seconds) to wait before beginning the
                            animations. Specify a value of `0` to begin the animations immediately.
    - parameter options:    A mask of options indicating how you want to perform the animations. For
                            a list of valid constants, see `UIViewAnimationOptions`.
    - parameter animations: A block object containing the changes to commit to the views. This is
                            where you programmatically change any animatable properties of the views
                            in your view hierarchy. This block takes no parameters and has no return
                            value. This parameter must not be `NULL`.
    - parameter completion: A block object to be executed when the animation sequence ends. This
                            block has no return value and takes a single Boolean argument that
                            indicates whether or not the animations actually finished before the
                            completion handler was called. If the duration of the animation is `0`,
                            this block is performed at the beginning of the next run loop cycle.
                            This parameter may be `NULL`.
    */
    internal func animateWithDuration(duration: NSTimeInterval, delay: NSTimeInterval, options: UIViewAnimationOptions, animations: () -> Void, completion: ((Bool) -> Void)?) {
        performAndWait {
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: { finished in
                self.resume(completion, finished: finished)
            })
        }
    }
    
    /**
    Sequentially performs a view animation using a timing curve corresponding to the motion of a
    physical spring.
     
    - parameter delay:                  The amount of time (measured in seconds) to wait before
                                        beginning the animations. Specify a value of `0` to begin
                                        the animations immediately.
    - parameter options:                A mask of options indicating how you want to perform the
                                        animations. For a list of valid constants, see
                                        `UIViewAnimationOptions`.
    - parameter usingSpringWithDamping: The damping ratio for the spring animation as it approaches
                                        its quiescent state.
     
                                        To smoothly decelerate the animation without oscillation,
                                        use a value of `1`. Employ a damping ratio closer to zero
                                        to increase oscillation.
     - parameter initialSpringVelocity: The initial spring velocity. For smooth start to the 
                                        animation, match this value to the view’s velocity as it was
                                        prior to attachment.
     
                                        A value of `1` corresponds to the total animation distance
                                        traversed in one second. For example, if the total animation
                                        distance is 200 points and you want the start of the
                                        animation to match a view velocity of 100 pt/s, use a
                                        value of `0.5`.
    - parameter animations:             A block object containing the changes to commit to the
                                        views. This is where you programmatically change any
                                        animatable properties of the views in your view hierarchy.
                                        This block takes no parameters and has no return value.
                                        This parameter must not be `NULL`.
    - parameter completion:             A block object to be executed when the animation sequence
                                        ends. This block has no return value and takes a single
                                        Boolean argument that indicates whether or not the
                                        animations actually finished before the completion handler
                                        was called. If the duration of the animation is `0`,this
                                        block is performed at the beginning of the next run loop
                                        cycle. This parameter may be `NULL`.
     */

    internal func animateWithDuration(duration: NSTimeInterval, delay: NSTimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions, animations: () -> Void, completion: ((Bool) -> Void)?) {
        performAndWait {
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: { finished -> Void in
                self.resume(completion, finished: finished)
            })
        }
    }
}
