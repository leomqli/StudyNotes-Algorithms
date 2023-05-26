//
//  4. 寻找两个正序数组的中位数.swift
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2022-11-21.
//
//  https://leetcode.cn/problems/median-of-two-sorted-arrays/

extension Algorithm {
    static func test4() {
//        let nums1 = [1,3], nums2 = [2,2,2,3,3,4,4]
//        let nums1 = [1], nums2:[Int] = []
         let nums1 = [1,4], nums2 = [2,3,5,6]
        print(Solution().findMedianSortedArrays(nums1, nums2))
    }
}

extension Solution {
    func findMedianSortedArrays(_ nums1: [Int],
                                _ nums2: [Int]) -> Double {
        
        var left = 0, right = 0, preNum = 0, curNum = 0
        
        while left + right <= (nums1.count + nums2.count) / 2 {
            preNum = curNum
                        
            if left >= nums1.count || (right < nums2.count && nums1[left] > nums2[right]) {
                curNum = nums2[right]
                right += 1
            } else {
                curNum = nums1[left]
                left += 1
            }
        }
                
        if (nums1.count + nums2.count) % 2 == 0 {
            return Double(preNum + curNum) / 2.0
        } else {
            return Double(curNum)
        }
    }
}
