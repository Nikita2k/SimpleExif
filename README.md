# SimpleExif

SimpleExif is objective-c library allowing you to write UIImage along with its metadata(EXIF data), add creation date to UIImage, add location data to UIImage. It helps you to write exif metadata to an image (not the camera roll, just a UIImage or JPEG). This is just a handy wrapper around system functions to add some Exif information to UIImages in your app. It can be useful for apps manipulating photos. For example, you can add some thirg party photo editor and persist EXIF data with edited UIImage. 

This library doesn't support getting Exif data from UIImage!

Currently SimpleExif supports adding:
- User comments
- Created timestamp
- Location

# Installation

Just add `pod 'SimpleExif'` to your Podfile!

# How to write exif metadata to an image?

Working example can be found in Project dir, but here is the basics:

First create a `ExifContainer`:

`ExifContainer *container = [[ExifContainer alloc] init];`

and populate it with all requred data:

```
[container addUserComment:@"A long time ago, in a galaxy far, far away"];
[container addCreationDate:[NSDate dateWithTimeIntervalSinceNow:-10000000]];
[container addLocation:locations[0]];
  ```
  
Then you can add Exif data to UIImage:

`Data *imageData = [[UIImage imageNamed:@"DemoImage"] addExif:container];`
