SIActionSheet
=============

iOS action sheet (simillar to UIActionSheet) but supporting Images. This class supports both iPhone and iPad including all resolutions and also popover from an UITabBarItem on iPad.

##USAGE

Create an SIActionSheet instance and add an Array of SIActionElement objects to supply the different options.
Supply code blocks for every option and/or completition or cancelation of this sheet.
Then show your sheet by sending "show" to your instance object.

If you want to create a queue of sheets, add the next sheet to the previous one by assigning it to the followUpSheet property.

##EXAMPLE

    SIActionSheet* mySheet = [SIActionSheet actionSheetWithTitle:@"Action Sheet title"
        andObjects:[NSArray arrayWithObjects:
            [SIActionElement actionWithTitle:@"Item 1"
                image:[UIImage imageNamed:@"image"]
                andAction:^{NSLog(@"action 1");}]
        , nil]
        completition:^(int num) {
            NSLog(@"pressed %i", num);
        } cancel:^{NSLog(@"canceled");}];

    mySheet.followUpSheet = anotherSheet;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        [mySheet show];
    else
        [mySheet showFromTabBarItem:item inTabBar:tabBar];

##ARC

This is an non-arc class. Please make sure to compile it with ARC disabled if your project uses ARC.

##LICENSE

This class is provided as-is without any warranty. It can be used without attribution in any commercial or non-commercial project. If you make changes to this source code, please provide it back to the community on this github page: http://github.com/azplanlos/SIActionSheet
