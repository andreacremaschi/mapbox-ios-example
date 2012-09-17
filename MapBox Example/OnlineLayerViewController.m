//
//  OnlineLayerViewController.m
//  MapBox Example
//
//  Created by Justin Miller on 3/27/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "OnlineLayerViewController.h"

#import "RMMapView.h"
#import "RMMapBoxSource.h"

#define kNormalSourceURL [NSURL URLWithString:@"http://a.tiles.mapbox.com/v3/justin.map-s2effxa8.jsonp"] // see https://tiles.mapbox.com/justin/map/map-s2effxa8
#define kRetinaSourceURL [NSURL URLWithString:@"http://a.tiles.mapbox.com/v3/justin.map-kswgei2n.jsonp"] // see https://tiles.mapbox.com/justin/map/map-kswgei2n

@implementation OnlineLayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    RMMapBoxSource *onlineSource = [[RMMapBoxSource alloc] initWithReferenceURL:(([[UIScreen mainScreen] scale] > 1.0) ? kRetinaSourceURL : kNormalSourceURL)];

    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:onlineSource];
    
    mapView.zoom = 18;
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    mapView.viewControllerPresentingAttribution = self;

    CLLocationCoordinate2D coord = {45.645203,9.996362};
    mapView.centerCoordinate =coord;

    
    RMAnnotation *anno = [[RMAnnotation alloc] initWithMapView:mapView
                                                    coordinate:coord
                                                      andTitle:@"test"];
    [mapView addAnnotation:anno];
    self.mapView = mapView;
    
    mapView.delegate = self;

    
    
    
    [self.view addSubview:mapView];
}

-(RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    RMShape *shape = [[RMShape alloc]initWithView:mapView];
    shape.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.7];

    CLLocationCoordinate2D coordinates[4];
    coordinates[0] = CLLocationCoordinate2DMake(45.646017,9.995906);
    coordinates[1] = CLLocationCoordinate2DMake(45.645635,9.997757);
    coordinates[2] = CLLocationCoordinate2DMake(45.644239,9.996276);
    coordinates[3] = CLLocationCoordinate2DMake(45.644198,9.995472);
    
    for (int i=0;i<4;i++)
    {
        if (i==0)
            [shape moveToCoordinate: coordinates[i]];
        else
            [shape addLineToCoordinate: coordinates[i]];
        
    }

    
    return shape;
}



@end