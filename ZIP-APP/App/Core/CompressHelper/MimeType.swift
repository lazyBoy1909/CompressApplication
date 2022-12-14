//
//  MimeType.swift
//  Zip
//
//

import Foundation
private let pathExt = [
    "text/html": "html",
    "text/css": "css",
    "text/xml": "xml",
    "image/gif": "gif",
    "image/jpeg": "jpg",
    "application/javascript": "js",
    "application/atom+xml": "atom",
    "application/rss+xml": "rss",
    "text/mathml": "mml",
    "text/plain": "txt",
    "text/vnd.sun.j2me.app-descriptor": "jad",
    "text/vnd.wap.wml": "wml",
    "text/x-component": "htc",
    "image/png": "png",
    "image/tiff": "tif",
    "image/vnd.wap.wbmp": "wbmp",
    "image/x-icon": "ico",
    "image/x-jng": "jng",
    "image/x-ms-bmp": "bmp",
    "image/svg+xml": "svg",
    "image/webp": "webp",
    "application/font-woff": "woff",
    "application/java-archive": "jar",
    "application/json": "json",
    "application/mac-binhex40": "hqx",
    "application/msword": "doc",
    "application/pdf": "pdf",
    "application/postscript": "ps",
    "application/rtf": "rtf",
    "application/vnd.apple.mpegurl": "m3u8",
    "application/vnd.ms-excel": "xls",
    "application/vnd.ms-fontobject": "eot",
    "application/vnd.ms-powerpoint": "ppt",
    "application/vnd.wap.wmlc": "wmlc",
    "application/vnd.google-earth.kml+xml": "kml",
    "application/vnd.google-earth.kmz": "kmz",
    "application/x-7z-compressed": "7z",
    "application/x-cocoa": "cco",
    "application/x-pilot": "pdb",
    "application/x-rar-compressed": "rar",
    "application/xhtml+xml": "xhtml",
    "application/zip": "zip",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document": "docx",
    "application/vnd.google-apps.document": "docx",
    "application/vnd.google-apps.presentation": "pptx",
    "application/vnd.google-apps.spreadsheet": "xlsx",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": "xlsx",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation": "pptx",
    "audio/midi": "midi",
    "audio/mpeg": "mp3",
    "audio/ogg": "ogg",
    "audio/x-m4a": "m4a",
    "audio/x-realaudio": "ra",
    "video/3gpp": "3gp",
    "video/mp2t": "ts",
    "video/mp4": "mp4",
    "video/mpeg": "mpg",
    "video/quicktime": "mov",
    "video/webm": "webm",
    "video/x-flv": "flv",
    "video/x-m4v": "m4v",
    "video/x-mng": "mng",
    "video/x-ms-asf": "asf",
    "video/x-ms-wmv": "wmv",
    "video/x-msvideo": "avi",
    "application/vnd.google-apps.folder": ""
]

private let exportBridgeMimeTypes = [
    "application/vnd.google-apps.document": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/vnd.google-apps.presentation": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "application/vnd.google-apps.spreadsheet": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
]

struct MimeType {

    private var rawValue: String
    init(_ value: String) {
        self.rawValue = value.lowercased()
    }

    func pathExtension() -> String? {
        return pathExt[self.rawValue]
    }

    func needExport() -> Bool {
        return exportBridgeMimeTypes[self.rawValue] != nil
    }

    func exportedMimeType() -> String {
        return exportBridgeMimeTypes[self.rawValue] ?? self.rawValue
    }
}
