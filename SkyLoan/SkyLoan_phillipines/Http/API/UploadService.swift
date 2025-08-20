//
//  UploadService.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/24.
//

import Foundation
import Moya

enum UploadService {
    case uploadProfile(image: Data, meta: [String: Any])
}

extension UploadService: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        switch self {
        case .uploadProfile:
            return "/bluesky/blowpipeit"
        }
    }
    
    var method: Moya.Method{
        .post
    }
    
    var task: Task{
        switch self {
        case .uploadProfile(let image, let meta):
            var formData = [MultipartFormData]()
            formData.append(.init(provider: .data(image), name: "disguise",fileName: "disguise-\(randomUUIDString()).jpg",mimeType: "image/jpeg"))
            for (key,vaue) in meta {
                formData.append(.init(provider: .data("\(vaue)".data(using: .utf8)!), name: "\(key)"))
            }
            return .uploadCompositeMultipart(formData, urlParameters: PublicParamas())
        }
    }
    
    var headers: [String : String]?{
        return ["Content-Type":"multipart/form-data"]
    }
}
