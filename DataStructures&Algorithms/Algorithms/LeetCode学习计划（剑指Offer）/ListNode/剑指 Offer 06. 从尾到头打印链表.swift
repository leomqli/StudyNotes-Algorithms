//
//  剑指 Offer 06. 从尾到头打印链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/4/26.
//
//  https://leetcode.cn/problems/cong-wei-dao-tou-da-yin-lian-biao-lcof/

import Foundation

extension Solution {
	
	func reversePrint(_ head: ListNode?) -> [Int] {
		print(reversePrint1(head))
		print(reversePrint2(head))
		print(reversePrint3(head))
		print(reversePrint4(head))
		print(reversePrint5(head))
		return []
	}
	
	/// 方法一：常规遍历+数组插入
	///
	/// 思路
	///	从头节点遍历到尾节点，使用数组，通过插入到第0位来存储节点值
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，n为数组所占的空间。
	///
	///	结果
	/// 时间 16 ms 击败 61.54%
	/// 内存 15.5 MB 击败 42.66%
	func reversePrint1(_ head: ListNode?) -> [Int] {
		
		var tmp = head
		var result = [Int]()
		
		while tmp != nil {
			result.insert(tmp!.val, at: 0)
			tmp = tmp?.next
		}
		
		return result
	}
	
	/// 方法二：常规遍历+数组反转
	///
	/// 思路
	///	从头节点遍历到尾节点，使用数组存储，最后反转数组
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，n为数组所占的空间。
	///
	///	结果
	/// 时间 16 ms 击败 61.54%
	/// 内存 15.5 MB 击败 44.76%
	func reversePrint2(_ head: ListNode?) -> [Int] {
		
		var tmp = head
		var result = [Int]()
		
		while tmp != nil {
			result.append(tmp!.val)
			tmp = tmp?.next
		}
		 
//		result = result.reversed()
		
		// 更高效的反转
		for i in 0 ..< result.count / 2 {
			result.swapAt(i, result.count-1-i)
		}
		
		return result.reversed()
	}
	
	/// 方法三：反转链表+遍历
	///
	/// 思路
	///	现将链表反转后，再从头遍历一边，这样不需要额外的栈空间
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，主要为数组所占空间。
	///
	///	结果
	/// 时间 24 ms 击败 9.9%
	/// 内存 14.6 MB 击败 96.5%
	func reversePrint3(_ head: ListNode?) -> [Int] {
		
		var pre: ListNode? = nil
		var cur = head
		
		while cur != nil {
			let next = cur?.next
			cur?.next = pre
			pre = cur
			cur = next
		}
		
		var result = [Int]()
		
		while pre != nil {
			result.append(pre!.val)
			pre = pre?.next
		}
		
		return result
	}
	
	/// 方法四：使用堆栈存储，然后出栈
	///
	/// 思路
	///	使用栈将节点保存，然后依次出栈
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，总消耗2n空间，主要为栈和结果数组所占空间。
	///
	///	结果
	/// 时间 24 ms 击败 9.9%
	/// 内存 14.6 MB 击败 96.5%
	func reversePrint4(_ head: ListNode?) -> [Int] {
		
		var stack = [Int]()
		var tmp = head
		
		while tmp != nil {
			stack.append(tmp!.val)
			tmp = tmp?.next
		}
		
		var result = [Int]()
		
		while !stack.isEmpty {
			result.append(stack.popLast()!)
		}
		
		return result
	}
	
	/// 方法五：递归回溯
	///
	/// 思路
	///	先通过递归遍历链表每个节点，直到为nil，然后回溯，将节点进数组
	///
	///	复杂度分析
	///	时间复杂度：O(n)，n 是该链表的长度。
	///	空间复杂度：O(n)，主要为数组所占空间。
	///
	///	结果
	/// 时间 12 ms 击败 92.31%
	/// 内存 15.6 MB 击败 11.19%
	func reversePrint5(_ head: ListNode?) -> [Int] {
		var result = [Int]()
		recursiveMethod(head, result: &result)
		return result
	}
	
	private func recursiveMethod(_ head: ListNode?, result: inout [Int]) {
		guard head != nil else { return }
		recursiveMethod(head?.next, result: &result)
		result.append(head!.val)
	}
	
}

