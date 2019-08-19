//
//  EcommerceViewController.swift
//  iosLibrary
//
//  Created by Lim Thean Khoon on 16/08/2019.
//  Copyright © 2019 Lim Thean Khoon. All rights reserved.
//

import UIKit
import EcommerceDemo

class EcommerceViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerFonts(from: EcommerceDemo.bundle)
        let viewControllerFactory: DealsViewControllerCreating = DealsViewControllerFactory()
        let demoController = viewControllerFactory.create(with: Product.demos)
        addChild(demoController)
        self.view.addSubview(demoController.view)
        demoController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            demoController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            demoController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            demoController.view.topAnchor.constraint(equalTo: view.topAnchor),
            demoController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func registerFonts(from bundle: Bundle) {
        let fontUrls = bundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil)!
        fontUrls.forEach { url in
            let fontDataProvider = CGDataProvider(url: url as CFURL)!
            let font = CGFont(fontDataProvider)!
            var error: Unmanaged<CFError>?
            guard CTFontManagerRegisterGraphicsFont(font, &error) else {
                print("Could not register font from url \(url), error: \(error!.takeUnretainedValue())")
                return
            }
        }
    }
}


