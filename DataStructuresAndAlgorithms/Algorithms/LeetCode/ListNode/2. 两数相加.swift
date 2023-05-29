//
//  2. 两数相加.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-20.
//
//  https://leetcode.cn/problems/add-two-numbers/solutions/

extension Algorithm {
    static func test2() {
        let l1 = ListNode.getListNode([9,9,9,9,9,9,9])
        let l2 = ListNode.getListNode([9,9,9,9])
        let l3 = Solution().addTwoNumbers(l1, l2)
        
        print(ListNode.getResult(l3))
    }
}

extension Solution {
    
	/// 方法一：递归
	///
	///	时间复杂度：O(m + n)，其中 m 和 n 分别为两个链表的长度。
	///	我们要遍历两个链表的全部位置，而处理每个位置只需要 O(1) 的时间。
	///
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 36 ms   击败 70.17%
	/// 内存 14 MB 击败 5.68%
    func addTwoNumbers(_ l1: ListNode?,
                       _ l2: ListNode?) -> ListNode? {
        return add(l1, l2, 0)
    }

    func add(_ l1: ListNode?,
             _ l2: ListNode?,
             _ carry: Int) -> ListNode? {
        
        if l1 == nil && l2 == nil && carry == 0 {
            return nil
        }
        
        let val1 = l1?.val ?? 0
        let val2 = l2?.val ?? 0
        let sum = carry + val1 + val2
                
        return ListNode(sum % 10, add(l1?.next, l2?.next, sum / 10))
    }
	
	/// 方法二：模拟
	///
	///	时间复杂度：O(m + n)，其中 m 和 n 分别为两个链表的长度。
	///	我们要遍历两个链表的全部位置，而处理每个位置只需要 O(1) 的时间。
	///
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 32 ms   击败 90.63%
	/// 内存 13.9 MB 击败 32.95%
	func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		var list1 = l1
		var list2 = l2
		
		let result = ListNode()
		
		var current = result
		var sum = 0
		
		while list1 != nil || list2 != nil || sum > 0 {
			if let tmp = list1 {
				sum += tmp.val
				list1 = tmp.next
			}
			
			if let tmp = list2 {
				sum += tmp.val
				list2 = tmp.next
			}
			
			current.next = ListNode(sum % 10)
			sum /= 10
			current = current.next!
		}
		
		return result.next
	}
	
	/// 2023年5月29日
	///
	/// 方法二：模拟
	///
	///	时间复杂度：O(m+n)，其中 m 和 n 分别为两个链表的长度。
	///	我们要遍历两个链表的全部位置，而处理每个位置只需要 O(1) 的时间。
	///
	///	空间复杂度：O(1)。注意返回值不计入空间复杂度。
	///
	/// 时间 36 ms   击败 70.17%
	/// 内存 13.9 MB 击败 29.83%
	func addTwoNumbers3(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		
		var pA = l1
		var pB = l2
		
		var head: ListNode? = nil
		var cur: ListNode? = nil
		var add = 0
		
		while pA != nil || pB != nil {
			
			add = add + (pA?.val ?? 0) + (pB?.val ?? 0)
			
			if head == nil {
				head = ListNode(add % 10)
				cur = head
			} else {
				cur?.next = ListNode(add % 10)
				cur = cur?.next
			}
			
			add /= 10
			
			pA = pA?.next
			pB = pB?.next
		}
		
		if add != 0 {
			cur?.next = ListNode(add)
		}
		
		return head
	}
}
