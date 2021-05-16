import MobileCoreServices
import LinkPresentation

func mimeTypeForPath(url: URL) -> String {
  let pathExtension = url.pathExtension

  if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
    if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
      return mimetype as String
    }
  }
  return "application/octet-stream"
}


@available(iOS 11.0, *)
private func getImageURL(itemProvider: NSItemProvider?, callback: @escaping (String?) -> Void) {
  guard let itemProvider = itemProvider else {
    callback(nil)
    return
  }

  let type = String(kUTTypeImage)
  guard itemProvider.hasItemConformingToTypeIdentifier(type) else {
    callback(nil)
    return
  }

  itemProvider.loadFileRepresentation(forTypeIdentifier: type) { url, error in
    guard let url = url, error == nil else {
      callback(nil)
      return
    }

    do {
      let data = try Data(contentsOf: url).base64EncodedString()
      let mimeType = mimeTypeForPath(url: url)
      let dataUrl = "data:\(mimeType);base64,\(data)"

      callback(dataUrl)
    } catch {
      callback(nil)
    }
  }
}

@available(iOS 13.0, *)
@objc(LinkMetadataModule)
class LinkMetadataModule: NSObject {

  @objc
  func constantsToExport() -> [AnyHashable : Any]! {
    return ["LPLinkMetadata": NSClassFromString("LPLinkMetadata") != nil]
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc(fetchURLPreview:resolver:rejecter:)
  public func fetchURLPreview(_ urlString: NSString,
                              resolver resolve: @escaping RCTPromiseResolveBlock,
                              rejecter reject: @escaping RCTPromiseRejectBlock) {
    let url = URL(string: urlString as String)

    guard let url = url else {
      reject(
        "LinkMetadataModule",
        "string passed in is not a valid URL",
        NSError(domain: "LinkMetadataModule", code: 1, userInfo: nil)
      )
      return
    }

    let metadataProvider = LPMetadataProvider()

    DispatchQueue.main.async {
      metadataProvider.startFetchingMetadata(for: url) { metadata, error in
        DispatchQueue.global().async {
          guard let data = metadata, error == nil else {
            reject("LinkMetadataModule", "couldn't fetch metadata", error)
            return
          }

          getImageURL(itemProvider: data.imageProvider) { imageURL in
            getImageURL(itemProvider: data.imageProvider) { iconURL in
              let response = [
                "url": data.url?.absoluteString,
                "originalUrl": data.originalURL?.absoluteString,
                "title": data.title,
                "imageURL": imageURL,
                "iconURL": iconURL
              ]

              resolve(response)
            }
          }
        }
      }
    }
  }
}
