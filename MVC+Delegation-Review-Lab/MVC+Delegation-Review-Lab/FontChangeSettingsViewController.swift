import UIKit

class FontChangeSettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var fontValueSlider: UISlider!
    @IBOutlet var fontValueStepper: UIStepper!
    @IBOutlet var fontValuePreviewLabel: UILabel!
    
    // MARK: - Internal Properties
    
    var delegate: FontSizeChangeable?
    
    var initialStartingFontSize = Constants.startingFontSize
    
    // MARK: - Private Properties
    
    private var currentFontSize: CGFloat! {
        didSet {
            delegate?.changeFontSize(to: currentFontSize)
            updateUIElementsWithCurrentFontSize()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFontSize = initialStartingFontSize
    }
    
    // MARK - IBActions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sender.setValue(Float(lroundf(sender.value)), animated: true)
        currentFontSize = CGFloat(sender.value)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        currentFontSize = CGFloat(sender.value)
    }
    
    // MARK: - Private Methods
    
    private func updateUIElementsWithCurrentFontSize() {
        fontValueSlider.value = Float(currentFontSize)
        fontValueStepper.value = Double(currentFontSize)
        fontValuePreviewLabel.text = getCurrentLabelText()
    }
    
    private func getCurrentLabelText() -> String {
        return "Preview Font Size: \(currentFontSize!)"
    }
}
