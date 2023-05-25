//
//  234. 回文链表.swift
//  Algorithms
//
//  Created by Leo on 2023/5/15.
//

import Foundation

/*
 
 https://leetcode.cn/problems/palindrome-linked-list/
 
 给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。
 
 示例 1：
 输入：head = [1,2,2,1]
 输出：true
 
 示例 2：
 输入：head = [1,2]
 输出：false
 
 */

extension Algorithm {
	
	static func test234() {
		let head = ListNode.getListNode([1,2,2,1])
		let result = Solution234().isPalindrome2(head)
		print(result)
	}
}

class Solution234 {
	
	/// 方法一：将值复制到数组中后用双指针法
	///
	/// 思路
	///	一共为两个步骤：
	///		1.复制链表值到数组列表中。
	///		2.使用双指针法判断是否为回文。
	///	第一步，我们需要遍历链表将值复制到数组列表中。我们用 currentNode 指向当前节点。
	///	每次迭代向数组添加 currentNode.val，并更新 currentNode = currentNode.next，当 currentNode = null 时停止循环。
	///
	///	执行第二步的最佳方法取决于你使用的语言。在 Python 中，很容易构造一个列表的反向副本，也很容易比较两个列表。
	///	而在其他语言中，就没有那么简单。因此最好使用双指针法来检查是否为回文。
	///	我们在起点放置一个指针，在结尾放置一个指针，每一次迭代判断两个指针指向的元素是否相同，若不同，返回 false；
	///	相同则将两个指针向内移动，并继续判断，直到两个指针相遇。
	///
	///	在编码的过程中，注意我们比较的是节点值的大小，而不是节点本身。正确的比较方式是：node_1.val == node_2.val，而 node_1 == node_2 是错误的。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。
	/// 	第一步： 遍历链表并将值复制到数组中，O(n)。
	/// 	第二步：双指针判断是否为回文，执行了 O(n/2) 次的判断，即 O(n)。
	/// 	总的时间复杂度：O(2n)=O(n)。
	/// 空间复杂度：O(n)，其中 n 指的是链表的元素个数，我们使用了一个数组列表存放链表的元素值。
	///
	///	结果
	/// 时间 656 ms 击败 92.79%
	/// 内存 32.7 MB 击败 6.31%
	func isPalindrome1(_ head: ListNode?) -> Bool {
		
		var list = [Int?]()
		var cur = head
		
		
		while cur != nil {
			list.append(cur?.val)
			cur = cur?.next
		}
				
		var l = 0
		var r = list.count - 1
		
		while l < list.count / 2 {
			guard list[l] == list[r] else { return false }
			l += 1
			r -= 1
		}
		
		return true
	}
	
	/// 方法二：递归
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。
	/// 空间复杂度：O(n)。其中 n 指的是链表的大小。
	/// 	我们要理解计算机如何运行递归函数，在一个函数中调用一个函数时，计算机需要在进入被调用函数之前跟踪它在当前函数中的位置（以及任何局部变量的值），
	/// 	通过运行时存放在堆栈中来实现（堆栈帧）。在堆栈中存放好了数据后就可以进入被调用的函数。
	/// 	在完成被调用函数之后，他会弹出堆栈顶部元素，以恢复在进行函数调用之前所在的函数。
	/// 	在进行回文检查之前，递归函数将在堆栈中创建 n 个堆栈帧，计算机会逐个弹出进行处理。
	/// 	所以在使用递归时空间复杂度要考虑堆栈的使用情况。
	///
	///	结果
	/// 时间 688 ms 击败 71.17%
	/// 内存 31.3 MB 击败 6.31%
	func isPalindrome2(_ head: ListNode?) -> Bool {
		frontPointer = head
		return recursivelyCheck(frontPointer)
	}
	
	var frontPointer: ListNode?
	
	func recursivelyCheck(_ node: ListNode?) -> Bool {
		if node != nil {
			if !recursivelyCheck(node?.next) { return false }
			if node?.val != frontPointer?.val { return false }
			frontPointer = frontPointer?.next;
		}
		return true
	}
	
	/// 方法三：快慢指针
	///
	///	思路
	///	避免使用 O(n) 额外空间的方法就是改变输入。
	///	我们可以将链表的后半部分反转（修改链表结构），然后将前半部分和后半部分进行比较。
	///	比较完成后我们应该将链表恢复原样。虽然不需要恢复也能通过测试用例，但是使用该函数的人通常不希望链表结构被更改。
	///
	///	该方法虽然可以将空间复杂度降到 O(1)，但是在并发环境下，该方法也有缺点。
	///	在并发环境下，函数运行时需要锁定其他线程或进程对链表的访问，因为在函数执行过程中链表会被修改。
	///
	///	算法
	///	整个流程可以分为以下五个步骤：
	///		1. 找到前半部分链表的尾节点。
	///		2. 反转后半部分链表。
	///		3. 判断是否回文。
	///		4. 恢复链表。
	///		5. 返回结果。
	///
	///	执行步骤一，我们可以计算链表节点的数量，然后遍历链表找到前半部分的尾节点。
	///	我们也可以使用快慢指针在一次遍历中找到：慢指针一次走一步，快指针一次走两步，快慢指针同时出发。当快指针移动到链表的末尾时，慢指针恰好到链表的中间。通过慢指针将链表分为两部分。
	///	若链表有奇数个节点，则中间的节点应该看作是前半部分。
	///
	///	步骤二可以使用「206. 反转链表」问题中的解决方法来反转链表的后半部分。
	///	步骤三比较两个部分的值，当后半部分到达末尾则比较完成，可以忽略计数情况中的中间节点。
	///	步骤四与步骤二使用的函数相同，再反转一次恢复链表本身。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n)，其中 n 指的是链表的元素个数。
	/// 空间复杂度：O(1)。我们只会修改原本链表中节点的指向，而在堆栈上的堆栈帧不超过 O(1)。
	///
	///	结果
	/// 时间 924 ms 击败 6.31%
	/// 内存 31.1 MB 击败 29.73%
	func isPalindrome3(_ head: ListNode?) -> Bool {
		
		let firstHalfEnd = endOfFirstHalf(head)
		let secondHalfStart = reverseList(firstHalfEnd?.next)
		
		var p1 = head
		var p2 = secondHalfStart
		
		var result = true
		
		while result && p2 != nil {
			if p1?.val != p2?.val {
				result = false
			}
			
			p1 = p1?.next
			p2 = p2?.next
		}

		firstHalfEnd?.next = reverseList(secondHalfStart)
		
		return result
	}
	
	func endOfFirstHalf(_ head: ListNode?) -> ListNode? {
		
		var fast = head
		var slow = head
		
		while fast?.next != nil && fast?.next?.next != nil {
			fast = fast?.next?.next
			slow = slow?.next
		}
		
		return slow
	}
	
	func reverseList(_ head: ListNode?) -> ListNode? {

		var pre: ListNode? = nil
		var cur = head

		while cur != nil {
			// 保存下一个节点
			let next = cur?.next
			// 将指向反转
			cur?.next = pre
			// 移动pre指针
			pre = cur
			// 移动cur指针
			cur = next
		}
		
		return pre
	}
}
