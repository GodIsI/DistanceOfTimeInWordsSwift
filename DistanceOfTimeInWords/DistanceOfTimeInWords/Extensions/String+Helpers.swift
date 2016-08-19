import Foundation
import UIKit

extension String {

    static let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    fileprivate static let FullDateTimeString = "dd MMMM yyyy"

    /**
     empty provides a way of being explicite that you wanted an empty string
     - returns: an empty string ('')
     */
    static var empty:String {
        return ""
    }

    /**
     space provides a way of being explicite that you wanted an single space string
     - returns: a space (' ')
     */
    static var space:String {
        return " "
    }

    /**
     newLineTab provides a string containing NewLine and Tab characters
     - returns: NewLine and Tab ('\n\t')
     */
    static var newlineTab:String {
        return "\n\t"
    }

    /**
     newline provides a string containing NewLine
     - returns: NewLine ('\n')
     */
    static var newline:String {
        return "\n"
    }


    var isValidEmail:Bool {
        do {
            let regExpression = try NSRegularExpression(pattern: String.EmailRegex, options: .caseInsensitive)
            let matches = regExpression.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.characters.count))
            if matches > 0 {
                return true
            }
        }
        catch {
            //FIXME: Replace with your own logging if not using 'print'
            print("error: \(error)")
        }
        return false
    }

    /**
     Proivdes a convenience wrapper to the NSString format ability
     - parameters args: CVarArgType... allows for a list of 'String' elements to be inserted into the string
     
     - returns: Formatted String with args inserted in order of appearance in the list
     */
    func format(_ args:CVarArg...) -> String {
        return self.format(getVaList(args))
    }

    /**
     Provides a convenience wrapper to the NSString format ability
     - parameters args: CVaListPointer... allows for a list of 'String' elements to be inserted into the string

     - returns: Formatted String with args inserted in order of appearance in the list
     */
    func format(_ args:CVaListPointer) -> String {
        return NSString(format: self, arguments: args) as String
    }

    /**
     Provides a convenience func to determine the height required for a string based on an avaliable width and Font
     - parameters font: UIFont, to be used to determine require size of string.
     - parameters width: CGFloat, the restriciton in width allows for a determined height.

     - returns: Height required for the current string
     */
    func heightForText(_ font:UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string:self).boundingRect(with: CGSize(width:width, height:CGFloat.greatestFiniteMagnitude), options:.usesLineFragmentOrigin, attributes:[NSFontAttributeName:font], context:nil)
        return ceil(rect.height)
    }

    /**
     Provides a convenience func to determine the width required for a string based on an avaliable height and Font
     - parameters font: UIFont, to be used to determine require size of string.
     - parameters height: CGFloat, the restriciton in height allows for a determined width.

     - returns: Width required for the current string
     */
    func widthForText(_ font:UIFont, height:CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        return ceil(rect.width)
    }

    /**
     Provides a convenient way of changing a string into a date value. Uses 'dd MMMM yyyy' as the format.

     - returns: Date value or nil
     */
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String.FullDateTimeString
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
