# LLDialog
Material design dialog for iOS written in Swift.



![](https://cloud.githubusercontent.com/assets/9763162/12615088/9ea0e748-c53e-11e5-8910-b40bbb613829.png)


## Installation
Just move Source/LLDialog.swift to your project.

## Usage
```
let dialog = LLDialog()
  
// Set title.
dialog.title = "Use Google's location service?"

// Set content.
dialog.content = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."

// Set the buttons
dialog.setYesButton("AGREE", target: "your function's name")
dialog.setNoButton("DISAGREE", target: "your function's name")

// Don't forget this line.
dialog.refreshUI()

// At last, add it to your view.
self.view.addSubview(dialog)
```

Except title, content and yes/no button, DO NOT set other attributes.

## TO DO
* The animation after tapping the button.
* The dark shadow around dialog.
