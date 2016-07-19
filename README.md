# AMTableWithStickyView

[![CI Status](http://img.shields.io/travis/Andrei Makarevich/AMTableWithStickyView.svg?style=flat)](https://travis-ci.org/Andrei Makarevich/AMTableWithStickyView)
[![Version](https://img.shields.io/cocoapods/v/AMTableWithStickyView.svg?style=flat)](http://cocoapods.org/pods/AMTableWithStickyView)
[![License](https://img.shields.io/cocoapods/l/AMTableWithStickyView.svg?style=flat)](http://cocoapods.org/pods/AMTableWithStickyView)
[![Platform](https://img.shields.io/cocoapods/p/AMTableWithStickyView.svg?style=flat)](http://cocoapods.org/pods/AMTableWithStickyView)

## Example

To run the example project, clone the repo, and run from the Example directory.

## Screenshot
<img src="https://raw.github.com/makarevichAndrei/AMTableWithStickyView/0.1.0/screenshots/Simulator Screen Shot Jul 18, 2016, 22.58.20.png" width="200" height="360">
<img src="https://raw.github.com/makarevichAndrei/AMTableWithStickyView/0.1.0/screenshots/Simulator Screen Shot Jul 18, 2016, 22.58.28.png" width="200" height="360">
<img src="https://raw.github.com/makarevichAndrei/AMTableWithStickyView/0.1.0/screenshots/Simulator Screen Shot Jul 18, 2016, 22.58.38.png" width="200" height="360">
<img src="https://raw.github.com/makarevichAndrei/AMTableWithStickyView/0.1.0/screenshots/Simulator Screen Shot Jul 18, 2016, 22.59.14.png" width="200" height="360">
<img src="https://raw.github.com/makarevichAndrei/AMTableWithStickyView/0.1.0/screenshots/Simulator Screen Shot Jul 18, 2016, 22.59.21.png" width="200" height="360">

## Requirements

* iOS7
* ARC

## Installation

AMTableWithStickyView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AMTableWithStickyView', '0.1.0'
```

or

clone the repo and copy files from Classes directory to your project

##Usage

Import AMTableWithStickyView.

Create stickyView and tableView with delegate.

Create tableWithStickyView uising method: - (id)initWithTopView:(UIView *) topView tableView:(UITableView *)tableView;

Add tableWithStickyView to your view.


You can also change frame of tableWithStickyView using method: - (void)updateViewWithFrame:(CGRect)viewFrame;

## Author

Andrei Makarevich, makarevich.andrei@gmail.com

## License

AMTableWithStickyView is available under the MIT license. See the LICENSE file for more info.
