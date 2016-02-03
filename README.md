# LLDialog
Material design dialog for iOS written in Swift.



![](https://cloud.githubusercontent.com/assets/9763162/12781499/b909ede8-caaf-11e5-8dac-d5fce055aec0.png)


## Installation
Just move Source/LLDialog.swift to your project.

## Usage
You can see a sample example by downloading this project.

```
let dialog = LLDialog()
  
// Set title.
dialog.title = "Use Google's location service?"

// Set content.
dialog.content = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."

// Set the buttons
dialog.setYesButton(self, title: "AGREE", action: "FUNCTION_NAME")
dialog.setNoButton(self, title: "DISAGREE", action: "FUNCTION_NAME")

// Don't forget this line.
dialog.refreshUI()

// At last, add it to your view.
self.view.addSubview(dialog)
```

Except title, content and yes/no button, DO NOT set other attributes.

## TO DO
* The animation after tapping the button.
