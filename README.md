## SwiftyLayout
##### Swift helpers for UIKit Autolayout

SwiftyLayout is an easy way to work with UIKit's Autolayout in Swift.

### A quick introduction

`UIView` and `UILayoutGuide` both conform to `AutolayoutTarget`. Constraints such as width or centering can be made between any two of these using the `BinaryConstraint` enum. Constraints on a single target, such as a fixed width or aspect ratio, can be made using the `UnaryConstraint` enum.

The appropriate functions in `AutolayoutTarget+Constraints` allow binary and unary constraints to be added to a target, for example:

```
viewOne.constrain(to: viewTwo, .centered, .width, .height(multiplier: 0.5))
viewOne.constrain(.squareAspectRatio)
```

There are helper functions to constrain to the view's superview, or the safe area, layout guide or readable layout guide of the superview:

```
viewOne.constrainToSuperviewSafeArea(.width)
```

Each function can set the resulting constraints' priority, and returns the created `NSLayoutConstraint` object(s) in an array:

```
let constraints: [NSLayoutConstraint] = viewOne.constrainToSuperview(priority: .defaultLow, .fill)
```
