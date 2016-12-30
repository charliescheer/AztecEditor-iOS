import Foundation
import UIKit

class Blockquote: NSObject, NSCoding {
    public func encode(with aCoder: NSCoder) {

    }

    override public init() {

    }

    required public init?(coder aDecoder: NSCoder){

    }

    static func ==(lhs: Blockquote, rhs: Blockquote) -> Bool {
        return true
    }
}

struct BlockquoteFormatter: ParagraphAttributeFormatter {


    func apply(toAttributes attributes: [String : Any]) -> [String: Any] {
        var resultingAttributes = attributes
        let newParagraphStyle = ParagraphStyle()
        if let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle {
            newParagraphStyle.setParagraphStyle(paragraphStyle)
        }
        newParagraphStyle.headIndent += Metrics.defaultIndentation
        newParagraphStyle.firstLineHeadIndent = newParagraphStyle.headIndent
        newParagraphStyle.tailIndent -= Metrics.defaultIndentation
        newParagraphStyle.paragraphSpacing += Metrics.defaultIndentation
        newParagraphStyle.paragraphSpacingBefore += Metrics.defaultIndentation
        newParagraphStyle.blockquote = Blockquote()
        resultingAttributes[NSParagraphStyleAttributeName] = newParagraphStyle
        return resultingAttributes
    }

    func remove(fromAttributes attributes:[String: Any]) -> [String: Any] {
        var resultingAttributes = attributes
        let newParagraphStyle = ParagraphStyle()
        guard let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? ParagraphStyle,
            paragraphStyle.blockquote != nil else {
            return resultingAttributes
        }
        newParagraphStyle.setParagraphStyle(paragraphStyle)
        newParagraphStyle.headIndent -= Metrics.defaultIndentation
        newParagraphStyle.firstLineHeadIndent = newParagraphStyle.headIndent
        newParagraphStyle.tailIndent += Metrics.defaultIndentation
        newParagraphStyle.paragraphSpacing -= Metrics.defaultIndentation
        newParagraphStyle.paragraphSpacingBefore -= Metrics.defaultIndentation
        newParagraphStyle.blockquote = nil
        resultingAttributes[NSParagraphStyleAttributeName] = newParagraphStyle
        return resultingAttributes
    }

    func present(inAttributes attributes: [String : AnyObject]) -> Bool {
        if let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? ParagraphStyle {
            return paragraphStyle.blockquote != nil
        }
        return false
    }
}
