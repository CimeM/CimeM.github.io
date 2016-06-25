---
published: true
title: Completion handler
layout: post
---
Completion handlers(CH) are convenient for requests, that might take some time before returning a value. CH is used to activate action when the request returns a response.

you can use it for WWW requests. And CH can hide the loading indicator and populate the screen with fresh content.

Dealing with language translation, my goal was to prepare a program where translated word should be received from the server onto my iOS app. Using FGTranslator pod from [Cocoapods](www.cocoapods.com) for managing the translations, I had to implement CH in Swift. Pod was written in Objective-C, so I created a bridge (bridge.h) and added it to the compiler:
{% highlight objectiveC %}
#import <FGTranslator/FGTranslator.h>

#ifndef wordLearning_Bridging_file_h
#define wordLearning_Bridging_file_h
#endif /* bridge_h */

{% end highlight %}

In objective C translation request looked like this:

{% highlight objectiveC %}
- (IBAction)translate:(UIButton *)sender
{
    [SVProgressHUD show];

    [self.textView resignFirstResponder];

    [self.translator translateText:self.textView.text
                   completion:^(NSError *error, NSString *translated, NSString *sourceLanguage)
    {
         if (error)
         {
             [self showErrorWithError:error];

             [SVProgressHUD dismiss];
         }
         else
         {
             NSString *fromLanguage = [[self currentLocale] displayNameForKey:NSLocaleIdentifier value:sourceLanguage];

             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:fromLanguage ? [NSString stringWithFormat:@"from %@", fromLanguage] : nil
                                                             message:translated
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];

             [SVProgressHUD dismiss];
         }
     }];
}
         }
     }];
}
{% endhilight %}

For every call there is a new session, meaning, the translator had to be called for every translation or other operation.
The action of translation is called when button press happens. Translation is later displayed in the alert window.

In swift this looks a bit different:
{% highlight swift %}

        localTranslator.translateText(alphaInputField?.text, completion: {(error, translation,sourceLanguage) in

            if (error != nil) {

                print(error)
            }
            else {
                self.betaInputField?.text = translation
                self.activityIndicator!.stopAnimating()
                self.submitButton?.enabled = true
                self.submitButton?.layer.borderColor = UIColor.blackColor().CGColor
                self.detectLanguage(self.alphaInputField!.text!, toLanguage: false)
                self.detectLanguage(self.betaInputField!.text!, toLanguage: true)

            }

        })
{% end highlight %}

This code is also triggered with a press of a button, but the translation is saved into a variable.

Thanks to https://grokswift.com/completion-handlers-in-swift/
for providing necessary information for this blog post