# TMTipsKit

This simple tips and hints kit was created to make process with creating and designing tip easier. 

![](https://raw.github.com/IhorShevchuk/TMTipsKit/readmeBranch/TipsKit/screen-2.png)
![](https://raw.github.com/IhorShevchuk/TMTipsKit/readmeBranch/TipsKit/screen-3.png)

## Installation
1) Add Folder `TipsAndHints` to project
2) Import file `TMTipsKit.h` to files where tips will be shown

## Usage
1) Design your own tips in `TipsViews.xib`.

2) Init tips with tips names
```objectivec
    [[TMTipsKit sharedInstance] initWithTipsNames:@[@"SimpleTip",@"SimpleTipTwo",@"SimpleTipsWithStyles"]];
```
3) Show tip in view using code
```objectivec
    [[TMTipsKit sharedInstance]  showTipWithName:@"SimpleTipTwo" forView:[self view]];
```

### Using styles in tips
#####Why we need it?
Some times you need show tip for text that is changing(ex: titles,names) and in `TipsViews.xib` we have static text. Same situation on background color: some times color depends on contex and we can't set static in `.xib` file.

#####Which styles can I change?
For now you can change next styles of views:

1) Text        -      TMViewStyleTypeText

2) Back groud color - TMViewStyleTypeBackgroundColor

3) Corner radius  -   TMViewStyleTypeCornerRadius


#####How we use it?
1) If you want you to use styles with tips subviews you should set this subviews tags to determine different subviews

![](https://raw.github.com/IhorShevchuk/TMTipsKit/readmeBranch/TipsKit/tagHelp.png)

2) Init an `NSArray` of `TMViewStyle` objects.
One object can be inited in this way
```objectivec
    TMViewStyle *viewStyle= [[TMViewStyle alloc]initWithViewTag:1 style:TMViewStyleTypeText andValue:customLabel.text]
 ```
3) And show tip using next way
```objectivec
    [[TMTipsKit sharedInstance]  showTipWithName:@"TipsWithStyles" forView:[self view] showOnlyOnce:YES andApplyToSubViewsStyles:viewStyles];
```
where `viewStyles` is `NSArray` object of `TMViewStyle` objects.

## License
