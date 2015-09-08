# RAC-Introduction
Introduction to ReactiveCocoa RAC

Adding the ReactiveCocoa Framework

The easiest way to add the ReactiveCocoa framework to your project is via CocoaPods. If you’ve never used CocoaPods before it might make sense to follow the Introduction To CocoaPods tutorial on this site, or at the very least run through the initial steps of that tutorial so you can install the prerequisites.

If you still have the RAC-Introduction project open in Xcode, then close it now. CocoaPods will create an Xcode workspace, which you’ll want to use instead of the original project file.

Open Terminal. Navigate to the folder where your project is located and type the following:

touch Podfile
open -e Podfile
This creates an empty file called Podfile and opens it with TextEdit. Copy and paste the following lines into the TextEdit window:

platform :ios, '7.0'
 
pod 'ReactiveCocoa', '2.1.8'
This sets the platform to iOS, the minimum SDK version to 7.0, and adds the ReactiveCocoa framework as a dependency.

Once you’ve saved this file, go back to the Terminal window and issue the following command:

pod install
You should see an output similar to the following:

Analyzing dependencies
Downloading dependencies
Installing ReactiveCocoa (2.1.8)
Generating Pods project
Integrating client project
 
[!] From now on use `RAC-Introduction.xcworkspace`.
This indicates that the ReactiveCocoa framework has been downloaded, and CocoaPods has created an Xcode workspace to integrate the framework into your existing application.

Open up the newly generated workspace, RAC-Introduction.xcworkspace, and look at the structure CocoaPods created inside the Project Navigator:



Running the app
----------------------
Please use ‘user’ as Username and ‘password’ as Password to proceed with Sign-in
