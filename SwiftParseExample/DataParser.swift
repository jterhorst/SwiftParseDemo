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
        if _parsingContext == nil {
			_parsingContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
            _parsingContext!.parentContext = self.managedObjectContext;
        }
        return _parsingContext!;
    }
    var _parsingContext: NSManagedObjectContext? = nil;
    
	func parseFromFile() {

		self.parsingContext.performBlock {

			let payloadPath = NSBundle.mainBundle().pathForResource("payload", ofType: "json")
			let jsonInputStream = NSInputStream(fileAtPath: payloadPath!)
			jsonInputStream?.open()

			var jsonPayload = NSArray()
            do {
                try jsonPayload = NSJSONSerialization.JSONObjectWithStream(jsonInputStream!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            } catch let jsonError as NSError {
                print("parse error: \(jsonError)")
            }
			// I don't do any error-catching in this example, but you should in the real world

			for releaseDict in jsonPayload {
				let releaseObject = NSEntityDescription.insertNewObjectForEntityForName("PressRelease", inManagedObjectContext: self.parsingContext) as NSManagedObject

				releaseObject.setValue(releaseDict["about"], forKey: "about")
				releaseObject.setValue(releaseDict["email"], forKey: "email")
				releaseObject.setValue(releaseDict["guid"], forKey: "guid")
				releaseObject.setValue(releaseDict["name"], forKey: "name")
				releaseObject.setValue(releaseDict["phone"], forKey: "phone")
				releaseObject.setValue(releaseDict["id"], forKey: "remoteId")

				let parsingContext = self.parsingContext
                
                do {
                    try parsingContext.save()
                } catch let parseError as NSError {
                    print("parse error: \(parseError)")
                }
				
			}
		}

    }
    
}