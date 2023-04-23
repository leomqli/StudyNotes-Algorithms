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
    
    /// 暴力遍历法
    ///
    /// 时问复杂度：O(M + N)
    /// 空间复杂度：O(1)
    func mergeTwoLists(_ list1: ListNode?,
                       _ list2: ListNode?) -> ListNode? {
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
    
    /// 暴力遍历法优化
    ///
    /// 时问复杂度：O(M + N)，时间 12 ms   击败 54.5%
    /// 空间复杂度：O(1)，    内存 13.9 MB 击败 43.35%
    func mergeTwoLists1(_ list1: ListNode?,
                        _ list2: ListNode?) -> ListNode? {
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
            node = node?.next
        }
        
        node?.next = left == nil ? right : left
        
        return result.next
    }
    
    
}
