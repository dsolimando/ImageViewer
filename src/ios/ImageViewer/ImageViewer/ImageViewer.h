//
//  ImageViewer.h
//  ImageViewer
//
//  Created by Damien Solimando on 18/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

@interface ImageViewer:CDVPlugin

-(void)show: (CDVInvokedUrlCommand*) command;

@end
