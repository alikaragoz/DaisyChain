[![Build Status](https://travis-ci.org/alikaragoz/DaisyChain.svg?branch=master)](https://travis-ci.org/alikaragoz/DaisyChain)
[![Version](http://img.shields.io/cocoapods/v/DaisyChain.svg)](http://cocoapods.org/?q=DaisyChain)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


DaisyChain
----------

**DaisyChain** is a micro framework which makes UIView animations chaining dead simple. It uses the exact same interface you are familiar with.

#### Chaining made simple
We all have seen or written code which looks like this:

```swift
UIView.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 0.0)
}, completion: { _ in
    UIView.animate(withDuration: 0.5, animations: {
        view.center = CGPoint(x: 100.0, y: 0.0)
    }, completion: { _ in
        UIView.animate(withDuration: 0.5, animations: {
            view.center = CGPoint(x: 100.0, y: 100.0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                view.center = CGPoint(x: 0.0, y: 100.0)
            }, completion: { _ in
                UIView.animate(0.5, animations: {
                    view.center = CGPoint(x: 0.0, y: 0.0)
                })
            })
        })
    })
})
```

This can go pretty far, it is also known as *callback hell*. It's not very flexible and hard to read.

With **DaisyChain** we can rewrite that same code like this:

```swift
let chain = DaisyChain()

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 0.0)
})

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 100.0, y: 0.0)
})

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 100.0, y: 100.0)
})

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 100.0)
})

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 0.0)
})
```

As you can the the code has been flattened, this allows you to easily modify the order of the steps or the addition of new steps.

Or if you would prefer your code to be more succinct:

```swift
let chain = DaisyChain()

chain.animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 0.0)
}).animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 100.0, y: 0.0)
}).animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 100.0, y: 100.0)
}).animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 100.0)
}).animate(withDuration: 0.5, animations: {
    view.center = CGPoint(x: 0.0, y: 0.0)
})
```

#### Breakable chains

**DaisyChain** also adds a simple way to break animation sequences, simply set the `broken` property to `true` to break a chain:
```swift
chain.broken = true
```

To continue chaining animations, you'll need to change it back to `false` or create a new chain.

#### Setting up with CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'DaisyChain', '~> 1.0.0'
```

#### Setting up with Carthage

```ogdl
github "alikaragoz/DaisyChain" ~> 1.0.0
```

#### License

DaisyChain is available under the [MIT license](https://github.com/alikaragoz/DaisyChain/blob/master/LICENSE).
