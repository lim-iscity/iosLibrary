import UIKit

public struct DealsViewControllerFactory: DealsViewControllerCreating {

    var cardViewControllerFactory: ProductCardViewControllerCreating = ProductCardViewControllerFactory()
    
    public init() {}

    public func create(with produtcs: [Product]) -> UIViewController {
        return DealsViewController(
            cardViewControllers: produtcs.map { cardViewControllerFactory.create(with: $0) }
        )
    }

}
