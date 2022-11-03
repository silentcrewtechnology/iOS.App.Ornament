//
//  UIImage+Extension.swift
//  AbbDesign
//
//
//  Created by Алексей Титов on 10.09.2022.
//

import UIKit

extension UIImage {
    
    @objc convenience init?(
        color: UIColor,
        size: CGSize = .init(width: 1, height: 1)
    ) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
