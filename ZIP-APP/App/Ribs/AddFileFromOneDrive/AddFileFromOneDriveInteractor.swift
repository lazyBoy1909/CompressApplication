//
//  AddFileFromOneDriveInteractor.swift
//  Zip
//
//

import MSAL
import RIBs
import RxSwift
import TLLogging

private struct Const {
    static let clientId = "e1ac5bd5-2fdf-4130-a233-62d46926cff5"
    static let scopes = ["https://graph.microsoft.com/user.read",
                         "https://graph.microsoft.com/files.read.all"]
}

protocol AddFileFromOneDriveRouting: Routing {
    var viewController: AddFileFromOneDriveViewControllable { get }
    func routeToOpenCloud(cloudItem: CloudItem, parentId: String?)
    func dismissOpenCloud()
}

protocol AddFileFromOneDriveListener: AnyObject {
    func addFileFromOneDriveWantToDismiss()
    func addFileFromOneDriveDidDownloadSucessfully()
}

final class AddFileFromOneDriveInteractor: Interactor, AddFileFromOneDriveInteractable {

    weak var router: AddFileFromOneDriveRouting?
    weak var listener: AddFileFromOneDriveListener?

    init(downloadFolderURL: URL) {
        OneDriveService.shared.downloadFolderURL = downloadFolderURL
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        self.loginOneDrive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    // MARK: - Helper
    private func loginOneDrive() {
        let config = MSALPublicClientApplicationConfig(clientId: Const.clientId)

        guard let application = try? MSALPublicClientApplication(configuration: config) else {
            listener?.addFileFromOneDriveWantToDismiss()
            return
        }

        let acquireTokenBlock = {
            guard let topViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.topViewController() else {
                return
            }

            let webviewParameters = MSALWebviewParameters(authPresentationViewController: topViewController)
            let interactiveParameters = MSALInteractiveTokenParameters(scopes: Const.scopes, webviewParameters: webviewParameters)
            application.acquireToken(with: interactiveParameters) { result, error in
                guard let result = result else {
                    TLLogging.log("acquire token MSAL error: \(error!)")
                    self.listener?.addFileFromOneDriveWantToDismiss()
                    return
                }

                OneDriveServiceInfo.current.accessToken = result.accessToken
                OneDriveServiceInfo.current.accountIdentifier = result.account.identifier
                TLLogging.log(result.accessToken)
                self.router?.routeToOpenCloud(cloudItem: OneDriveItem(), parentId: nil)
            }
        }

        guard let accountIdentifier = OneDriveServiceInfo.current.accountIdentifier,
              let account = try? application.account(forIdentifier: accountIdentifier) else {
            acquireTokenBlock()
            return
        }

        let silentParameters = MSALSilentTokenParameters(scopes: Const.scopes, account: account)
        application.acquireTokenSilent(with: silentParameters) { result, error in
            guard let result = result, error == nil else {
                let nsError = error! as NSError
                if nsError.domain == MSALErrorDomain,
                   nsError.code == MSALError.interactionRequired.rawValue {
                    acquireTokenBlock()
                }

                return
            }

            OneDriveServiceInfo.current.accessToken = result.accessToken
            DispatchQueue.main.async {
                self.router?.routeToOpenCloud(cloudItem: OneDriveItem(), parentId: nil)
            }
        }
    }
}
