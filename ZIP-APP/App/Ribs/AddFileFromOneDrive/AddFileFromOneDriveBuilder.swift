//
//  AddFileFromOneDriveBuilder.swift
//  Zip
//
//

import RIBs

protocol AddFileFromOneDriveDependency: Dependency {
    var addFileFromOneDriveViewController: AddFileFromOneDriveViewControllable { get }
}

final class AddFileFromOneDriveComponent: Component<AddFileFromOneDriveDependency> {
    fileprivate var addFileFromOneDriveViewController: AddFileFromOneDriveViewControllable {
        return dependency.addFileFromOneDriveViewController
    }
}

// MARK: - Builder

protocol AddFileFromOneDriveBuildable: Buildable {
    func build(withListener listener: AddFileFromOneDriveListener, downloadFolderURL: URL) -> AddFileFromOneDriveRouting
}

final class AddFileFromOneDriveBuilder: Builder<AddFileFromOneDriveDependency>, AddFileFromOneDriveBuildable {

    override init(dependency: AddFileFromOneDriveDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddFileFromOneDriveListener, downloadFolderURL: URL) -> AddFileFromOneDriveRouting {
        let component = AddFileFromOneDriveComponent(dependency: dependency)
        let interactor = AddFileFromOneDriveInteractor(downloadFolderURL: downloadFolderURL)
        interactor.listener = listener

        let openCloudBuilder = DIContainer.resolve(OpenCloudBuildable.self, agrument: component)

        return AddFileFromOneDriveRouter(interactor: interactor,
                                         viewController: component.addFileFromOneDriveViewController,
                                         openCloudBuilder: openCloudBuilder)
    }
}
