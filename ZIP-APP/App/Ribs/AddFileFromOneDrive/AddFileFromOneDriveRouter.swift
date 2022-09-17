//
//  AddFileFromOneDriveRouter.swift
//  Zip
//
//

import RIBs

protocol AddFileFromOneDriveInteractable: Interactable, OpenCloudListener {
    var router: AddFileFromOneDriveRouting? { get set }
    var listener: AddFileFromOneDriveListener? { get set }
}

protocol AddFileFromOneDriveViewControllable: ViewControllable {
}

final class AddFileFromOneDriveRouter: Router<AddFileFromOneDriveInteractable> {
    var viewController: AddFileFromOneDriveViewControllable

    var openCloudBuilder: OpenCloudBuildable
    var openCloudRouter: OpenCloudRouting?

    init(interactor: AddFileFromOneDriveInteractable,
         viewController: AddFileFromOneDriveViewControllable,
         openCloudBuilder: OpenCloudBuildable) {
        self.viewController = viewController
        self.openCloudBuilder = openCloudBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
}

// MARK: - AddFileFromOneDriveRouting
extension AddFileFromOneDriveRouter: AddFileFromOneDriveRouting {
    func routeToOpenCloud(cloudItem: CloudItem, parentId: String?) {
        let router = self.openCloudBuilder.build(withListener: self.interactor, cloudItem: cloudItem, parentId: parentId, cloudService: OneDriveService.shared)
        self.viewController.push(viewControllable: router.viewControllable)
        attachChild(router)
        self.openCloudRouter = router
    }

    func dismissOpenCloud() {
        guard let router = self.openCloudRouter else {
            return
        }

        self.viewController.popToBefore(viewControllable: router.viewControllable)
        detachChild(router)
        self.openCloudRouter = nil
    }
}
