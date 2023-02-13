//
//  UIColor+Extensions.swift
//  Async Cat
//
//  Created by Алексей Титов on 10.09.2022.
//

import UIKit

@objc extension UIColor {
    
    // MARK: - Content
    
    /// `#2C2C2C`
    static let contentPrimary = UIColor(hexString: "#2C2C2C")
    /// `#6A6A6A`
    static let contentSecondary = UIColor(hexString: "#6A6A6A")
    /// `#9A9A9A`
    static let contentTertiary = UIColor(hexString: "#9A9A9A")
    /// `#9A9A9A`
    static let contentDisabled = UIColor(hexString: "#9A9A9A")
    
    /// `#FFFFFF` at 40%
    static let contentGhostDisabled = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.4)
    
    /// `#19AB4A`
    static let contentAction = UIColor(hexString: "#19AB4A")
    /// `#009B3A`
    static let contentActionHover = UIColor(hexString: "#009B3A")
    /// `#0B8030`
    static let contentActionPressed = UIColor(hexString: "#0B8030")
    /// `#06681E`
    static let contentActionDark = UIColor(hexString: "#06681E")
    /// `#FFFFFF`
    static let contentActionOn = UIColor(hexString: "#FFFFFF")
    
    /// `#EE3D32`
    static let contentError = UIColor(hexString: "#EE3D32")
    /// `#DE3531`
    static let contentErrorHover = UIColor(hexString: "#DE3531")
    /// `#CE2E30`
    static let contentErrorPressed = UIColor(hexString: "#CE2E30")
    /// `#BD272F`
    static let contentErrorDark = UIColor(hexString: "#BD272F")
    
    /// `#FB9100`
    static let contentWarning = UIColor(hexString: "#FB9100")
    /// `#F77D00`
    static let contentWarningHover = UIColor(hexString: "#F77D00")
    /// `#F36800`
    static let contentWarningPressed = UIColor(hexString: "#F36800")
    /// `#EF5600`
    static let contentWarningDark = UIColor(hexString: "#EF5600")
    
    /// `#82AF1A`
    static let contentSuccess = UIColor(hexString: "#82AF1A")
    /// `#3F6516`
    static let contentSuccessDark = UIColor(hexString: "#3F6516")
    
    /// `#2B82E9`
    static let contentInfo = UIColor(hexString: "#2B82E9")
    /// `#1951A8`
    static let contentInfoDark = UIColor(hexString: "#1951A8")
    
    /// `#FFFFFF`
    static let contentPrimaryInverse = UIColor(hexString: "#FFFFFF")
    
    // MARK: - Background
    
    /// `#FFFFFF`
    static let backgroundMain = UIColor(hexString: "#FFFFFF")
    /// `#F5F5F5`
    static let backgroundMainHover = UIColor(hexString: "#F5F5F5")
    /// `#E8E8E8`
    static let backgroundMainPressed = UIColor(hexString: "#E8E8E8")
    
    /// `#F5F5F5`
    static let backgroundPrimary = UIColor(hexString: "#F5F5F5")
    /// `#E8E8E8`
    static let backgroundPrimaryHover = UIColor(hexString: "#E8E8E8")
    /// `#DEDEDE`
    static let backgroundPrimaryPressed = UIColor(hexString: "#DEDEDE")
    
    /// `#E8E8E8`
    static let backgroundSecondary = UIColor(hexString: "#E8E8E8")
    /// `#DEDEDE`
    static let backgroundSecondaryHover = UIColor(hexString: "#DEDEDE")
    /// `#D0D0D0`
    static let backgroundSecondaryPressed = UIColor(hexString: "#D0D0D0")
    
    /// `#DEDEDE`
    static let backgroundTertiary = UIColor(hexString: "#DEDEDE")
    /// `#D0D0D0`
    static let backgroundTertiaryHover = UIColor(hexString: "#D0D0D0")
    /// `#B5B5B5`
    static let backgroundTertiaryPressed = UIColor(hexString: "#B5B5B5")
    /// `#E8E8E8`
    static let backgroundDisabled = UIColor(hexString: "#E8E8E8")
    
    /// `#22BE54`
    static let backgroundAction = UIColor(hexString: "#22BE54")
    /// `#009B3A`
    static let backgroundActionHover = UIColor(hexString: "#009B3A")
    /// `#0B8030`
    static let backgroundActionPressed = UIColor(hexString: "#0B8030")
    /// `#B1EDB8`
    static let backgroundActionActiveDisabled = UIColor(hexString: "#B1EDB8")
    
    /// `#DEF8E0`
    static let backgroundActionLight = UIColor(hexString: "#DEF8E0")
    /// `#C9F3CD`
    static let backgroundActionLightHover = UIColor(hexString: "#C9F3CD")
    /// `#B1EDB8`
    static let backgroundActionLightPressed = UIColor(hexString: "#B1EDB8")
    
    /// `#FF4733`
    static let backgroundError = UIColor(hexString: "#FF4733")
    /// `#DE3531`
    static let backgroundErrorHover = UIColor(hexString: "#DE3531")
    /// `#CE2E30`
    static let backgroundErrorPressed = UIColor(hexString: "#CE2E30")
    
    /// `#FFE5DD`
    static let backgroundErrorLight = UIColor(hexString: "#FFE5DD")
    /// `#FFD3C7`
    static let backgroundErrorLightHover = UIColor(hexString: "#FFD3C7")
    /// `#FFC1B0`
    static let backgroundErrorLightPressed = UIColor(hexString: "#FFC1B0")
    
    /// `#FFA700`
    static let backgroundWarning = UIColor(hexString: "#FFA700")
    /// `#F77D00`
    static let backgroundWarningHover = UIColor(hexString: "#F77D00")
    /// `#F36800`
    static let backgroundWarningPressed = UIColor(hexString: "#F36800")
    
    /// `#FFF5D9`
    static let backgroundWarningLight = UIColor(hexString: "#FFF5D9")
    /// `#FFECC0`
    static let backgroundWarningLightHover = UIColor(hexString: "#FFECC0")
    /// `#FFE2A8`
    static let backgroundWarningLightPressed = UIColor(hexString: "#FFE2A8")
    
    /// `#A0CC1B`
    static let backgroundSuccess = UIColor(hexString: "#A0CC1B")
    /// `#699519`
    static let backgroundSuccessHover = UIColor(hexString: "#699519")
    /// `#537C19`
    static let backgroundSuccessPressed = UIColor(hexString: "#537C19")
    
    /// `#E6FBD9`
    static let backgroundSuccessLight = UIColor(hexString: "#E6FBD9")
    /// `#DBF7C0`
    static let backgroundSuccessLightHover = UIColor(hexString: "#DBF7C0")
    /// `#D2F3A7`
    static let backgroundSuccessLightPressed = UIColor(hexString: "#D2F3A7")
    
    /// `#3396FF`
    static let backgroundInfo = UIColor(hexString: "#3396FF")
    /// `#2471D3`
    static let backgroundInfoHover = UIColor(hexString: "#2471D3")
    /// `#1E60BE`
    static let backgroundInfoPressed = UIColor(hexString: "#1E60BE")
    
    /// `#E1F2FF`
    static let backgroundInfoLight = UIColor(hexString: "#E1F2FF")
    /// `#CDEAFF`
    static let backgroundInfoLightHover = UIColor(hexString: "#CDEAFF")
    /// `#B8E0FF`
    static let backgroundInfoLightPressed = UIColor(hexString: "#B8E0FF")
    
    /// `#171917`
    static let backgroundMainInverse = UIColor(hexString: "#171917")
    
    /// `#000000` at 50%
    static let backgroundOverlay = UIColor(hexString: "#000000").withAlphaComponent(0.5)
    
    /// `#FFFFFF` at 10%
    static let backgroundGhost = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.1)
    /// `#FFFFFF` at 20%
    static let backgroundGhostLight = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.2)
    /// `#FFFFFF` at 30%
    static let backgroundGhostLightHover = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
    /// `#FFFFFF` at 40%
    static let backgroundGhostLightPressed = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.4)
    
    // MARK: - Border
    
    /// `#D0D0D0`
    static let borderMain = UIColor(hexString: "#D0D0D0")
    /// `#B5B5B5`
    static let borderMainHover = UIColor(hexString: "#B5B5B5")
    /// `#9B9B9B`
    static let borderMainPressed = UIColor(hexString: "#9B9B9B")
    
    /// `#E8E8E8`
    static let borderSecondary = UIColor(hexString: "#E8E8E8")
    /// `#D0D0D0`
    static let borderSecondaryHover = UIColor(hexString: "#D0D0D0")
    /// `#B5B5B5`
    static let borderSecondaryPressed = UIColor(hexString: "#B5B5B5")
    
    /// `#D0D0D0`
    static let borderDisabled = UIColor(hexString: "#D0D0D0")
    
    /// `#FFFFFF` at 40%
    static let borderGhostDisabled = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.4)
    
    /// `#82DF94`
    static let borderFocused = UIColor(hexString: "#82DF94")
    
    /// `#19AB4A`
    static let borderAction = UIColor(hexString: "#19AB4A")
    /// `#009B3A`
    static let borderActionHover = UIColor(hexString: "#009B3A")
    /// `#06681E`
    static let borderActionPressed = UIColor(hexString: "#06681E")
    
    /// `#EE3D32`
    static let borderError = UIColor(hexString: "#EE3D32")
    /// `#FB9100`
    static let borderWarning = UIColor(hexString: "#FB9100")
    /// `#82AF1A`
    static let borderSuccess = UIColor(hexString: "#82AF1A")
    /// `#2B82E9`
    static let borderInfo = UIColor(hexString: "#2B82E9")
    
    /// `#FFFFFF`
    static let borderMainOn = UIColor(hexString: "#FFFFFF")
}

extension UIColor {
    
    public convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
