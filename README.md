# LLDialog
Material design dialog for iOS written in Swift.



![](https://cloud.githubusercontent.com/assets/9763162/12781499/b909ede8-caaf-11e5-8dac-d5fce055aec0.png)


## Installation
Just move Source/LLDialog.swift to your project.

## Usage
You can see a sample example by downloading this project.

```
let dialog = LLDialog()

// Set title. (Not required)        
dialog.title = "Use Google's location service?"
        
// Set message. (Not required)
dialog.message = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."
        
// Set the buttons.
// Title for positive button is required. If set it to be “”, it will automatically change to “OK”
dialog.setPositiveButton(title: "AGREE", target: self, action: #selector(<#tappedPositiveButton#>))
dialog.setNegativeButton(title: "DISAGREE", target: self,  action: #selector(<#tappedNegativeButton#>))

// At last, show the dialog.       
dialog.show()
```

**DO NOT** set other attributes.

## TO DO
* The animation after tapping the button.
