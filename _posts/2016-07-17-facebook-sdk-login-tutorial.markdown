---
published: true
title: Facebook SDK Login tutorial
layout: post
---
In this lesson, you will create an app that connects to your Facebook account. You will be able to connect (log in) to your account on Facebook. And retrieve some basic information from your profile.

![](https://dl.dropboxusercontent.com/s/nsxmaw6ouftry2i/finalAppFacebookLogin.png)

Learning Objectives:

- create a single app view

- Learn to create facebook app

- Use Cocoapods and import Facebook API

- Implement Facebook SDK, use some of its functionalities


Create a single view app. Name it 'FacebookLoginTest'.
Install 'Bolts' pod
Open Terminal app and change directory to your folder where you saved your app.
When located in that directory type:

{% highlight C %}

pod init

{% endhighlight %}


Then edit the pod file with

{% highlight C %}

vi Podfile

{% endhighlight %}

Insert necessary text, so your pod file will contain this:

{% highlight C %}

target 'facebookLoginTest' do
frameworks
  use_frameworks!
  pod 'Bolts'
end

{% endhighlight %}


Install pods by:

{% highlight C %}

pod install

{% endhighlight %}

When finished, open the .xcworkspace file with Xcode.

MARK: Compile your app ad run it in the simulator. It should compile without a problem.


Create facebook app.
Navigate to facebook developer site : https://developers.facebook.com , and find a button where you can create new App ID.

![](https://dl.dropboxusercontent.com/s/9rly2lsr7di1x4o/facebookdeveloper%20new%20app%20ID.png). This tutorial will not cover the whole process because facebook may change its procedure over time.


You should end up with your app. Open Settings of your app and add a platform.

![](https://dl.dropboxusercontent.com/s/00p7yxa1xbsu796/facebook%20new%20platform.png)

You should be able to select iOS app. Then insert your Bundle ID, which is available in Xcode:

![](https://dl.dropboxusercontent.com/s/4edngr9y67p66iu/bundleID%20xcode.png)


Flip the switch for 'Single Sign On' option. 
Don't close the page, because you will need to copy the Application ID soon.


Configure Frameworks:

Following [facebook instruction](https://developers.facebook.com/docs/ios/getting-started)  reveals steps you should follow. You will download Facebook SDK and later include frameworks to your Xcode project by drag-drop option. I have put frameworks directly into my Xcode project (from finder drag FBSDKLoginKit.framework and FBSDKCoreKit.framework to Xcode file menu). The instructions will lead you forward. That instruction will not be explained here because the time difference. Be sure to follow Facebook instructions because they are updated regularly.
Adding a header file connecting frameworks to your code is necessary.

Header file:

{% highlight C %}

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

{% endhighlight %}

MARK : Compile and load the app to your emulator. The project should compile with the frameworks installed.


In this final step, we will configure our iOS app.

Open 'AppDelegate.swift' and configure it in a way that you will end up with this:


{% highlight C %}

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url , sourceApplication: sourceApplication, annotation: annotation)

    }

{% endhighlight %}


Now, navigate to 'ViewController.swift' file and replace its content with:

{% highlight C %}

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()


        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self

        if let token = FBSDKAccessToken.currentAccessToken() {

            self.fetchToken()
        }

    }

    func fetchToken() {
        print ("fetch profile")

        let parameters = ["fields" : "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            //print(result)
            if let email = result["first_name"] as? String {
                print(email)
            }

            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                 print(url)
            }
        }
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("didlog out!")
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

{% endhighlight %}

MARK: Compile the code, the emulator will display a facebook button. Log in using your account information, and observe the log output.

If you take a closer look you will see that method 'fetchToken()' is responsible for displaying your information. Using completion handlers we are able to retrieve personal information from facebook. Continue hacking in this direction, and you will see that Facebook has provided us with a truly useful SDK. Enjoy!

After clicking the button, a browser will display a confirmation screen - you can see your app that you registered at the beginning. mine is 'Schamar'.

![](https://dl.dropboxusercontent.com/s/9lcsf2f0zicdjjs/simulator-screenshot-asking-for-approval.png)

When successfully logged in you will see a button showing you : Log out:
![](https://dl.dropboxusercontent.com/s/7jin8qxk701bvoq/simulator-fb-button-log-out.png)

In iOS 9, you are prompt to confirm your logout action.
![](https://dl.dropboxusercontent.com/s/ycc5uxqsjiu2w4p/confirmation-screen-emulator-log-ou-from-facebook.png)

The log window will display your name, as it is written in the code.
![](https://dl.dropboxusercontent.com/s/zsbbiuvs5n4dn9s/log%20facebook%20retrieving%20name.png)