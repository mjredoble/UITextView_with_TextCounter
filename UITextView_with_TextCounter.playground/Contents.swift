//: Playground - noun: a place where people can play
import Foundation
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = containerView

let paragraph = NSMutableParagraphStyle()
paragraph.alignment = .left

let attributes = [NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)]

let fullText =  NSMutableAttributedString(string: "The quick brown fox the lazy dog and jumps over the fence", attributes: attributes)

let frame = CGRect(x: 10, y: 10, width: 355, height: 120)
let textView = TextCounterTextView(frame: frame)
textView.maximumNumberOfText = 100
textView.font = UIFont.systemFont(ofSize: 17)
textView.backgroundColor = UIColor.lightGray
textView.textAlignment = .left
textView.attributedText = fullText
containerView.addSubview(textView)

class TextCounterTextView: UITextView {
    var maximumNumberOfText: Int = 0 {
        didSet {
            self.textContainerInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate = self
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }

    override func draw(_ rect: CGRect) {
        showTextCounter(rect: rect)
    }
    
    func showTextCounter(rect: CGRect) {
        if maximumNumberOfText != 0 {
            let textCount = getTextCount()
            let textLimit = maximumNumberOfText
            
            let newX = rect.width - (getTextCounterRect().width + 10)
            let textRect = CGRect(x: newX, y: rect.minY, width: rect.width, height: rect.height)
            drawText(myText: "\(textCount)/\(textLimit)", textColor: UIColor.white, inRect: textRect)
        }
    }
    
    func drawText(myText:String,textColor:UIColor, inRect:CGRect){
        let attributes = [NSAttributedStringKey.foregroundColor: textColor, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13.0)]
        
        myText.draw(in: inRect, withAttributes: attributes)
    }
    
    func getTextCount() -> Int {
        return self.text.characters.count
    }
    
    func getTextCounterRect() -> CGSize {
        let string = "\(getTextCount())/\(maximumNumberOfText)"
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13.0)]
        return string.size(withAttributes: attributes)
    }
}

extension TextCounterTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        setNeedsDisplay()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if maximumNumberOfText == 0{
            return true
        }
        
        return getTextCount() < maximumNumberOfText
    }
}
