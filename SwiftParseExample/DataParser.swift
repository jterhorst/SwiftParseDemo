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
			_parsingContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
            _parsingContext!.parentContext = self.managedObjectContext;
        }
        return _parsingContext!;
    }
    var _parsingContext: NSManagedObjectContext? = nil;
    
	func parseFromFile() {

		self.parsingContext.performBlock {

			var payloadPath = NSBundle.mainBundle().pathForResource("payload", ofType: "json")
			var jsonInputStream = NSInputStream(fileAtPath: payloadPath)
			jsonInputStream.open()

			var jsonPayload = NSJSONSerialization.JSONObjectWithStream(jsonInputStream, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
			// I don't do any error-catching in this example, but you should in the real world

			for releaseDict : NSDictionary! in jsonPayload {
				var releaseObject = NSEntityDescription.insertNewObjectForEntityForName("PressRelease", inManagedObjectContext: self.parsingContext) as NSManagedObject

				releaseObject.setValue(releaseDict["about"], forKey: "about")
				releaseObject.setValue(releaseDict["email"], forKey: "email")
				releaseObject.setValue(releaseDict["guid"], forKey: "guid")
				releaseObject.setValue(releaseDict["name"], forKey: "name")
				releaseObject.setValue(releaseDict["phone"], forKey: "phone")
				releaseObject.setValue(releaseDict["id"], forKey: "remoteId")

				var error: NSError? = nil
				let parsingContext = self.parsingContext
				!parsingContext.save(&error)
			}
		}

    }
    
}