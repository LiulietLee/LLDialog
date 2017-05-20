# LLDialog
Material design dialog for iOS written in Swift.

![](https://cloud.githubusercontent.com/assets/9763162/12781499/b909ede8-caaf-11e5-8dac-d5fce055aec0.png)

## Installation
Just move Source/LLDialog.swift to your project. For extension targets, you need to add [NS_EXTENSION_UNAVAILABLE](https://developer.apple.com/library/content/documentation/General/Conceptual/ExtensibilityPG/ExtensionOverview.html) macro/compiler flag, unless the [bug](https://bugs.swift.org/browse/SR-1226) is solved.

## Usage
You can see a simple example by downloading this project.

```swift
let dialog = LLDialog()

// Set title. (Not required)
dialog.title = "Use Google's location service?"

// Set message. (Not required)
dialog.message = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."

// Set the buttons.
// Title for positive button is required. If set it to be a "blank" string, it will automatically change to "OK"
dialog.setPositiveButton(withTitle: "AGREE", target: self, action: #selector(<#tappedPositiveButton#>))
dialog.setNegativeButton(withTitle: "DISAGREE", target: self, action: #selector(<#tappedNegativeButton#>))

// At last, show the dialog.       
dialog.show()
```

**DO NOT** set other attributes.

## TO DO
* The animation after tapping the button.
