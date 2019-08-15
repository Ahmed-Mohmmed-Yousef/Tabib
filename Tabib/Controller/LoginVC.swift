//
//  LoginVC.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/10/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // animation
        animateLogo()
        
        // Keyboard Register
        
        googleBtn.addRaduiasAndShadow()
        phoneBtn.addRaduiasAndShadow()
        loginBtn.addRaduiasAndShadow()
        
        // text feild delegat
        emailTF.delegate = self
        passwordTF.delegate = self
        
        // google sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    /// Google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                // ...
                return
            }
            // User is signed in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func animateLogo(){
        // 360 * pi/180
        let width = view.frame.width
        let height = view.frame.height
        let animeView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        animeView.backgroundColor = UIColor.white
        let animeImage = UIImageView(frame: CGRect(x: (width/2 - 100), y: (height/2 - 100), width: 200, height: 200))
        animeImage.image = #imageLiteral(resourceName: "logo")
        
        view.addSubview(animeView)
        animeView.addSubview(animeImage)
        
        let radians = CGFloat(200 * Double.pi / 180)
        UIView.animate(withDuration: 1.2, delay: 0.4, options: [.curveEaseIn], animations: {
            animeImage.alpha = 0
            animeImage.transform = CGAffineTransform(rotationAngle: radians).scaledBy(x: 3, y: 3)
            
            let yRoyation = CATransform3DMakeRotation(radians, 0, radians, 0)
            animeImage.layer.transform = CATransform3DConcat(animeImage.layer.transform, yRoyation)
            
        }) { (success) in
            animeView.removeFromSuperview()
        }
    }
    
    @IBOutlet weak var emailLine: UIView!
    @IBAction func BEdit(_ sender: Any) {
        emailLine.backgroundColor = UIColor.red
    }
    
    @IBAction func doneEidting(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func loginPressed(_ sender: Any) {
        guard emailTF.hasValue, passwordTF.hasValue, let emaial = emailTF.text, let password = passwordTF.text else { return}
        // end editing
        endEditing()
        AuthController.login(emaial, password) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "alert", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else{
                self.dismiss(animated: true)
            }
            
        }
    }
    @IBAction func forgetPassworedPressed(_ sender: Any) {
    }
    @IBAction func signWithGooglePressed(_ sender: Any) {
        AuthController.loginWithGoogle()
    }
    @IBAction func signWithPhonePressed(_ sender: Any) {
    }
    @IBAction func notHaveAccountPressed(_ sender: Any) {
//        let signUpVC = SignUpVC.getInstance() as! SignUpVC
//        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //  Keyboard controlle
    
}
extension LoginVC: UITextFieldDelegate{
    
    //MARK:- text field Delegates
    func endEditing(){
        bottomConstrain.constant = 24
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomConstrain.constant = 300
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing()
    }
}
