//
//  WeakPointerArrayTests.swift
//  WeakPointerArrayTests
//
//  Created by Nikolai Rybalko on 6/9/17.
//  Copyright © 2017 NickRybalko. All rights reserved.
//

import XCTest

@testable import WeakPointerArray

private final class WeakTestObject {
}

final class WeakPointerArrayTests: XCTestCase {
    
    func testRemoveOneElement() {
        var testData = makeTestData()
        let weakPointersArray = WeakPointerArray(testData)
        let indexOfRemovedItem = 3
        testData.remove(at: indexOfRemovedItem)
        weakPointersArray.enumerated().forEach { (offset, element) in
            let shouldBeNil = indexOfRemovedItem == offset
            let xor = shouldBeNil != (element != nil)
            assert(xor)
        }
    }

    func testCompact() {
        var testData = makeTestData()
        var weakPointersArray = WeakPointerArray(testData)
        testData.remove(at: 3)
        assert(weakPointersArray.count == count)
        weakPointersArray.compact()
        assert(weakPointersArray.count == count - 1)
        testData.removeAll()
        assert(weakPointersArray.count == count - 1)
        weakPointersArray.compact()
        assert(weakPointersArray.isEmpty)
    }

    func testSlice() {
        var testData = makeTestData()
        var weakPointerArray = WeakPointerArray(testData)
        let startSliceIndex = count - 6
        let endSliceIndex = count - 1
        let sliceRange = startSliceIndex...endSliceIndex
        let slice = Array(weakPointerArray[sliceRange])
        testData.removeAll()
        weakPointerArray.enumerated().forEach { (index, element) in
            let shouldContainValue = sliceRange.contains(index)
            let xor = shouldContainValue != (element == nil)
            assert(xor)
        }
        weakPointerArray.compact()
        assert(weakPointerArray.count == slice.count)
    }

    private var count: Int {
        return 10
    }

    private func makeTestData() -> [WeakTestObject] {
        let testData = (0..<count).map { _ in WeakTestObject() }
        return testData
    }

}
