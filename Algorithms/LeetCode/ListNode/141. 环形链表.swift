//
//  141. 环形链表.swift
//  Algorithms
//
//  Created by Leo on 2022-12-09.
//
//  https://leetcode.cn/problems/linked-list-cycle/

extension Algorithm {
	static func test141() {
        
    }
}

extension Solution {
    
    /// 方法一：哈希表
    /// 时间复杂度：O(N)，其中 N 是链表中的节点数。
    /// 最坏情况下我们需要遍历每个节点一次。
    ///
    /// 空间复杂度：O(N)，其中 N 是链表中的节点数。
    /// 主要为哈希表的开销，最坏情况下我们需要将每个节点插入到哈希表中一次。
    ///
    /// 时间 56 ms   击败 18.22%
    /// 内存 15.7 MB 击败 15.50%
    func hasCycle(_ head: ListNode?) -> Bool {
        var current = head
        var map = Set<ListNode>()
        
        while current != nil {
            if !map.insert(current!).inserted {
                return true
            }
            
            current = current?.next
        }
        
        return false
    }
    
    /// 快慢指针
    func hasCycle1(_ head: ListNode?) -> Bool {
        
        
        return false
    }
}
