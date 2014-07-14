//
//  DataParser.swift
//  SwiftParseExample
//
//  Created by Jason Terhorst on 7/14/14.
//  Copyright (c) 2014 Jason Terhorst. All rights reserved.
//

import Foundation
import CoreData

class DataParser : NSObject {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var parsingContext :NSManagedObjectContext {
        if !_parsingContext {
            _parsingContext = NSManagedObjectContext()
            _parsingContext!.parentContext = self.managedObjectContext;
        }
        return _parsingContext!;
    }
    var _parsingContext: NSManagedObjectContext? = nil;
    
    func parseFromFile(filepath: NSString) {
        
        self.parsingContext.performBlock(<#block: (() -> Void)?#>)
        
    }
    
}