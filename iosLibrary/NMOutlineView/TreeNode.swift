//
//  TreeNode.swift
//  SwiftPlayground
//
//  Created by Lim Thean Khoon on 13/08/2019.
//  Copyright © 2019 jeff. All rights reserved.
//

import Foundation

class TreeNode<T> {
    var value: T
    
    weak var parent: TreeNode<T>?
    var children = [TreeNode<T>]()
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(_ node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
    
    
    func nodeAtIndexPath(_ indexPath: IndexPath) -> TreeNode<T>? {
        if indexPath.count == 1 {
            return self
        } else {
            let nextPath = indexPath.dropFirst()
            let childNode = self.children[nextPath.first!]
            return childNode.nodeAtIndexPath(nextPath)
        }
    }
    
    // Counts children recursively
    func childCount() -> Int {
        if self.children.count > 0 {
            var count = 0
            for child in self.children {
                count += child.childCount()
            }
            return count
            
        } else {
            return 1
        }
    }
    
}
