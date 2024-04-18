//
//  MainCellModel.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 28.07.2023.
//

import Foundation
import UIKit

struct MainCellModel {
    var title: NSAttributedString
    public var backgroundColor: UIColor
    public let action: () -> Void
}
