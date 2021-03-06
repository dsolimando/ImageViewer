//
//  ImageViewer.m
//  ImageViewer
//
//  Created by Damien Solimando on 18/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageViewer.h"
#import "ImageViewerViewController.h"

@implementation ImageViewer

-(void)show:(CDVInvokedUrlCommand *)command {
    
    CDVPluginResult* pluginResult = nil;
    NSString *urlString = command.arguments[0];
    NSArray<NSNumber*> *rgbColors = command.arguments[1];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ImageViewer" bundle:nil];
    ImageViewerViewController *controller = [sb instantiateInitialViewController];
    
    controller.urlString = urlString;
    controller.backgroundColor = rgbColors;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.viewController presentViewController:controller animated:YES completion:nil];
    
    if (!command.callbackId)
    return;
    
    if (urlString != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"image url cannot be null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end

