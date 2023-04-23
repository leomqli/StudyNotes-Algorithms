//
//  349.Intersection.swift
//  Algorithms
//
//  Created by Leo on 2022-11-26.
//
//  349.两个数组的交集
//  https://leetcode.cn/problems/intersection-of-two-arrays/

extension Algorithm {
    static func test349() {
        let nums1 = [1,2,2,1], nums2 = [2,2] // [2]
//        let nums1 = [4,9,5], nums2 = [9,4,9,8,4] // [4,9]
        print(Solution().intersection3(nums1, nums2))
    }
}

extension Solution {
    
    /// 两个哈希集合
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    /// 时间 16 ms   击败 67.42%
    /// 内存 14.1 MB 击败 25.84%
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var dic1 = [Int: Int](), dic2 = [Int: Int](), result: [Int] = []
        
        for num in nums1 {
            dic1[num] = num
        }
        
        for num in nums2 {
            if (dic1[num] != nil) {
                dic2[num] = num
            }
        }
        
        for res in dic2 {
            result.append(res.key)
        }
        
        return result
    }
    
    /// 两个集合
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    /// 时间 16 ms   击败 67.42%
    /// 内存 14.1 MB 击败 35.95%
    func intersection1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        // 这种方式比下面内存节省
        // 内存 14.2 MB 击败 5.62%
        var dic1 = Set(nums1), dic2 = Set<Int>()

        for num in nums2 {
            if dic1.contains(num) {
                dic2.insert(num)
            }
        }
        
        return Array(dic2)
        
//        var set1 = Set<Int>()
//        var set2 = Set<Int>()
//
//        for num in nums1 {
//            set1.insert(num)
//        }
//
//        for num in nums2 {
//            if set1.contains(num) {
//                set2.insert(num)
//            }
//        }
//
//        return Array(set2)
    }
    
    /// 两个哈希集合
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    /// 时间 24 ms 击败 4.49%
    /// 内存 14 MB 击败 66.29%
    func intersection2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var result: [Int] = []

        for i in 0 ..< nums1.count {
            let num = nums1[i]
            if nums2.contains(num) && !result.contains(num) {
                result.append(num)
            }
        }
        
        return result
    }
    
    /// 排序 + 双指针
    ///
    /// 时间复杂度：O(mlog⁡m+nlog⁡n)，其中 m 和 n 分别是两个数组的长度。
    /// 对两个数组排序的时间复杂度分别是 O(mlog⁡m) 和 O(nlog⁡n)，
    /// 双指针寻找交集元素的时间复杂度是 O(m+n)，因此总时间复杂度是 O(mlog⁡m+nlog⁡n)。
    ///
    /// 空间复杂度：O(log⁡m+log⁡n)，其中 m 和 n 分别是两个数组的长度。
    /// 空间复杂度主要取决于排序使用的额外空间。
    /// 时间 16 ms 击败 67.42%
    /// 内存 14 MB 击败 46.7%
    func intersection3(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let newNums1 = nums1.sorted()
        let newNums2 = nums2.sorted()
        var index = 0, left = 0, right = 0, result: [Int] = []
        
        while left < nums1.count && right < newNums2.count {
            
            let num1 = newNums1[left]
            let num2 = newNums2[right]
            
            if num1 < num2 {
                left += 1
            } else if num1 > num2 {
                right += 1
            } else {
                // 等价于 if !result.contains(num1)
                if index == 0 || result[index - 1] != num1 {
                    result.append(num1)
                    index += 1
                }
                left += 1
                right += 1
            }
        }
        
        return result
    }
}
