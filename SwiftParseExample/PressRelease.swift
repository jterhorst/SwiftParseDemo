//
//  PressRelease.swift
//  SwiftParseExample
//
//  Created by Jason Terhorst on 7/23/14.
//  Copyright (c) 2014 Jason Terhorst. All rights reserved.
//

import Foundation
import CoreData

@objc(PressRelease)
class PressRelease: NSManagedObject {
	@NSManaged var about : NSString
	@NSManaged var email : NSString
	@NSManaged var guid : NSString
	@NSManaged var name : NSString
	@NSManaged var phone : NSString
	@NSManaged var remoteId : NSNumber

	/*
	func parseFromPayload(payload: NSDictionary) {
		self.about = payload["about"] as NSString
		self.email = payload["email"] as NSString
		self.guid = payload["guid"] as NSString
		self.name = payload["name"] as NSString
		self.phone = payload["phone"] as NSString
		self.remoteId = payload["id"] as NSNumber
	}
	*/
}
