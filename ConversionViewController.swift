
import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var thisFlag = false
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32 ) * (5/9)
        }else {
            return nil
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.decimalSeparator = ","
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        }else {
            fahrenheitValue = nil
        }
    }

    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                print("ConversionViewController loaded its view")
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }else {
            celsiusLabel.text = " "
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if thisFlag == true {
            thisFlag = false
            let blueColor = UIColor(red: 210/255.0, green: 210/255.0, blue: 255/255.0, alpha: 1.0)
            view.backgroundColor = blueColor
        }else {
            thisFlag = true
            let redColor = UIColor(red: 255/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1.0)
            view.backgroundColor = redColor
        }
        
        
        print("This flag is \(thisFlag)")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        let replacementTextHasLetters = textField.text?.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet())
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil && replacementTextHasLetters != nil {
            return false
        } else {
            return true
        }
    }
    
}
