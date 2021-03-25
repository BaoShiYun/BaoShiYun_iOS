//
//  LOTAnimationView.swift
//  BSYUILib
//
//  Created by Duane on 2019/6/12.
//  Copyright © 2019 kaikeba. All rights reserved.
//

import Foundation
import Lottie

open class LOTAnimationView: UIView {
    var animationView: AnimationView? {
        willSet {
            if let view = newValue {
                self.addSubview(view)
                view.frame = self.bounds
            }
        }
        didSet {
            oldValue?.removeFromSuperview()
        }
    }

    @objc open class func animationNamed(_ name:String) ->LOTAnimationView {
        return animationNamed(name, bundle: Bundle.main)
    }
    
    @objc open class func animationNamed(_ name:String, bundle:Bundle? = nil) ->LOTAnimationView {
        let lotView = LOTAnimationView()
        if #available(iOS 10.0, *) {
            let animationView = AnimationView(name: name, bundle: bundle ?? Bundle.main)
            animationView.backgroundBehavior = .pauseAndRestore
            lotView.animationView = animationView
        }
        return lotView
    }
    
    @objc open class func animationWithFilePath(_ name:String) ->LOTAnimationView {
        let lotView = LOTAnimationView()
        if #available(iOS 10.0, *) {
            let animationView = AnimationView(filePath: name)
            animationView.backgroundBehavior = .pauseAndRestore
            lotView.animationView = animationView
        }
        return lotView
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        animationView?.frame = self.bounds
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            return animationView?.intrinsicContentSize ?? CGSize.zero;
        }
    }

    @objc open var loopAnimation:Bool {
        get {
            return animationView?.loopMode == LottieLoopMode.loop
        }
        set {
            if newValue {
                animationView?.loopMode = LottieLoopMode.loop
            } else {
                animationView?.loopMode = LottieLoopMode.playOnce
            }
        }
    }
    
    @objc open var isAnimationPlaying:Bool {
        get {
            return animationView?.isAnimationPlaying ?? false
        }
    }
    
    @objc open var animationProgress:AnimationProgressTime {
        get {
            return (animationView?.currentProgress)!
        }
        set {
            animationView?.currentProgress = newValue
            animationView?.forceDisplayUpdate()
        }
    }
    
    @objc open func play() {
        animationView?.play()
    }
    
    @objc open func play(fromProgress: AnimationProgressTime,
        toProgress: AnimationProgressTime,
        completion: LottieCompletionBlock? = nil) {
        animationView?.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: animationView?.loopMode, completion: completion)
    }

    @objc open func playWithCompletion(_ completion:@escaping LottieCompletionBlock) {
        animationView?.play(completion: completion)
    }
    
    @objc open func stop() {
        animationView?.stop()
    }
    
    @objc open func pause() {
        animationView?.pause()
    }
    
    @objc open func reloadAnimationWithFilePath(_ name:String) {
        animationView?.animation = Animation.filepath(name)
    }

    @objc open func reloadAnimationWithName(_ name:String) {
        animationView?.animation = Animation.named(name)
    }

    @objc open func reloadAnimationWithName(_ name:String, bundle:Bundle = Bundle.main) {
        animationView?.animation = Animation.named(name, bundle: bundle)
    }
}
