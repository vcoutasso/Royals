//
//  MutiatributedLabelView.swift
//  Royals
//
//  Created by Bruno Thuma on 08/09/21.
//

import UIKit

class MultiatributedLabelView: UILabel {
    private var theme: MapPinType
    private var firstMString, secondMString, themedMString: NSMutableAttributedString

    init(theme: MapPinType) {
        self.theme = theme

        var color: UIColor
        var firstText, themedText, secondText: String

        switch theme {
        case .skateSpot:
            color = Assets.Colors.green.color
            themedText = "Pico"
        case .skateStopper:
            color = Assets.Colors.red.color
            themedText = "Stopper"
        }

        firstText = Strings.Localizable.MapScene.AddLocationForm.title1
        secondText = Strings.Localizable.MapScene.AddLocationForm.title2

        // TODO: This is bad implementation,
        // try using either the second implementation
        // in the first link or the answer in the second
        // https://www.refactorstudios.com/blog/nsattributedstring
        // https://stackoverflow.com/questions/27728466/use-multiple-font-colors-in-a-single-label
        let themedAttributes: [NSAttributedString.Key: Any]
        themedAttributes = [
            NSAttributedString.Key.font: UIFont(font: Fonts.SpriteGraffiti.regular,
                                                size: 26)!,
            NSAttributedString.Key.foregroundColor: color,
        ]
        let generalAttributes: [NSAttributedString.Key: Any]
        generalAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24,
                                                           weight: .semibold),
            NSAttributedString.Key.foregroundColor: Assets.Colors.white.color,
        ]

        firstMString = NSMutableAttributedString(string: firstText,
                                                 attributes: generalAttributes)
        secondMString = NSMutableAttributedString(string: secondText,
                                                  attributes: generalAttributes)
        themedMString = NSMutableAttributedString(string: themedText,
                                                  attributes: themedAttributes)

        firstMString.append(themedMString)
        firstMString.append(secondMString)

        super.init(frame: .zero)

        attributedText = firstMString
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSMutableAttributedString {
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        enumerateAttribute(.font,
                           in: NSRange(location: 0, length: length)) { value, range, _ in

            if let f = value as? UIFont,
               let newFontDescriptor = f.fontDescriptor
               .withFamily(font.familyName)
               .withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                let newFont = UIFont(descriptor: newFontDescriptor,
                                     size: font.pointSize)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(.foregroundColor,
                                    range: range)
                    addAttribute(.foregroundColor,
                                 value: color,
                                 range: range)
                }
            }
        }
        endEditing()
    }
}
