//
//  MIMEType.swift
//  EmailAttachment
//
//  Created by Mohamed Adel on 7/11/20.
//  Copyright © 2020 Mohamed Adel. All rights reserved.
//

import Foundation
enum MIMEType: String {
    case jpg = "image/jpeg"
    case png = "image/png"
    case doc = "application/msword"
    case ppt = "application/vnd.ms-powerpoint"
    case html = "text/html"
    case pdf = "application/pdf"
    init?(type: String) {
        switch type.lowercased() {
        case "jpg": self = .jpg
        case "png": self = .png
        case "doc": self = .doc
        case "ppt": self = .ppt
        case "html": self = .html
        case "pdf": self = .pdf
        default: return nil
        }
    }
}
