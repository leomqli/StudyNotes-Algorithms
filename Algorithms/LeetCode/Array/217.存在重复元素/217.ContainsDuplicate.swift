//
//  217.ContainsDuplicate.swift
//  Algorithms
//
//  Created by Leo on 2022-11-23.
//
//  217.存在重复元素
//  https://leetcode.cn/problems/contains-duplicate

extension Algorithm {
    static func test217() {
        let nums = [1,2,3,1]
//        let nums = [1,2,3,4]
//        let nums = [1,1,1,3,3,4,3,2,4,2]
        print(Solution().containsDuplicate(nums))
    }
}

extension Solution {
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        var map: [Int: Int] = [:]
        
        for num in nums {
            if map[num] != nil {
                return true
            }
            map[num] = num
        }
        
        return false
    }
    
    
    func containsDuplicate1(_ nums: [Int]) -> Bool {
        
        var set: Set<Int> = []
        
        for num in nums {
            if set.contains(num) {
                return true
            }
            set.insert(num)
        }
        return false
    }
    
    func containsDuplicate2(_ nums: [Int]) -> Bool {
        let set = Set<Int>(nums)
        return set.count != nums.count
    }
}
