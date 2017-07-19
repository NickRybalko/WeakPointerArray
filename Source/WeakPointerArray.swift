//
//  WeakPointerArray.swift
//  WeakPointerArray
//
//  Created by Nikolai Rybalko on 6/9/17.
//  Copyright © 2017 NickRybalko. All rights reserved.
//

import Foundation

// MARK: -

///The WeakPointerArray represents a mutable collection created over Array, 
///but it holds weak references for objects(not strong as in Array).
///So objects may be destroyed even if array has references to them.

public struct WeakPointerArray<Element: AnyObject>: RandomAccessCollection, MutableCollection {
    fileprivate var storage: [Weak<Element>]

    // MARK: RandomAccessCollection

    public var startIndex: Int {
        return storage.startIndex
    }

    public var endIndex: Int {
        return storage.endIndex
    }

    public func index(after i: Int) -> Int {
        return i + 1
    }

    // MARK: MutableCollection

    public subscript(index: Int) -> Element? {
        get {
            return storage[index].value
        }
        set {
            storage[index] = Weak(newValue)
        }
    }

    // MARK: init

    public init() {
        storage = []
    }

}

// MARK: - RangeReplaceableCollection

extension WeakPointerArray: RangeReplaceableCollection {

    public init<S>(_ s: S) where S : Sequence, S.Iterator.Element == Element {
        storage = s.map(Weak.init)
    }

    public mutating func replaceSubrange<C>(
        _ subrange: Range<Int>,
        with newElements: C
        ) where C : Collection, C.Iterator.Element == Element? {
        let wrapperCollection = newElements.map { Weak($0) }
        storage.replaceSubrange(subrange, with: wrapperCollection)
    }

    
}

// MARK: - ExpressibleByArrayLiteral

extension WeakPointerArray: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        storage = elements.map(Weak.init)
    }

}

// MARK: - CustomReflectable

extension WeakPointerArray: CustomReflectable {
    public var customMirror: Mirror {
        let mirror = storage.map { $0.value }.customMirror
        return mirror
    }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible

extension WeakPointerArray: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        let description = storage.map { $0.value }.description
        return description
    }

    public var debugDescription: String {
        let debugDescription = storage.description
        return debugDescription
    }

}

// MARK: - compact

extension WeakPointerArray {

    /// Removes NULL values from the receiver.
    public mutating func compact() {
        storage = storage.filter { $0.value != nil }
    }
}

// MARK: - Weak wrapper

private struct Weak<Element: AnyObject> {

    private(set) weak var value: Element?

    init(_ value: Element?) {
        self.value = value
    }

}
