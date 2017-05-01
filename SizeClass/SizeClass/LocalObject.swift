//
//  LocalObject.swift
//  navigation
//
//  Created by Evgeni' Roslik on 06/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import Foundation


public class LocalObject:NSObject{
    
    public var uri:String;
    public var title:String;
    public var shortDesc:String;
    public var desc:String;
    
    init(uri:String, title:String, shordDesc:String, desc:String)
    {
        self.uri = uri;
        self.title = title;
        self.shortDesc = shordDesc;
        self.desc = desc;
    }
}
