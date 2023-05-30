//
//  面试题 02.06. 回文链表.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/27.
//

/*
 
 https://leetcode.cn/problems/palindrome-linked-list-lcci/
 
 相同题目：
 234. 回文链表：https://leetcode.cn/problems/palindrome-linked-list/
 剑指 Offer II 027. 回文链表：https://leetcode.cn/problems/aMhZSa/
 
 编写一个函数，检查输入的链表是否是回文的。

 示例 1：
 输入： 1->2
 输出： false

 示例 2：
 输入： 1->2->2->1
 输出： true
  
 进阶：
 你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
 
 */

import Foundation

extension Solution {
	
	/// 思路
	/// 1. 找到前半部分链表的尾节点。
	/// 2. 反转后半部分链表。
	/// 3. 判断是否回文。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)。
	/// 空间复杂度：O(1)。
	///
	///	结果
	/// 时间 76 ms 击败 50%
	/// 内存 18.6 MB 击败 75%
	func isPalindrome5(_ head: ListNode?) -> Bool {
		
		var pA = head
		var pB = getHalfReverseList(head)
		
		while pA != nil {
			if pA?.val != pB?.val {
				return false
			}
			pA = pA?.next
			pB = pB?.next
		}
		
		return true
	}
}
