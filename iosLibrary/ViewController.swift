//
//  ViewController.swift
//  iosLibrary
//
//  Created by Lim Thean Khoon on 16/08/2019.
//  Copyright © 2019 Lim Thean Khoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var datasource: [TreeNode<[String: Any]>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }

    private func setupData() {
        datasource = []
    }

    private func setupView() {
        view.backgroundColor = .white
        let outlineView = NMOutlineView()
        outlineView.datasource = self
        outlineView.tableView.separatorStyle = .singleLine
        view.addSubview(outlineView)
        outlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outlineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outlineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outlineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outlineView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension ViewController: NMOutlineViewDatasource {
    func outlineView(_ outlineView: NMOutlineView, numberOfChildrenOfCell parentCell: NMOutlineViewCell?) -> Int {
        guard let datasource = datasource else { return 0 }
        if let parentNode = parentCell?.value as? TreeNode<[String: Any]> {
            return parentNode.children.count
        } else {
            return datasource.count
        }
    }
    
    func outlineView(_ outlineView: NMOutlineView, isCellExpandable cell: NMOutlineViewCell) -> Bool {
        guard let node = cell.value as? TreeNode<[String: Any]> else { return false }
        if node.children.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func outlineView(_ outlineView: NMOutlineView, childCell index: Int, ofParentAtIndexPath parentIndexPath: IndexPath?) -> NMOutlineViewCell {
        guard let datasource = datasource else { return NMOutlineViewCell() }
        if let parentIndexPath = parentIndexPath, let rootIndex = parentIndexPath.first {
            let rootNode = datasource[rootIndex]
            if let node = rootNode.nodeAtIndexPath(parentIndexPath) {
                let childNode = node.children[index]
                
                if childNode.children.count > 0 {
                    let cell = outlineView.dequeReusableCell(withIdentifier: "defaultCell", style: .default)
                    if let name = childNode.value["name"] as? String {
                        cell.textLabel?.text = "\(name) [\(childNode.childCount())]"
                    }
                    cell.value = childNode
                    return cell
                } else {
                    let cell = outlineView.dequeReusableCell(withIdentifier: "subtitleCell", style: .subtitle)
                    if let name = childNode.value["name"] as? String {
                        cell.textLabel?.text = name
                    }
                    cell.value = childNode
                    return cell
                }
            } else {
                return NMOutlineViewCell()
            }
        } else {
            // Root level
            let cell = outlineView.dequeReusableCell(withIdentifier: "defaultCell", style: .default)
            cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
            let node = datasource[index]
            if let name = node.value["name"] as? String {
                cell.textLabel?.text = "\(name) [\(node.childCount())]"
            }
            cell.value = node
            return cell
        }
    }
    
    func outlineView(_ outlineView: NMOutlineView, didSelectCell cell: NMOutlineViewCell) {
        guard let node = cell.value as? TreeNode<[String: Any]> else { return }
        let nodeValue = node.value
        if node.childCount() > 0 {
            cell.onToggle?(cell)
            cell.updateState(!cell.isExpanded, animated: true)
        }
        if let controller = nodeValue["controller"] as? UIViewController.Type {
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(controller.init(), animated: true)
        }
    }
    
    
}
