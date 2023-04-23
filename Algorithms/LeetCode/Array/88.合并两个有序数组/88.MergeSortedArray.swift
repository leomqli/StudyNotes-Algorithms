//
//  88.MergeSortedArray.swift
//  Algorithms
//
//  Created by Leo on 2022-11-26.
// 
//  88.合并两个有序数组
//  https://leetcode.cn/problems/merge-sorted-array

extension Algorithm {
    static func test88() {
        var nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3 // [1,2,2,3,5,6]
//        var nums1 = [1], m = 1, nums2 = [], n = 0 // [1]
//        var nums1 = [0], m = 0, nums2 = [1], n = 1 // [1]
        Solution().merge1(&nums1, m, nums2, n)
        print(nums1)
    }
}

extension Solution {
    
    /// 双指针
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    /// 时间 8 ms 击败 70.54%
    /// 内存 14.1 MB 击败 16.52%
    func merge(
        _ nums1: inout [Int],
        _ m: Int,
        _ nums2: [Int],
        _ n: Int
    ) {
        guard m > 0 else {
            nums1 = nums2
            return
        }
        
        guard n > 0 else {
            return
        }
        
        let len = m + n
        var index = 0, left = 0, right = 0, result = [Int]()
        
        while index < len {
            if left < m {
                if right < n {
                    if nums1[left] >= nums2[right] {
                        result.append(nums2[right])
                        right += 1
                    } else if nums1[left] == nums2[right] {
                        result.append(nums1[left])
                        result.append(nums2[right])
                        left += 1
                        right += 1
                    } else {
                        result.append(nums1[left])
                        left += 1
                    }
                } else {
                    result.append(nums1[left])
                    left += 1
                }
            } else if right < n {
                result.append(nums2[right])
                right += 1
            }
            index += 1
        }
        nums1 = result
    }
    
    /// 双指针官方版
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    /// 时间 8 ms 击败 70.54%
    /// 内存 13.9 MB 击败 60.61%
    func merge1(
        _ nums1: inout [Int],
        _ m: Int,
        _ nums2: [Int],
        _ n: Int
    ) {
        var i = 0, j = 0, result = [Int]()
        
        // 更容易理解
        while i < m || j < n {

            if i >= m {
                result.append(nums2[j])
                j += 1
            } else if j >= n {
                result.append(nums1[i])
                i += 1
            } else if nums1[i] > nums2[j] {
                result.append(nums2[j])
                j += 1
            } else {
                result.append(nums1[i])
                i += 1
            }

        }
        
//        // 更简洁
//        while j < n  {
//            if i < m && nums1[i] < nums2[j] {
//                result.append(nums1[i])
//                i += 1
//            } else {
//                result.append(nums2[j])
//                j += 1
//            }
//        }
        
        nums1 = result
    }
    
    /// 逆向双指针
    /// 时间复杂度：O(m+n)
    /// 空间复杂度：O(m+n)
    func merge2(
        _ nums1: inout [Int],
        _ m: Int,
        _ nums2: [Int],
        _ n: Int
    ) {
        var i = m - 1, j = n - 1
        
        // 更容易理解
        // 时间 4 ms 击败 99.55%
        // 内存 13.9 MB 击败 42.41%
        while i >= 0 || j >= 0 {
            if i < 0 {
                nums1[i + j + 1] = nums2[j]
                j -= 1
            } else if j < 0 {
                nums1[i + j + 1] = nums1[i]
                i -= 1
            } else if nums1[i] > nums2[j] {
                nums1[i + j + 1] = nums1[i]
                i -= 1
            } else {
                nums1[i + j + 1]  = nums2[j]
                j -= 1
            }
        }

//        // 更简洁
//        // 时间 4 ms 击败 99.55%
//        // 内存 13.9 MB 击败 55.80%
//        while j >= 0 {
//            if i >= 0 && nums1[i] > nums2[j] {
//                nums1[i + j + 1] = nums1[i]
//                i -= 1
//            } else {
//                nums1[i + j + 1] = nums2[j]
//                j -= 1
//            }
//        }
    }
}
