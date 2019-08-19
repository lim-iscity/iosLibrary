//
//  AlamofireViewController.swift
//  AlamofireDemo
//
//  Created by Lim Thean Khoon on 19/08/2019.
//  Copyright © 2019 Lim Thean Khoon. All rights reserved.
//

import UIKit

public class AlamofireViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        if let controller = UIStoryboard(name: "AlamofireMain", bundle: Bundle(for: SearchViewController.self)).instantiateInitialViewController() {
            addChild(controller)
            view.addSubview(controller.view)
        }
    }
}

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

class DefinitionSegueContext {
    let definition: Definition
    
    init(definition: Definition) {
        self.definition = definition
    }
}
