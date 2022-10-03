//
//  AddFileFromOneDriveInteractor+OpenCloud.swift
//  Zip
//
//

import Foundation

extension AddFileFromOneDriveInteractor: OpenCloudListener {
    func openCloudWantToDismiss() {
        self.router?.dismissOpenCloud()
        listener?.addFileFromOneDriveWantToDismiss()
    }

    func openCloudWantToLogout() {
        OneDriveServiceInfo.current.logout()
        self.router?.dismissOpenCloud()
        listener?.addFileFromOneDriveWantToDismiss()
    }

    func openCloudDidDownloadSuccessfully() {
        listener?.addFileFromOneDriveDidDownloadSucessfully()
    }
}
