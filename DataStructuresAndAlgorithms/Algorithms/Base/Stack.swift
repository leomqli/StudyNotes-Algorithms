//
//  Stack.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/4/26.
//
//  栈

import Foundation

struct Stack<T> {
	
	var array: Array<T>
	
	init() {
		array = Array<T>()
	}
	
	var isEmpty: Bool {
		return array.isEmpty
	}
	
	var top: T? {
		return array.last
	}
	
	mutating func push(_ item: T) {
		array.append(item)
	}
	
	mutating func pop() -> T? {
		return array.popLast()
	}
}
