//
//  LoginViewController.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInDelegate {
    

    @IBOutlet weak var imageCheckBox: UIImageView!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var buttonLoginFB: UIView!
    @IBOutlet weak var buttonLoginGoogle: UIView!
    var checkBoxTrue = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSignIn.layer.cornerRadius = 10.0
        self.prepareBtnFacebook()
        self.prepareBtnGoogle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkBoxTrue = false
        self.changeBoxRemember()
    }
    
    func prepareBtnFacebook(){
        let loginButton = FBLoginButton()
        loginButton.center = CGPoint(x: self.btnSignIn.frame.size.width ,
        y:  self.btnSignIn.frame.size.height / 2)
        loginButton.isUserInteractionEnabled = false
        self.buttonLoginFB.addSubview(loginButton)
        self.buttonLoginFB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHomePage(_:))))
    }
    
    func prepareBtnGoogle(){
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let googleButton = GIDSignInButton()
        googleButton.center = CGPoint(x: self.buttonLoginGoogle.frame.size.width / 2 ,
        y:  self.buttonLoginGoogle.frame.size.height / 2)
        googleButton.isUserInteractionEnabled = false
        self.buttonLoginGoogle.addSubview(googleButton)
        self.buttonLoginGoogle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHomePage(_:))))
    }
    
    @objc func goToHomePage(_ gestureRecognizer: UITapGestureRecognizer) {
        let vc = TabMainViewController()
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    func changeBoxRemember(){
        if(checkBoxTrue == false){
            self.imageCheckBox.image = UIImage(named: "uncheckbox")
            self.checkBoxTrue = true
        }
        else{
            self.imageCheckBox.image = UIImage(named: "checkbox")
            self.checkBoxTrue = false
        }
    }

    @IBAction func btnCheckBox(_ sender: Any) {
        self.changeBoxRemember()
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let vc = TabMainViewController()
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        return
    }
}
