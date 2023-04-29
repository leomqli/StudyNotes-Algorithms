//
//  21.MergeTwoLists.swift
//  Algorithms
//
//  Created by Leo on 2022-12-05.
//
//  21.合并两个有序链表
//  https://leetcode.cn/problems/merge-two-sorted-lists

extension Algorithm {
    static func test21() {
        let l1 = [1,2,4], l2 = [1,3,4]
        let list1 = ListNode.getListNode(l1)
        let list2 = ListNode.getListNode(l2)
        let list3 = Solution().mergeTwoLists1(list1, list2)
        let result = ListNode.getResult(list3)
        print(result)
    }
}

extension Solution {
	
	/// 方法一：递归
	///
	/// 思路
	/// 我们可以如下递归地定义两个链表里的 merge 操作（忽略边界情况，比如空链表等）：
	/// {
	/// 	list1[0] + merge(list1[1:],list2)  list1[0]<list2[0]
	/// 	list2[0]+merge(list1,list2[1:])    otherwise
	/// }
	/// 也就是说，两个链表头部值较小的一个节点与剩下元素的 merge 操作结果合并。
	///
	/// 复杂度分析
	/// 时间复杂度：O(n+m)，其中 n 和 m 分别为两个链表的长度。
	/// 因为每次调用递归都会去掉 list1 或者 list2 的头节点（直到至少有一个链表为空），函数 mergeTwoList 至多只会递归调用每个节点一次。
	/// 因此，时间复杂度取决于合并后的链表长度，即 O(n+m)。
	///
	/// 空间复杂度：O(n+m)，其中 n 和 m 分别为两个链表的长度。
	/// 递归调用 mergeTwoLists 函数时需要消耗栈空间，栈空间的大小取决于递归调用的深度。
	/// 结束递归调用时 mergeTwoLists 函数最多调用 n+m 次，因此空间复杂度为 O(n+m)。
	///
	/// 结果
	/// 时间 12 ms 击败 56.11%
	/// 内存 13.8 MB 击败 62.7%
	func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
		if list1 == nil {
			return list2
		} else if list2 == nil {
			return list1
		} else if list1!.val <= list2!.val {
			list1?.next = mergeTwoLists(list1?.next, list2)
			return list1
		} else {
			list2?.next = mergeTwoLists(list1, list2?.next)
			return list2
		}
	}
    
    /// 方法二：迭代（ 暴力遍历法）
    ///
    /// 时问复杂度：O(M + N)
    /// 空间复杂度：O(1)
    func mergeTwoLists1(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let result = ListNode()
        
        var left: ListNode? = list1
        var right: ListNode? = list2
        var node: ListNode? = result
        
        while left != nil || right != nil {
            if left == nil {
                node?.next = right
                right = right?.next
            } else if right == nil {
                node?.next = left
                left = left?.next
            } else if left!.val < right!.val {
                node?.next = left
                left = left?.next
            } else {
                node?.next = right
                right = right?.next
            }
            node = node?.next
        }
        
        return result.next
    }
    
    /// 方法三：迭代（暴力遍历法优化）
	///
	/// 思路
	/// 我们可以用迭代的方法来实现上述算法。当 list1 和 list2 都不是空链表时，判断 list1 和 list2 哪一个链表的头节点的值更小，将较小值的节点添加到结果里，当一个节点被添加到结果里之后，将对应链表中的节点向后移一位。
    ///
	/// 复杂度分析
    /// 时问复杂度：O(M + N)，其中 n 和 m 分别为两个链表的长度。
	/// 因为每次循环迭代中，list1 和 list2 只有一个元素会被放进合并链表中， 因此 while 循环的次数不会超过两个链表的长度之和。
	/// 所有其他操作的时间复杂度都是常数级别的，因此总的时间复杂度为 O(n+m)。
    /// 空间复杂度：O(1)。我们只需要常数的空间存放若干变量。
	///
	/// 结果
	/// 时间 8 ms   击败 97.49%
	/// 内存 13.8 MB 击败 38.87%
    func mergeTwoLists2(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        
		let result = ListNode()
        var left: ListNode? = list1
        var right: ListNode? = list2
        var node: ListNode? = result
        
        while left != nil && right != nil {
            if left!.val < right!.val {
                node?.next = left
                left = left?.next
            } else {
                node?.next = right
                right = right?.next
            }
			
			// 一定要注意移动node指针！
            node = node?.next
        }
        
        node?.next = left == nil ? right : left
        
        return result.next
    }
}
