//
//  350. 两个数组的交集 II.swift
//  Algorithms
//
//  Created by Leo on 2022-11-26.
//
//  https://leetcode.cn/problems/intersection-of-two-arrays-ii

/*

 给你两个整数数组 nums1 和 nums2，请你以数组形式返回两数组的交集。
 返回结果中每个元素出现的次数，应与元素在两个数组中都出现的次数一致（如果出现次数不一致，则考虑取较小值）。可以不考虑输出结果的顺序。
 
 示例 1：
 输入：nums1 = [1,2,2,1], nums2 = [2,2]
 输出：[2,2]
 
 示例 2:
 输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
 输出：[4,9]

 提示：
 1 <= nums1.length, nums2.length <= 1000
 0 <= nums1[i], nums2[i] <= 1000

 进阶：
 * 如果给定的数组已经排好序呢？你将如何优化你的算法？
 * 如果 nums1 的大小比 nums2 小，哪种方法更优？
 * 如果 nums2 的元素存储在磁盘上，内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办？
 */

extension Algorithm {
    static func test350() {
//        let nums1 = [1,2,2,1], nums2 = [2,2] // [2,2]
        let nums1 = [4,9,5], nums2 = [9,4,9,8,4] // [4,9]
        print(Solution().intersect1(nums1, nums2))
    }
}

extension Solution {
    
    /// 排序 + 双指针
    ///
    /// 时间复杂度：O(mlog⁡m+nlog⁡n)，其中 m 和 n 分别是两个数组的长度。
    /// 对两个数组排序的时间复杂度分别是 O(mlog⁡m) 和 O(nlog⁡n)，
    /// 双指针寻找交集元素的时间复杂度是 O(m+n)，因此总时间复杂度是 O(mlog⁡m+nlog⁡n)。
    ///
    /// 空间复杂度：O(log⁡m+log⁡n)，其中 m 和 n 分别是两个数组的长度。
    /// 空间复杂度主要取决于排序使用的额外空间。
    /// 如果nums2的元素存储在磁盘上，磁盘内存是有限的，并且你不能一次加载所有的元素到内存中。那么就无法高效地对nums2进行排序，因此推荐使用哈希表而不是此方法。在哈希表中，nums2只关系到查询操作，因此每次读取 nums2中的一部分数据，并进行处理即可。
    /// 时间 16 ms 击败 72.41%
    /// 内存 14 MB 击败 40.23%
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        let newNums1 = nums1.sorted()
        let newNums2 = nums2.sorted()
        var left = 0, right = 0, result: [Int] = []
        
        while left < nums1.count && right < newNums2.count {
            
            let num1 = newNums1[left]
            let num2 = newNums2[right]
            
            if num1 < num2 {
                left += 1
            } else if num1 > num2 {
                right += 1
            } else {
                result.append(num1)
                left += 1
                right += 1
            }
        }
        
        return result
    }
    
    /// 哈希表
    /// 时间复杂度：O(m+n)，其中 m 和 n 分别是两个数组的长度。需要遍历两个数组并对哈希表进行操作，哈希表操作的时间复杂度是 O(1)，因此总时间复杂度与两个数组的长度和呈线性关系。
    ///
    /// 空间复杂度：O(min⁡(m,n))，其中 m 和 n 分别是两个数组的长度。对较短的数组进行哈希表的操作，哈希表的大小不会超过较短的数组的长度。
    ///
    /// 时间 20 ms   击败 18.39%
    /// 内存 13.9 MB 击败 56.32%
    func intersect1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        // 为了降低空间复杂度，首先遍历较短的数组并在哈希表中记录每个数字以及对应出现的次数，然后遍历较长的数组得到交集。
        if nums1.count > nums2.count {
            return intersect1(nums2, nums1)
        }
                
        var dic = [Int: Int](), result: [Int] = []
        
        for num in nums1 {
            dic[num] = (dic[num] ?? 0) + 1
        }
        
        for num in nums2 {
            let count = dic[num]
            if count != nil && count != 0 {
                result.append(num)
                dic[num] = count! - 1
            }
        }
        
        return result
    }
    
}
