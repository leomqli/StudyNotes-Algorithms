//
//  RandomListNode.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/4/26.
//

import Foundation

public class Node {
	public var val: Int
	public var next: Node?
	public var random: Node?
	
	public init(_ val: Int) {
		self.val = val
		self.next = nil
		self.random = nil
	}
}

extension Node: Equatable {

	public static func ==(lhs: Node, rhs: Node) -> Bool {
		return lhs === rhs
	}
}

extension Node: Hashable {
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(val)
		hasher.combine(ObjectIdentifier(self))
	}
}

