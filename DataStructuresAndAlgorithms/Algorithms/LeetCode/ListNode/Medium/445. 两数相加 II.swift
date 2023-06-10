//
//  445. 两数相加 II.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/6/10.
//

/*
 
 https://leetcode.cn/problems/add-two-numbers-ii/
 
 给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。

 你可以假设除了数字 0 之外，这两个数字都不会以零开头。
 
 进阶：如果输入链表不能翻转该如何解决？
 
 */

import Foundation

extension Algorithm {
	static func test445() {
		let l1 = ListNode.getListNode([1])
		let l2 = ListNode.getListNode([9,9])
		let result = Solution().addTwoNumbersII3(l1, l2)
		print(ListNode.getResult(result))
	}
}

extension Solution {
	
	/// 方法一：反转链表后相加，最后再反转
	///
	/// 复杂度分析
	/// 时间复杂度：O(m + n)。其中 m 是 l1 链表中的节点数， n 是 l2 链表中的节点数。需要遍历 m + n + (m + n) + (m + n) 遍。
	/// 空间复杂度：O(m + n)。
	///
	///	结果
	/// 时间 40 ms 击败 45%
	/// 内存 13.8 MB 击败 60%
	func addTwoNumbersII(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

		var l1 = reverseList445(l1)
		var l2 = reverseList445(l2)
		
		let new: ListNode? = ListNode(0)
		var cur = new
		var tmp = 0
		
		while l1 != nil || l2 != nil {
			
			var val = 0
			
			if let l1val = l1?.val,
			   let l2val = l2?.val {
				val = tmp + l1val + l2val > 9 ? tmp + l1val + l2val - 10 : tmp + l1val + l2val
				tmp = tmp + l1val + l2val > 9 ? 1 : 0
			} else if let l1val = l1?.val {
				if tmp == 1 {
					val = tmp + l1val > 9 ? tmp + l1val - 10 : tmp + l1val
					tmp = tmp + l1val > 9 ? 1 : 0
				} else {
					val = l1val
				}
			} else if let l2val = l2?.val {
				if tmp == 1 {
					val = tmp + l2val > 9 ? tmp + l2val - 10 : tmp + l2val
					tmp = tmp + l2val > 9 ? 1 : 0
				} else {
					val = l2val
				}
			}
			
			cur?.next = ListNode(val)
			l1 = l1?.next
			l2 = l2?.next
			cur = cur?.next
		}
		
		if tmp == 1 {
			cur?.next = ListNode(tmp)
		}
		
		let res = new?.next
		new?.next = nil
			
		return reverseList445(res)
	}
	
	func reverseList445(_ head: ListNode?) -> ListNode? {
		
		if head == nil || head?.next == nil { return head }
		
		var pre: ListNode? = nil
		var cur = head
		
		while cur != nil {
			let next = cur?.next
			cur?.next = pre
			pre = cur
			cur = next
		}
		
		return pre
	}
	
	/// 方法二：栈（使用数组）
	///
	///	思路
	///	把所有数字压入栈中，再依次取出相加。计算过程中需要注意进位的情况。
	///
	/// 复杂度分析
	/// 时间复杂度：O(max⁡(m,n))。其中 m 是 l1 链表中的节点数， n 是 l2 链表中的节点数。
	/// 空间复杂度：O(m + n)。
	///
	///	结果
	/// 时间 24 ms 击败 100%
	/// 内存 13.9 MB 击败 30%
	func addTwoNumbersII2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		
		var arr1 = [Int](), arr2 = [Int]()
		var l1 = l1, l2 = l2
		
		while l1 != nil {
			arr1.append(l1!.val)
			l1 = l1?.next
		}
		
		while l2 != nil {
			arr2.append(l2!.val)
			l2 = l2?.next
		}
		
		var res: ListNode? = nil
		var carry = 0
		
		while !arr1.isEmpty || !arr2.isEmpty || carry > 0 {
			let a = arr1.isEmpty ? 0 : arr1.removeLast()
			let b = arr2.isEmpty ? 0 : arr2.removeLast()
			var sum = a + b + carry
			
			carry = sum / 10
			sum %= 10
			
			let cur = ListNode(sum)
			cur.next = res
			res = cur
		}
		
		return res
	}
	
	/// 方法三：栈
	///
	///	思路
	///	把所有数字压入栈中，再依次取出相加。计算过程中需要注意进位的情况。
	///
	/// 复杂度分析
	/// 时间复杂度：O(max⁡(m,n))。其中 m 是 l1 链表中的节点数， n 是 l2 链表中的节点数。
	/// 空间复杂度：O(m + n)。
	///
	///	结果
	/// 时间 36 ms 击败 85%
	/// 内存 13.9 MB 击败 15%
	func addTwoNumbersII3(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		
		var arr1 = Stack<Int>(), arr2 = Stack<Int>()
		var l1 = l1, l2 = l2
		
		while l1 != nil {
			arr1.push(l1!.val)
			l1 = l1?.next
		}
		
		while l2 != nil {
			arr2.push(l2!.val)
			l2 = l2?.next
		}
		
		var res: ListNode? = nil
		var carry = 0
		
		while !arr1.isEmpty || !arr2.isEmpty || carry > 0 {
			let a = arr1.isEmpty ? 0 : arr1.pop() ?? 0
			let b = arr2.isEmpty ? 0 : arr2.pop() ?? 0
			var sum = a + b + carry
			
			carry = sum / 10
			sum %= 10
			
			let cur = ListNode(sum)
			cur.next = res
			res = cur
		}
		
		return res
	}
	
}
