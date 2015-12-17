[![Build Status](https://travis-ci.org/alikaragoz/DaisyChain.svg?branch=master)](https://travis-ci.org/alikaragoz/DaisyChain)
[![Version](http://img.shields.io/cocoapods/v/DaisyChain.svg)](http://cocoapods.org/?q=DaisyChain)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


DaisyChain
----------

**DaisyChain** is a micro framework which makes UIView animations chaining dead simple. It uses the exact same interface you are familiars with.

#### Chaining made simple
We all have seen or written code which looks like this:

```swift
UIView.animateWithDuration(0.5, animations:
  view.center = CGPointMake(0.0, 0.0)
  }) { _ in
    view.animateWithDuration(0.5, animations:
      view.center = CGPointMake(100.0, 0.0)
      }) { _ in
        UIView.animateWithDuration(0.5, animations:
          view.center = CGPointMake(100.0, 100.0)
          }) { _ in
            UIView.animateWithDuration(0.5, animations:
              view.center = CGPointMake(0.0, 100.0)
              }) { _ in
                UIView.animateWithDuration(0.5, animations:
                  view.center = CGPointMake(0.0, 0.0)
                })
            }
        }
    }
}
```

As you can see it can go pretty far, this is also know as the *callback hell*. It's not very flexible and hard to read.

With **DaisyChain** the above code looks like this:

```swift
let chain = DaisyChain()

chain.animateWithDuration(0.5, animations: {
  view.center = CGPointMake(0.0, 0.0)
})

chain.animateWithDuration(0.5, animations: {
  view.center = CGPointMake(100.0, 0.0)
})

chain.animateWithDuration(0.5, animations: {
  view.center = CGPointMake(100.0, 100.0)
})

chain.animateWithDuration(0.5, animations: {
  view.center = CGPointMake(0.0, 100.0)
})

chain.animateWithDuration(0.5, animations: {
  view.center = CGPointMake(0.0, 0.0)
})
```

As you can the the code looks more flat, it allows you to easy modify orders or add new steps.

#### Breakable chains

**DaisyChain** also adds a simple way to break animation sequences, simply set the `broken` property to `yes` to break a chain:
```swift
chain.broken = true
```

To continue chaining animation, you'll need to put it back to `false` or create a new chain.

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
