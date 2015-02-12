# SimpleExif

SimpleExif is simple wrapped for system functions to add some Exif information to UIImages in your app. If can be useful for apps manipulating photos. For example, you can add some thirg party photo editor and would like to persist some exif data to edited image.

Currently SimpleExif supports adding:
- User comments
- Created timestamp
- Location

# Installation

Just add `pod 'SimpleExif'` to your Podfile!

# Usage

Working example can be found in Project dir, but here is the basics:

First create a `ExifContainer`:

`ExifContainer *container = [[ExifContainer alloc] init];`

and populate it with all requred data:

```
[container addUserComment:@"A long time ago, in a galaxy far, far away"];
[container addCreationDate:[NSDate dateWithTimeIntervalSinceNow:-10000000]];
[container addLocation:locations[0]];
  ```
  
Then you can add this data to image:

`Data *imageData = [[UIImage imageNamed:@"DemoImage"] addExif:container];`
