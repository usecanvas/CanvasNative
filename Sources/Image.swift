//
//  Image.swift
//  CanvasNative
//
//  Created by Sam Soffes on 11/25/15.
//  Copyright © 2015 Canvas Labs, Inc. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Image: Attachable, Equatable {

	// MARK: - Properties

	public var range: NSRange
	public var nativePrefixRange: NSRange

	public var identifier: String
	public var url: NSURL?
	public var size: CGSize?

	public var dictionary: [String: AnyObject] {
		var dictionary: [String: AnyObject] = [
			"type": "ordered-list",
			"range": range.dictionary,
			"nativePrefixRange": nativePrefixRange.dictionary,
			"identifier": identifier
		]

		if let url = url {
			dictionary["url"] = url.absoluteString
		}

		if let size = size {
			dictionary["size"] = size.dictionary
		}

		return dictionary
	}

	public var hiddenRanges: [NSRange] {
		return [nativePrefixRange]
	}


	// MARK: - Initializers

	public init?(string: String, range: NSRange) {
		self.range = range
		nativePrefixRange = NSRange(location: range.location, length: range.length - 1)
		
		let scanner = NSScanner(string: string)
		scanner.charactersToBeSkipped = nil

		// url image
		if scanner.scanString("\(leadingNativePrefix)image\(trailingNativePrefix)", intoString: nil) {
			let urlString = (string as NSString).substringFromIndex(7).stringByReplacingOccurrencesOfString(" ", withString: "%20")
			
			if let url = NSURL(string: urlString) {
				self.identifier = urlString
				self.url = url
				self.size = nil
				return
			}

			return nil
		}

		// Uploaded image delimiter
		scanner.scanLocation = 0
		if !scanner.scanString("\(leadingNativePrefix)image-", intoString: nil) {
			return nil
		}

		var json: NSString? = ""
		scanner.scanUpToString(trailingNativePrefix, intoString: &json)

		if !scanner.scanString(trailingNativePrefix, intoString: nil) {
			return nil
		}

		guard let data = json?.dataUsingEncoding(NSUTF8StringEncoding),
			raw = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
			dictionary = raw as? [String: AnyObject]
		else {
			return nil
		}

		let urlString = (dictionary["url"] as? String)?.stringByReplacingOccurrencesOfString(" ", withString: "%20")
		let ci = dictionary["ci"] as? String

		// We need some identifier
		guard let identifier = ci ?? urlString else { return nil }

		self.identifier = identifier
		self.url = urlString.flatMap { NSURL(string: $0) }

		if let width = dictionary["width"] as? UInt, height = dictionary["height"] as? UInt {
			size = CGSize(width: Int(width), height: Int(height))
		} else {
			size = nil
		}
	}


	// MARK: - Node

	public mutating func offset(delta: Int) {
		range.location += delta
		nativePrefixRange.location += delta
	}


	// MARK: - Native

	public static func nativeRepresentation(URL URL: NSURL) -> String {
		return "\(leadingNativePrefix)image\(trailingNativePrefix)\(URL.absoluteString)"
	}
}


extension Image: Hashable {
	public var hashValue: Int {
		return identifier.hashValue
	}
}


public func == (lhs: Image, rhs: Image) -> Bool {
	return NSEqualRanges(lhs.range, rhs.range) &&
		NSEqualRanges(lhs.nativePrefixRange, rhs.nativePrefixRange) &&
		lhs.identifier == rhs.identifier &&
		lhs.url == rhs.url &&
		lhs.size == rhs.size
}
