//
//  UIColor+Extensions.swift
//  Async Cat
//
//  Created by Алексей Титов on 10.09.2022.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
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
    
    // MARK: - Amber
    
    static public let amber50 = UIColor(hexString: "#FFFCF3")
    static public let amber100 = UIColor(hexString: "#FFF5D9")
    static public let amber150 = UIColor(hexString: "#FFECC0")
    static public let amber200 = UIColor(hexString: "#FFE2A8")
    static public let amber300 = UIColor(hexString: "#FFC976")
    static public let amber400 = UIColor(hexString: "#FFA847")
    static public let amber500 = UIColor(hexString: "#FF8119")
    static public let amber600 = UIColor(hexString: "#F46C1B")
    static public let amber700 = UIColor(hexString: "#EA501F")
    static public let amber800 = UIColor(hexString: "#E64920")
    static public let amber850 = UIColor(hexString: "#E24020")
    static public let amber900 = UIColor(hexString: "#DE3821")
    static public let amber950 = UIColor(hexString: "#DA3022")
    
    // MARK: - Blue
    
    static public let blue50 = UIColor(hexString: "#F6FBFF")
    static public let blue100 = UIColor(hexString: "#E1F2FF")
    static public let blue150 = UIColor(hexString: "#CDEAFF")
    static public let blue200 = UIColor(hexString: "#B8E0FF")
    static public let blue300 = UIColor(hexString: "#8CC9FF")
    static public let blue400 = UIColor(hexString: "#60B1FF")
    static public let blue500 = UIColor(hexString: "#3396FF")
    static public let blue600 = UIColor(hexString: "#2B82E9")
    static public let blue700 = UIColor(hexString: "#2471D3")
    static public let blue800 = UIColor(hexString: "#1E60BE")
    static public let blue850 = UIColor(hexString: "#1B58B3")
    static public let blue900 = UIColor(hexString: "#1951A8")
    static public let blue950 = UIColor(hexString: "#16499D")
    
    // MARK: - Deep Purple
    
    static public let deepPurple50 = UIColor(hexString: "#F9F6FF")
    static public let deepPurple100 = UIColor(hexString: "#ECDFFF")
    static public let deepPurple150 = UIColor(hexString: "#E0CAFF")
    static public let deepPurple200 = UIColor(hexString: "#D3B4FF")
    static public let deepPurple300 = UIColor(hexString: "#BA89FF")
    static public let deepPurple400 = UIColor(hexString: "#A15EFF")
    static public let deepPurple500 = UIColor(hexString: "#8833FF")
    static public let deepPurple600 = UIColor(hexString: "#7A2EE6")
    static public let deepPurple700 = UIColor(hexString: "#6D29CE")
    static public let deepPurple800 = UIColor(hexString: "#6024B5")
    static public let deepPurple850 = UIColor(hexString: "#5A21A9")
    static public let deepPurple900 = UIColor(hexString: "#531F9D")
    static public let deepPurple950 = UIColor(hexString: "#4C1C90")
    
    // MARK: - Grass
    
    static public let grass50 = UIColor(hexString: "#F5FDF5")
    static public let grass100 = UIColor(hexString: "#DEF8E0")
    static public let grass150 = UIColor(hexString: "#C9F3CD")
    static public let grass200 = UIColor(hexString: "#B1EDB8")
    static public let grass300 = UIColor(hexString: "#82DF94")
    static public let grass400 = UIColor(hexString: "#52CF72")
    static public let grass500 = UIColor(hexString: "#22BE54")
    static public let grass600 = UIColor(hexString: "#19AB4A")
    static public let grass700 = UIColor(hexString: "#009B3A")
    static public let grass800 = UIColor(hexString: "#0B8030")
    static public let grass850 = UIColor(hexString: "#087528")
    static public let grass900 = UIColor(hexString: "#06681E")
    static public let grass950 = UIColor(hexString: "#036218")
    
    // MARK: - Gray
    
    static public let gray50 = UIColor(hexString: "#F5F5F5")
    static public let gray100 = UIColor(hexString: "#E8E8E8")
    static public let gray150 = UIColor(hexString: "#DBDBDB")
    static public let gray200 = UIColor(hexString: "#CECECE")
    static public let gray300 = UIColor(hexString: "#B4B4B4")
    static public let gray400 = UIColor(hexString: "#9A9A9A")
    static public let gray500 = UIColor(hexString: "#808080")
    static public let gray600 = UIColor(hexString: "#6A6A6A")
    static public let gray700 = UIColor(hexString: "#555555")
    static public let gray800 = UIColor(hexString: "#414141")
    static public let gray850 = UIColor(hexString: "#363636")
    static public let gray900 = UIColor(hexString: "#2C2C2C")
    static public let gray950 = UIColor(hexString: "#212121")
    
    // MARK: Indigo
    
    static public let indigo50 = UIColor(hexString: "#F8F9FF")
    static public let indigo100 = UIColor(hexString: "#E8ECFF")
    static public let indigo150 = UIColor(hexString: "#D7DEFF")
    static public let indigo200 = UIColor(hexString: "#C7D1FF")
    static public let indigo300 = UIColor(hexString: "#A6B4FF")
    static public let indigo400 = UIColor(hexString: "#8496FF")
    static public let indigo500 = UIColor(hexString: "#6179FF")
    static public let indigo600 = UIColor(hexString: "#556BE6")
    static public let indigo700 = UIColor(hexString: "#4B5DCE")
    static public let indigo800 = UIColor(hexString: "#3F50B5")
    static public let indigo850 = UIColor(hexString: "#3B4AA9")
    static public let indigo900 = UIColor(hexString: "#36449D")
    static public let indigo950 = UIColor(hexString: "#313D90")
    
    // MARK: Light Green
    
    static public let lightGreen50 = UIColor(hexString: "#FDFDF3")
    static public let lightGreen100 = UIColor(hexString: "#F7FBD9")
    static public let lightGreen150 = UIColor(hexString: "#F1F7C0")
    static public let lightGreen200 = UIColor(hexString: "#E9F3A7")
    static public let lightGreen300 = UIColor(hexString: "#D6E977")
    static public let lightGreen400 = UIColor(hexString: "#BDDB48")
    static public let lightGreen500 = UIColor(hexString: "#A0CC1B")
    static public let lightGreen600 = UIColor(hexString: "#82AF1A")
    static public let lightGreen700 = UIColor(hexString: "#699519")
    static public let lightGreen800 = UIColor(hexString: "#537C19")
    static public let lightGreen850 = UIColor(hexString: "#487018")
    static public let lightGreen900 = UIColor(hexString: "#3F6516")
    static public let lightGreen950 = UIColor(hexString: "#365A15")
    
    // MARK: Light Blue
    
    static public let lightBlue50 = UIColor(hexString: "#F6FEFF")
    static public let lightBlue100 = UIColor(hexString: "#E0FBFF")
    static public let lightBlue150 = UIColor(hexString: "#CAF7FF")
    static public let lightBlue200 = UIColor(hexString: "#B3F1FF")
    static public let lightBlue300 = UIColor(hexString: "#85E2FF")
    static public let lightBlue400 = UIColor(hexString: "#53CEFF")
    static public let lightBlue500 = UIColor(hexString: "#21B5FF")
    static public let lightBlue600 = UIColor(hexString: "#1899E9")
    static public let lightBlue700 = UIColor(hexString: "#1281D3")
    static public let lightBlue800 = UIColor(hexString: "#0B6ABE")
    static public let lightBlue850 = UIColor(hexString: "#095FB3")
    static public let lightBlue900 = UIColor(hexString: "#0656A8")
    static public let lightBlue950 = UIColor(hexString: "#044C9D")
    
    // MARK: Mint
    
    static public let mint50 = UIColor(hexString: "#F5FCFA")
    static public let mint100 = UIColor(hexString: "#DBF6EF")
    static public let mint150 = UIColor(hexString: "#C4F0E5")
    static public let mint200 = UIColor(hexString: "#ABEADA")
    static public let mint300 = UIColor(hexString: "#7ADEC4")
    static public let mint400 = UIColor(hexString: "#4AD2AF")
    static public let mint500 = UIColor(hexString: "#1AC79A")
    static public let mint600 = UIColor(hexString: "#17AE87")
    static public let mint700 = UIColor(hexString: "#139573")
    static public let mint800 = UIColor(hexString: "#107C60")
    static public let mint850 = UIColor(hexString: "#0E7056")
    static public let mint900 = UIColor(hexString: "#0D644D")
    static public let mint950 = UIColor(hexString: "#0B5844")
    
    // MARK: - Neon
    
    static public let neon50 = UIColor(hexString: "#F5FCFC")
    static public let neon100 = UIColor(hexString: "#DBF6F5")
    static public let neon150 = UIColor(hexString: "#C3F0EE")
    static public let neon200 = UIColor(hexString: "#ABEAE7")
    static public let neon300 = UIColor(hexString: "#7ADED9")
    static public let neon400 = UIColor(hexString: "#4AD2CB")
    static public let neon500 = UIColor(hexString: "#1AC7BE")
    static public let neon600 = UIColor(hexString: "#00B2A9")
    static public let neon700 = UIColor(hexString: "#149C95")
    static public let neon800 = UIColor(hexString: "#118780")
    static public let neon850 = UIColor(hexString: "#107C76")
    static public let neon900 = UIColor(hexString: "#0E716C")
    static public let neon950 = UIColor(hexString: "#0D6762")
    
    // MARK: - Neon Gray
    
    static public let neonGray50 = UIColor(hexString: "#FAFAFB")
    static public let neonGray100 = UIColor(hexString: "#EDEFF1")
    static public let neonGray150 = UIColor(hexString: "#E1E4E7")
    static public let neonGray200 = UIColor(hexString: "#D5D9DE")
    static public let neonGray300 = UIColor(hexString: "#BDC4CB")
    static public let neonGray400 = UIColor(hexString: "#A4AEB8")
    static public let neonGray500 = UIColor(hexString: "#8D9AA6")
    static public let neonGray600 = UIColor(hexString: "#747E89")
    static public let neonGray700 = UIColor(hexString: "#5C646D")
    static public let neonGray800 = UIColor(hexString: "#454B51")
    static public let neonGray850 = UIColor(hexString: "#383D43")
    static public let neonGray900 = UIColor(hexString: "#2D3135")
    static public let neonGray950 = UIColor(hexString: "#202326")
    
    // MARK: - Night Sky
    
    static public let nightSky50 = UIColor(hexString: "#F8F6F9")
    static public let nightSky100 = UIColor(hexString: "#EAE4ED")
    static public let nightSky150 = UIColor(hexString: "#DAD0E1")
    static public let nightSky200 = UIColor(hexString: "#CBBDD5")
    static public let nightSky300 = UIColor(hexString: "#AD97BD")
    static public let nightSky400 = UIColor(hexString: "#8E70A6")
    static public let nightSky500 = UIColor(hexString: "#6F4A90")
    static public let nightSky600 = UIColor(hexString: "#543772")
    static public let nightSky700 = UIColor(hexString: "#3D285A")
    static public let nightSky800 = UIColor(hexString: "#2A1C43")
    static public let nightSky850 = UIColor(hexString: "#221739")
    static public let nightSky900 = UIColor(hexString: "#10002B")
    static public let nightSky950 = UIColor(hexString: "#160F28")
    
    // MARK: Orange
    
    static public let orange50 = UIColor(hexString: "#FFFEF3")
    static public let orange100 = UIColor(hexString: "#FFFCD9")
    static public let orange150 = UIColor(hexString: "#FFF9BD")
    static public let orange200 = UIColor(hexString: "#FFF3A2")
    static public let orange300 = UIColor(hexString: "#FFE16C")
    static public let orange400 = UIColor(hexString: "#FFC736")
    static public let orange500 = UIColor(hexString: "#FFA700")
    static public let orange600 = UIColor(hexString: "#FB9100")
    static public let orange700 = UIColor(hexString: "#F77D00")
    static public let orange800 = UIColor(hexString: "#F36800")
    static public let orange850 = UIColor(hexString: "#F15F00")
    static public let orange900 = UIColor(hexString: "#EF5600")
    static public let orange950 = UIColor(hexString: "#ED4D00")
    
    // MARK: Pink
    
    static public let pink50 = UIColor(hexString: "#FFF6F8")
    static public let pink100 = UIColor(hexString: "#FFE1EA")
    static public let pink150 = UIColor(hexString: "#FFCCDB")
    static public let pink200 = UIColor(hexString: "#FFB5CD")
    static public let pink300 = UIColor(hexString: "#FF8AB1")
    static public let pink400 = UIColor(hexString: "#FF5E97")
    static public let pink500 = UIColor(hexString: "#FF337E")
    static public let pink600 = UIColor(hexString: "#E62D73")
    static public let pink700 = UIColor(hexString: "#CE2769")
    static public let pink800 = UIColor(hexString: "#B5215F")
    static public let pink850 = UIColor(hexString: "#A91F59")
    static public let pink900 = UIColor(hexString: "#9D1C54")
    static public let pink950 = UIColor(hexString: "#911A4E")
    
    // MARK: - Purple
    
    static public let purple50 = UIColor(hexString: "#FCF6FE")
    static public let purple100 = UIColor(hexString: "#F6E1FE")
    static public let purple150 = UIColor(hexString: "#F0CDFE")
    static public let purple200 = UIColor(hexString: "#E9B7FE")
    static public let purple300 = UIColor(hexString: "#DA8CFD")
    static public let purple400 = UIColor(hexString: "#C960FD")
    static public let purple500 = UIColor(hexString: "#B733FE")
    static public let purple600 = UIColor(hexString: "#A02BE5")
    static public let purple700 = UIColor(hexString: "#8C23CD")
    static public let purple800 = UIColor(hexString: "#771DB4")
    static public let purple850 = UIColor(hexString: "#6E19A8")
    static public let purple900 = UIColor(hexString: "#64179C")
    static public let purple950 = UIColor(hexString: "#5C1490")
    
    // MARK: - Red
    
    static public let red50 = UIColor(hexString: "#FFF7F5")
    static public let red100 = UIColor(hexString: "#FFE5DD")
    static public let red150 = UIColor(hexString: "#FFD3C7")
    static public let red200 = UIColor(hexString: "#FFC1B0")
    static public let red300 = UIColor(hexString: "#FF9A85")
    static public let red400 = UIColor(hexString: "#FF715B")
    static public let red500 = UIColor(hexString: "#FF4733")
    static public let red600 = UIColor(hexString: "#EE3D32")
    static public let red700 = UIColor(hexString: "#DE3531")
    static public let red800 = UIColor(hexString: "#CE2E30")
    static public let red850 = UIColor(hexString: "#C52A2F")
    static public let red900 = UIColor(hexString: "#BD272F")
    static public let red950 = UIColor(hexString: "#B5232E")
    
    // MARK: - Yellow
    
    static public let yellow50 = UIColor(hexString: "#FFFEF3")
    static public let yellow100 = UIColor(hexString: "#FFFDD8")
    static public let yellow150 = UIColor(hexString: "#FFFCBD")
    static public let bok_yellow150 = UIColor(red: 1.00, green: 0.98, blue: 0.87, alpha: 1.00)
    static public let yellow200 = UIColor(hexString: "#FFF9A2")
    static public let yellow300 = UIColor(hexString: "#FFF06C")
    static public let yellow400 = UIColor(hexString: "#FFE436")
    static public let yellow500 = UIColor(hexString: "#FFD500")
    static public let yellow600 = UIColor(hexString: "#FFC100")
    static public let yellow700 = UIColor(hexString: "#FFA900")
    static public let yellow800 = UIColor(hexString: "#FF8E00")
    static public let yellow850 = UIColor(hexString: "#FF7E00")
    static public let yellow900 = UIColor(hexString: "#FF6E00")
    static public let yellow950 = UIColor(hexString: "#FF5C00")
}
