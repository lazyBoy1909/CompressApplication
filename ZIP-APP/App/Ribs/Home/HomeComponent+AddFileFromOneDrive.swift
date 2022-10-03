//
//  HomeComponent+AddFileFromOneDrive.swift
//  Zip
//
//

import Foundation

extension HomeComponent: AddFileFromOneDriveDependency {
    var addFileFromOneDriveViewController: AddFileFromOneDriveViewControllable {
        return self.viewController
    }
}
