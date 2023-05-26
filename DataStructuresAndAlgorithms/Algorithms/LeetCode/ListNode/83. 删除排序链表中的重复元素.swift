//
//  83. 删除排序链表中的重复元素.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-12-05.
//
//  https://leetcode.cn/problems/remove-duplicates-from-sorted-list


extension Algorithm {
    static func test83() {
        let head = [1,1,2]
        let list = ListNode.getListNode(head)
        let list2 = Solution().deleteDuplicates(list)
        let result = ListNode.getResult(list2)
        print(result)
    }
}

extension Solution {
    
    /// 遍历法
    ///
    /// 时间复杂度：O(n)。时间 20 ms 击败 79.75%
    /// 空间复杂度：O(1)。内存 13.9 MB 击败 56.96%
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
                
        var cur = head
        
        while cur != nil {
            if cur!.val == cur!.next?.val {
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        
        return head
    }
}
