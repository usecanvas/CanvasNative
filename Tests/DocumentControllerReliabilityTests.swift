//
//  DocumentControllerReliabilityTests.swift
//  CanvasNative
//
//  Created by Sam Soffes on 3/8/16.
//  Copyright © 2016 Canvas Labs, Inc. All rights reserved.
//

import XCTest
import CanvasNative

class DocumentControllerReliabilityTests: XCTestCase {

	// MARK: - Properties

	let delegate = TestDocumentControllerDelegate()


	// MARK: - Tests

	func testReliabilityInsertMidParagraph() {
		let controller = DocumentController(backingString: "⧙doc-heading⧘Title\nOne\nTwo", delegate: delegate)
		controller.replaceCharactersInRange(NSRange(location: 21, length: 0), withString: "1")
		XCTAssertEqual(delegate.presentationString, controller.document.presentationString)
		XCTAssertEqual(blockTypes(controller.document.backingString), delegate.blockTypes)

		controller.replaceCharactersInRange(NSRange(location: 22, length: 0), withString: "2")
		XCTAssertEqual(delegate.presentationString, controller.document.presentationString)
		XCTAssertEqual(blockTypes(controller.document.backingString), delegate.blockTypes)
	}

//	func testReliabilityInsertMidListItem() {
//		controller.string = "⧙doc-heading⧘Title\n⧙unordered-list-0⧘- One"
//
//		controller.replaceCharactersInRange(NSRange(location: 41, length: 0), withString: "1")
//		XCTAssertEqual("⧙doc-heading⧘Title\n⧙unordered-list-0⧘- On1e", controller.string)
//		XCTAssertEqual("Title\nOn1e", delegate.presentationString)
//
//		controller.replaceCharactersInRange(NSRange(location: 42, length: 0), withString: "2")
//		XCTAssertEqual("⧙doc-heading⧘Title\n⧙unordered-list-0⧘- On12e", controller.string)
//		XCTAssertEqual("Title\nOn12e", delegate.presentationString)
//
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
//
//	func testReliabilityInsertBlock() {
//		controller.string = "⧙doc-heading⧘Demo\nParagraph.\n⧙ordered-list-0⧘1. One"
//
//		let range = NSRange(location: 28, length: 0)
//		let replacement = "\n"
//		let blockRange = controller.blockRangeForCharacterRange(range, string: replacement)
//		XCTAssertEqual(NSRange(location: 2, length: 0), blockRange)
//
//		controller.replaceCharactersInRange(range, withString: replacement)
//		XCTAssertEqual("⧙doc-heading⧘Demo\nParagraph.\n\n⧙ordered-list-0⧘1. One", controller.string)
//		XCTAssertEqual("Demo\nParagraph.\n\nOne", delegate.presentationString)
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
//
//	func testReliabilityDelete() {
//		controller.string = "⧙doc-heading⧘Title\nOne...\nTwo"
//
//		controller.replaceCharactersInRange(NSRange(location: 24, length: 1), withString: "")
//		XCTAssertEqual("⧙doc-heading⧘Title\nOne..\nTwo", controller.string)
//		XCTAssertEqual("Title\nOne..\nTwo", delegate.presentationString)
//
//		controller.replaceCharactersInRange(NSRange(location: 23, length: 1), withString: "")
//		XCTAssertEqual("⧙doc-heading⧘Title\nOne.\nTwo", controller.string)
//		XCTAssertEqual("Title\nOne.\nTwo", delegate.presentationString)
//
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
//
//	func testReliabilityEnd() {
//		controller.string = "⧙doc-heading⧘Title\nOne\nTwo"
//
//		var presentationRange = NSRange(location: 13, length: 0)
//		var backingRange = controller.backingRange(presentationRange: presentationRange)
//		var replacement = "."
//		var blockRange = controller.blockRangeForCharacterRange(backingRange, string: replacement)
//		XCTAssertEqual(NSRange(location: 2, length: 1), blockRange)
//		controller.replaceCharactersInRange(backingRange, withString: replacement)
//		XCTAssertEqual("⧙doc-heading⧘Title\nOne\nTwo.", controller.string)
//		XCTAssertEqual("Title\nOne\nTwo.", delegate.presentationString)
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//		
//		presentationRange = NSRange(location: 13, length: 1)
//		backingRange = controller.backingRange(presentationRange: presentationRange)
//		replacement = ""
//		blockRange = controller.blockRangeForCharacterRange(backingRange, string: replacement)
//		XCTAssertEqual(NSRange(location: 2, length: 1), blockRange)
//		controller.replaceCharactersInRange(backingRange, withString: "")
//		XCTAssertEqual("⧙doc-heading⧘Title\nOne\nTwo", controller.string)
//		XCTAssertEqual("Title\nOne\nTwo", delegate.presentationString)
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
//
//	func testCheckboxes() {
//		controller.string = "⧙doc-heading⧘Title\n⧙checklist-0⧘- [ ] Todo"
//		controller.replaceCharactersInRange(NSRange(location: 35, length: 1), withString: "x")
//		XCTAssertEqual("⧙doc-heading⧘Title\n⧙checklist-0⧘- [x] Todo", controller.string)
//		XCTAssertEqual("Title\nTodo", delegate.presentationString)
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
//
//	func testBlank() {
//		controller.string = "⧙doc-heading⧘Title\n"
//
//		let range = NSRange(location: 19, length: 0)
//		let replacement = "H"
//		let blockRange = controller.blockRangeForCharacterRange(range, string: replacement)
//		XCTAssertEqual(NSRange(location: 1, length: 0), blockRange)
//
//		controller.replaceCharactersInRange(range, withString: replacement)
//		XCTAssertEqual("⧙doc-heading⧘Title\nH", controller.string)
//		XCTAssertEqual("Title\nH", delegate.presentationString)
//		XCTAssertEqual(parse(controller.string), delegate.blockDictionaries)
//	}
}