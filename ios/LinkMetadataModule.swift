//
//  LinkMetadataModule.swift
//  LinkMetadataModule
//
//  Copyright © 2021 Max von Webel. All rights reserved.
//

import Foundation

@objc(LinkMetadataModule)
class LinkMetadataModule: NSObject {
  @objc
  func constantsToExport() -> [AnyHashable : Any]! {
    return ["count": 1]
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
