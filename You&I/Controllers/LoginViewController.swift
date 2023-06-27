//
//  LoginViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/26.
//

import UIKit
import Then
import SnapKit
import Lottie
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import CryptoKit
import FirebaseAuth

class LoginViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
   fileprivate var currentNonce: String?

   func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
      return self.view.window!

   }
   func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        guard let nonce = currentNonce else {
          fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
          print("Unable to fetch identity token")
          return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
          return
        }
        // Initialize a Firebase credential, including the user's full name.
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                          rawNonce: nonce,
                                                          fullName: appleIDCredential.fullName)
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
           if (error != nil) {
            // Error. If error.code == .MissingOrInvalidNonce, make sure
            // you're sending the SHA256-hashed nonce as a hex string with
            // your request to Apple.
              print(error!.localizedDescription)
            return
          }
          // User is signed in to Firebase with Apple.
          // ...
        }
      }
   }
       
   // Apple ID 연동 실패 시
   func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
       // Handle error.
   }
    private let kakaoLoginBtn = UIButton().then {
        $0.setImage(UIImage(named: "카카오로그인"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let ApppleLoginBtn = UIButton().then {
        $0.setImage(UIImage(named: "애플로그인"), for: .normal)
        $0.contentMode = .scaleAspectFit


    }
    private let welecomeImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "니캉내캉로고")
    }
    
    let animationView: LottieAnimationView = {
        let animView = LottieAnimationView(name: "99228-heart2heart")
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    private func addSubView() {
        self.view.addSubview(welecomeImg)
        self.view.addSubview(ApppleLoginBtn)
        self.view.addSubview(kakaoLoginBtn)

    }
    
    private func layout() {
       welecomeImg.snp.makeConstraints {
           $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
           $0.leading.equalToSuperview().offset(20)
           $0.trailing.equalToSuperview().offset(-20)
           $0.height.equalTo(400)
       }

       // Apple 로그인 버튼의 제약 조건 설정
       ApppleLoginBtn.snp.makeConstraints {
           $0.top.equalTo(welecomeImg.snp.bottom).offset(10)
           $0.trailing.equalToSuperview().offset(-20)
           $0.leading.equalToSuperview().offset(20)
       }
       kakaoLoginBtn.snp.makeConstraints{
           $0.top.equalTo(ApppleLoginBtn.snp.bottom).offset(10)
           $0.trailing.equalToSuperview().offset(-20)
           $0.leading.equalToSuperview().offset(20)
       }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackground
        addSubView()
        layout()
        ApppleLoginBtn.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        kakaoLoginBtn.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
   
    @objc private func appleLoginButtonTapped() {
    print("applelogin")
       startSignInWithAppleFlow()

        //!self.dismiss(animated: true)
    }
   private func loginInFirebase() {

       UserApi.shared.me() { user, error in
           if let error = error {
               print("DEBUG: 카카오톡 사용자 정보가져오기 에러 \(error.localizedDescription)")
           } else {
               print("DEBUG: 카카오톡 사용자 정보가져오기 success.")

               // 파이어베이스 유저 생성 (이메일로 회원가입)
               Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                      password: "\(String(describing: user?.id))") { result, error in
                   if let error = error {
                       print("DEBUG: 파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                       Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                          password: "\(String(describing: user?.id))")
                   } else {
                       print("DEBUG: 파이어베이스 사용자 생성")
                   }
               }
           }
       }
   }
    @objc private func kakaoLoginButtonTapped() {
       UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
           if let error = error {
               print(error)
           }
           else {
               print("loginWithKakaoAccount() success.")
               
               //do something
               _ = oauthToken
               // 어세스토큰 (서버분들 한테 드릴 토큰)
               let accessToken = oauthToken?.accessToken
               // accessToken
              self.loginInFirebase()
               print(accessToken as Any)
           }
       }
    }
}
extension LoginViewController {
   private func randomNonceString(length: Int = 32) -> String {
     precondition(length > 0)
     var randomBytes = [UInt8](repeating: 0, count: length)
     let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
     if errorCode != errSecSuccess {
       fatalError(
         "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
       )
     }

     let charset: [Character] =
       Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

     let nonce = randomBytes.map { byte in
       // Pick a random character from the set, wrapping around if needed.
       charset[Int(byte) % charset.count]
     }

     return String(nonce)
   }
   @available(iOS 13, *)
   private func sha256(_ input: String) -> String {
     let inputData = Data(input.utf8)
     let hashedData = SHA256.hash(data: inputData)
     let hashString = hashedData.compactMap {
       String(format: "%02x", $0)
     }.joined()

     return hashString
   }

   @available(iOS 13, *)
   func startSignInWithAppleFlow() {
     let nonce = randomNonceString()
     currentNonce = nonce
     let appleIDProvider = ASAuthorizationAppleIDProvider()
     let request = appleIDProvider.createRequest()
     request.requestedScopes = [.fullName, .email]
     request.nonce = sha256(nonce)

     let authorizationController = ASAuthorizationController(authorizationRequests: [request])
     authorizationController.delegate = self
     authorizationController.presentationContextProvider = self
     authorizationController.performRequests()
   }
       
       
}

