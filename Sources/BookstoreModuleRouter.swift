//
//  BookstoreModuleRouter.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import IBACore
import IBACoreUI

public enum BookstoreModuleRoute: Route {
    case root
}

public class BookstoreModuleRouter: BaseRouter<BookstoreModuleRoute> {
    var module: BookstoreModule?
    init(with module: BookstoreModule) {
        self.module = module
    }

    public override func generateRootViewController() -> BaseViewControllerType {
        return MainViewController(type: module?.config?.type, data: module?.data)
    }

    public override func prepareTransition(for route: BookstoreModuleRoute) -> RouteTransition {
        return RouteTransition(module: generateRootViewController(), isAnimated: true)
    }

    public override func rootTransition() -> RouteTransition {
        return self.prepareTransition(for: .root)
    }
}
