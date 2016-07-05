---
published: true
title: Drawing App Tutorial
layout: post
---
In this lesson, you create the main screen of the Drawing app. You will create a single view app with sketch scene. You will position special buttons that will represent pen settings and accommodate other buttons for interaction. The end result will look like this:

![](https://dl.dropboxusercontent.com/s/93yk6smi11d4s35/finalAppplusDrawing.png)


Learning Objectives:

- Create a single view app

- Learn to use Cocoapods

- Use additional functionality of the drawing pod

- Save drawings

### Download the pod
Create a single view project in Xcode (File>New Project). Name it Drawing app.
![](https://dl.dropboxusercontent.com/s/mo1i3my2el6et7q/appNaming.png)

Having Cocoapods installed, you can open the terminal and go to the folder your app is saved.

{% highlight C %}
cd /Documents/iOS/drawingApp/
vi Podfile
{% endhighlight %}

Vim editor will let you edit the file when pressing letter "i" (insert), insert the text:


{% highlight C %}
platform :ios, '9.0'
target 'drawingApp' do
    use_frameworks!
    pod 'TouchDraw', '~> 1.2'
end
{% endhighlight %}

then just install the pods with:

{% highlight C %}

pod install

{% endhighlight %}

That will take a minute or two.
Then just close the project in Xcode and open the project in the folder with suffix:   .xcworkspace

Screenshot of the pods installing from terminal:
![](https://dl.dropboxusercontent.com/s/00dy8kueqcl1ix1/podInstallTerminal.png)

### Create an opening scene

In xcode, open ViewController.swift.

At the beginning include the pod:

{% highlight C %}

import TouchDraw

{% endhighlight %}

At the beginning of the View controller you add an outlet to the drawing UIView.:

{% highlight C %}

class ViewController: UIViewController, TouchDrawViewDelegate {
    @IBOutlet var drawView: TouchDrawView!

{% endhighlight %}

You see that we added TouchDrawViewDelegate protocol conformation as well.


Add aditional methods to the ViewController class to conform to the DelegateProtocol:

{% highlight C %}

// MARK: - TouchDrawViewDelegate
    func undoEnabled() {}
    func undoDisabled() {}
    func redoEnabled() {}
    func redoDisabled() {}
    func clearEnabled() {}
    func clearDisabled(){}

{% endhighlight %}

The next step is to add a UIView to the Storyboard. Open the Storyboard and find UIView from the object library on the right side. (Alternatively, choose View > Utilities > Show Object Library.)

Drag the UIView from the library into the canvas of the existing view.

Now edit the size of the UIView. Click on it in your canvas. Then click on the constraints icon and edit the size of the UIView as you see on the image.
![](https://dl.dropboxusercontent.com/s/ifym8ax1qbnbhba/UIViewConstrains.png)

In the scene view, click on the yellow symbol and remove the warnings with updating the frames. This will stretch the UIView on your canvas according to the rules.
![](https://dl.dropboxusercontent.com/s/kogf2gy75g0vcjq/updateFrames.png)

If you click onto the canvas, you will see that UIView is stretched all the way to the edges of the canvas(except for the bottom, where the buttons will be).

With the View selected in the canvas navigate to custom Class setting on the right side of the Xcode window and set the properties to :  Class: TouchDrawView and module: TouchDraw

![](https://dl.dropboxusercontent.com/s/a9onbgq4e437qxz/ClassSettingUIview.png)

MARK: set the emulator to your specific device (i chose iPhone 5s) and run the app. If everything is set correctly , compiling should be successful.

With your mouse you can drag onto the white field and you will draw your first sketch :)

![](https://dl.dropboxusercontent.com/s/mmqu1pgwo2oqapb/firstDrawing.png)

### Drawing Methods

Create methods into the main ViewController class for drawing onto the canvas:

{% highlight C %}

    func randomColor() -> UIColor {
            let r = CGFloat(random() % 255) / 255
            let g = CGFloat(random() % 255) / 255
            let b = CGFloat(random() % 255) / 255
            return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

{% endhighlight %}


Adding navigation Bar with buttons:

In the main class define an outlet: With control-drag option grab the created UIView and drag it into the ViewController. Create an outlet named drawView

You will end up with automatically created outlet:

![](https://dl.dropboxusercontent.com/s/pt2otk95brg5rxb/drawViewOutlet.png)


{% highlight C %}

 @IBOutlet var navBar: UINavigationBar!;

{% endhighlight %}

Then move into the viewDidLoad method and call:

"navbuttonSetup()"
also add the delegate:
"drawView.delegate = self"

Your viewDidLoad method looks like this:

{% highlight C %}

override func viewDidLoad() {
        super.viewDidLoad()
        navbuttonsSetup()
        drawView.delegate = self
    }

{% endhighlight %}


move down to the end of the class and define the method:

{% highlight C %}

func navbuttonsSetup() {

        self.navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        self.view.addSubview(navBar);

        let navItem = UINavigationItem(title: "drawApp");

        let undoButton = UIBarButtonItem(title: "<", style: .Done , target: self, action: #selector(ViewController.undo))
        let redoButton = UIBarButtonItem(title: ">", style: .Done , target: self, action: #selector(ViewController.redo))
        let clearButton = UIBarButtonItem(title: "Clear", style: .Done , target: self, action: #selector(ViewController.clear))

        navItem.leftBarButtonItems = [ undoButton, redoButton]
        navItem.rightBarButtonItem = clearButton
        self.navBar.setItems([navItem], animated: false);

    }

{% endhighlight %}



Under that method you also need to define the button methods:

{% highlight C %}

    func done(){
        self.performSegueWithIdentifier("unwindToTranslatorVC", sender: self)
        // TBD fix segue
        //self.navigationController?.popViewControllerAnimated(true)

    }
    func undo() {
        drawView.undo()
    }

    func clear() {
        drawView.clearDrawing()
    }

    @IBAction func redo(sender: AnyObject) {

        drawView.redo()
    }

{% endhighlight %}

MARK: Compile the app and you should notice the navigation bar at the top.
You should be able to use undo/redo buttons
![](https://dl.dropboxusercontent.com/s/9ktami1o16zba8i/navbarButtonsWorking.png)

### Pencil buttons

Now is the right time to write the pencil button actions.

Open Assets.xcassets in the Xcode. add drag the images for buttons available here: 

[Dropbox-pencils](https://www.dropbox.com/sh/amfma3u3vlbrxfd/AAAs6CzcUtnRShoEyS5fa70Ca?dl=1)

Open the StoryBard and add buttons from elements Library to the bottom of the canvas.
The first button should be positioned on the left side. All next buttons are the same size (you can alt-drag them)
Setting the background image to the button will resize it. You have to resize it by hand. Hold shift, so proportions will remain the same. You will end up with the button with the size: 37x68
![](https://dl.dropboxusercontent.com/s/qtokjzryfsaeicn/buttonsAddedAndProportions.png)


At the top, add default color:

{% highlight C %}

var localColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
@IBOutlet var colorButton: UIButton!

{% endhighlight %}

At the bottom of the class add:

{% highlight C %}

@IBAction func penButton(sender: UIButton) {
        drawView.setColor(localColor)
        drawView.setWidth(CGFloat(5))
        self.colorButton.enabled = true
    }

    @IBAction func flukiButton(sender: UIButton) {
        drawView.setColor(localColor)
        drawView.setWidth(CGFloat(10))
        self.colorButton.enabled = true
    }

    @IBAction func pencilButton(sender: UIButton) {
        drawView.setColor(localColor)
        drawView.setWidth(CGFloat(0.5))
        self.colorButton.enabled = true
    }

    @IBAction func eraserButton(sender: UIButton) {
        drawView.setWidth(CGFloat(70))
        drawView.setColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1.0))
        self.colorButton.enabled = false
    }
    @IBAction func colorButton(sender: UIButton) {
        let r = CGFloat(random() % 255) / 255
        let g = CGFloat(random() % 255) / 255
        let b = CGFloat(random() % 255) / 255

        localColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        self.colorButton.backgroundColor = localColor
        drawView.setColor(localColor)

    }

{% endhighlight %}

Add this actions by control-dragging from the buttons to the main class: View Controller. Don't forget to connect the colour button outlet at the top!

![](https://dl.dropboxusercontent.com/s/yrjnhfloq8s41yc/connectButtonsToCode.png)

MARK: Run the app and try clicking the buttons on the bottom. The color button will let you select random color every time it is pressed.

### Congratulations! Your MVP Drawing app is finished!

If you are having trouble with this tutorial, you can always clone the code from my repo here: 

[Github-DrawingAppTutorial](https://github.com/CimeM/DrawingAppTutorial)

Please notice, that this app is not ready for shipment! You are welcome to modify it in your own way.
 