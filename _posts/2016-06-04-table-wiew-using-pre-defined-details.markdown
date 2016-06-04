---
published: true
title: Table wiew - using pre-defined details
layout: post
---
Table view is one of predefined views, you can use, if you want to show a list of items. One of the things, worth mentioning is that there are predefined details we, as developers can take advantage detail of.

If you have build a table view, and want to construct a cell with an image, a title and a detail text. You can use a predefined layout which came with Xcode. I discovered this by accident and saved me a lot of time when creating an app with list view, where an image and 2 types of text had to be displayed.


I made a list view in swift (you can do it as well if you take a look at this article: https://www.weheartswift.com/how-to-make-a-simple-table-view-with-ios-8-and-swift/

After that, just edit the cell like this:

cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = self.tableItems[indexPath.row]
        cell.detailTextLabel!.text = "some detail text"
        cell.imageView?.image = UIImage(named: "SampleCoverImge")

 
Be sure to create a cover image named "SampleCoverImage.jpg" and save it into Xcode.

Result:
![](https://dl.dropboxusercontent.com/s/l8waljgs6ne3oyz/Screen%20Shot%202016-05-31%20at%2011.13.08.png)

I have to thank www.weheartswift.com for providing useful articles.
With this project I learned  how to modify and create visual elements. Using the tutorial, the only thing that has to be done in Storyboard is to drag and drop the table view and connect the outlets (when connecting data source and delegate outlets).

Using Xcode 7.3.1