//
//  HomeInteractor+AddFileFromOneDrive.swift
//  Zip
//
//

import Foundation

extension HomeInteractor: AddFileFromOneDriveListener {
    func addFileFromOneDriveWantToDismiss() {
        self.router?.dismissAddFileFromOneDrive()
    }

    func addFileFromOneDriveDidDownloadSucessfully() {
        self.router?.resetMyFileScreen(highlightedItemURL: nil)
    }
}
