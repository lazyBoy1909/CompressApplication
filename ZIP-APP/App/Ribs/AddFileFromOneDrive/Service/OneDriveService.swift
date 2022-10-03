//
//  OneDriveService.swift
//  Zip
//
//

import Foundation

import RxSwift
import TLLogging

class OneDriveService {
    static var shared = OneDriveService()
    var downloadFolderURL: URL = FileManager.myFileURL()

    private var disposeBag = DisposeBag()
    private var startDownloadingSubject = PublishSubject<Event<CloudItem>>()
    private var endDownloadingSubject = PublishSubject<Event<CloudItem>>()

    private var info: OneDriveServiceInfo {
        return OneDriveServiceInfo.current
    }
}

extension OneDriveService: CloudService {
    var startDownloadingObserver: Observable<Event<CloudItem>> {
        return self.startDownloadingSubject.asObserver()
    }

    var endDownloadingObserver: Observable<Event<CloudItem>> {
        return self.endDownloadingSubject.asObserver()
    }

    func isDownloading(id: String) -> Bool {
        return self.info.isDownloading(itemId: id)
    }

    func folderName(id: String) -> String? {
        return self.info.name(id: id)
    }

    func fetch(item: CloudItem, completion: @escaping ([CloudItem]?, Error?) -> Void) {
        OneDriveFetchAPI(itemId: item.identifier()).execute().subscribe { items in
            completion(items, nil)
        } onError: { error in
            completion(nil, error)
        }.disposed(by: self.disposeBag)
    }

    func download(item: CloudItem) {
        guard let item = item as? OneDriveItem,
              let downloadURL = item.downloadURL(),
              let fileExtension = item.fileExtension() else {
            return
        }

        let filename = item.name().hasSuffix(fileExtension) ? "\(item.name().dropLast(fileExtension.count + 1))" : item.name()
        let destinationURL = FileManager.getValidURL(withName: filename, folderURL: self.downloadFolderURL, pathExt: fileExtension)

        self.info.markDownloading(itemId: item.identifier())
        self.startDownloadingSubject.onNext(.next(item))

        getNetworkClient().download(url: downloadURL, to: destinationURL).subscribe { _ in
            self.info.unmarkDownloading(itemId: item.identifier())
            self.endDownloadingSubject.onNext(.next(item))
        } onError: { error in
            TLLogging.log("Download file from one drive error: \(error)")
            self.info.unmarkDownloading(itemId: item.identifier())
            self.endDownloadingSubject.onNext(.error(error))
        }.disposed(by: self.disposeBag)
    }
}
