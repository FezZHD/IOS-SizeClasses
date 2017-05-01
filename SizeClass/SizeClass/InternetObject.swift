//
//  InternetObject.swift
//  navigation
//
//  Created by Evgeni' Roslik on 04/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import Foundation

public class JsonList:NSObject{

    var userId:Int;
    var id:Int;
    var title:String;
    var body:String;
    
    init(userId: Int, id:Int, title:String, body:String){
        self.userId = userId;
        self.id = id;
        self.title = title;
        self.body = body;
    }
}
 
