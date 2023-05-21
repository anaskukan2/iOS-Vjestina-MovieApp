
import UIKit
import PureLayout

class LogInViewController: UIViewController {
    
    private var signInLabel: UILabel!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews(){
        signInLabel = UILabel()
        view.addSubview(signInLabel)
        
        emailLabel = UILabel()
        view.addSubview(emailLabel)
        
        passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        
        emailTextField = UITextField()
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        
        signInButton = UIButton()
        view.addSubview(signInButton)
    }
    
    private func styleViews(){
        view.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        
        signInLabel.text = "Sign in"
        signInLabel.textColor = .white
        signInLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        emailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .white
        passwordLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        styleTextField(emailTextField, placeholder: "ex. Matt@iosCourse.com")
        styleTextField(passwordTextField, placeholder: "Enter your password")
        
        signInButton.backgroundColor = .white
        signInButton.layer.backgroundColor = UIColor(red: 0.298, green: 0.698, blue: 0.875, alpha: 1).cgColor
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.titleLabel?.textColor = .white
        signInButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private func defineLayout(){
        signInLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 92)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        signInLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailLabel.autoPinEdge(.top, to: .bottom, of: signInLabel, withOffset: 48)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        emailTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        emailTextField.autoSetDimension(.height, toSize: 48)
        
        passwordLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordLabel.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: 24)
        
        passwordTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordTextField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        passwordTextField.autoSetDimension(.height, toSize: 48)
        
        signInButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 48)
        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
        signInButton.autoSetDimension(.height, toSize: 40)
        
    }
    
    private func styleTextField(_ textField: UITextField, placeholder: String) {
        textField.backgroundColor = UIColor(red: 0.073, green: 0.23, blue: 0.387, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(red: 0.298, green: 0.698, blue: 0.87, alpha: 1.0)]
            )
        textField.layer.borderColor = UIColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        }
   
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
