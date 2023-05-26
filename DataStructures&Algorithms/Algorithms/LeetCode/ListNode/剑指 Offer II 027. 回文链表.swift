//
//  剑指 Offer II 027. 回文链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/25.
//

/*
 
 https://leetcode.cn/problems/aMhZSa/
 
 进阶：能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？

 注意：本题与主站 234 题相同：https://leetcode-cn.com/problems/palindrome-linked-list/
 */

import Foundation

extension Solution {
	
	/// 方法一：快慢指针
	///
	///	此算法破坏了原有数据结构，只为求快，因此还需参照234题恢复数据结构才行
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。
	/// 空间复杂度：O(1)。我们只会修改原本链表中节点的指向，而在堆栈上的堆栈帧不超过 O(1)。
	///
	///	结果
	/// 时间 700 ms 击败 42.86%
	/// 内存 25.2 MB 击败 100%
	func isPalindrome(_ head: ListNode?) -> Bool {
		
		var pA = head
		var pB = getHalfReverseList(head)
		
		while pB != nil {
			if pA?.val != pB?.val {
				return false
			}
			pA = pA?.next
			pB = pB?.next
		}
		
		return true
	}
	
	func getHalfReverseList(_ head: ListNode?) -> ListNode? {
		
		var fast = head
		var slow = head
		
		while fast != nil || fast?.next != nil {
			fast = fast?.next?.next
			slow = slow?.next
		}
		
		return gerReverseList(slow)
	}
	
	func gerReverseList(_ head: ListNode?) -> ListNode? {
		
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
	
}
