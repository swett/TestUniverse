//
//  SubscriptionViewController.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 03.11.2025.
//

import Foundation
import UIKit
import SnapKit
import StoreKit
import WebKit

final class SubscriptionViewController: UIViewController {
    private let imageView = UIImageView()
    private let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let priceLabel = UILabel()
    private let subscribeButton = CapsuleButton(type: .system)
    private let footerLabel = UILabel()
    private let termsStack = UIStackView()
    
    
    private var termsButton: UIButton!
    private var privacyButton: UIButton!
    private var subscriptionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorF1F1F5
        
        // --- Image ---
        imageView.image = UIImage(named: "Onboarding4Light") // replace with your asset
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview() // ignore safe area
            $0.left.right.equalToSuperview()
            $0.height.equalTo(406)
        }
        
        // --- Close Button ---
        closeButton.setBackgroundImage(UIImage(named: "close_icon"), for: .normal)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.right.equalToSuperview().inset(20)
            $0.width.height.equalTo(32)
        }
        
        // --- Labels ---
        titleLabel.text = "Discover all Premium features"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .color1A1A1A
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
       
        
        subtitleLabel.text = "Try 7 days for free"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = .color6E6E73
        
        let priceText = NSMutableAttributedString(
            string: "then ",
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor.color6E6E73]
        )
        priceText.append(NSAttributedString(
            string: "$6.99 ",
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.color1A1A1A]
        ))
        priceText.append(NSAttributedString(
            string: "per week, auto-renewable",
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium), .foregroundColor: UIColor.color6E6E73]
        ))
        priceLabel.attributedText = priceText
        priceLabel.textAlignment = .left
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(priceLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(24)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(-2)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        // --- Subscription Button ---
        subscribeButton.setTitle("Start Now", for: .normal)
        subscribeButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        subscribeButton.backgroundColor = .color101B18
        subscribeButton.setTitleColor(.white, for: .normal)
        subscribeButton.layer.cornerRadius = 28
        subscribeButton.clipsToBounds = true
        subscribeButton.addShadow(color: .color808080, opacity: 0.25, offset: CGSize(width: 0, height: -4), radius: 36)
        view.addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-78)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(327)
            $0.height.equalTo(56)
        }
        
        // --- Footer with Policy buttons ---
        footerLabel.text = "By continuing you accept our:"
        footerLabel.font = .systemFont(ofSize: 12, weight: .regular)
        footerLabel.textColor = .color6E6E73
        footerLabel.textAlignment = .center
        view.addSubview(footerLabel)
        footerLabel.snp.makeConstraints {
            $0.top.equalTo(subscribeButton.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        termsButton = makePolicyButton("Terms of Use,")
        privacyButton = makePolicyButton("Privacy Policy,")
        subscriptionButton = makePolicyButton("Subscription Terms")
        termsStack.axis = .horizontal
        termsStack.alignment = .center
        termsStack.spacing = 3
        termsStack.distribution = .equalSpacing
        [termsButton, privacyButton, subscriptionButton].forEach { termsStack.addArrangedSubview($0) }
        view.addSubview(termsStack)
        termsStack.snp.makeConstraints {
            $0.top.equalTo(footerLabel.snp.bottom).offset(-6)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func makePolicyButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        subscribeButton.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)
        
        termsButton.addTarget(self, action: #selector(openTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchUpInside)
        subscriptionButton.addTarget(self, action: #selector(openSubscription), for: .touchUpInside)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func openTerms() {
        openWebView(with: "https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview")
    }
    
    @objc private func openPrivacy() {
        openWebView(with: "https://opaque-production-68e.notion.site/Universe-Group-8c54476f3e4a4ee2988cd0df7ddcfbfa")
    }
    
    @objc private func openSubscription() {
        openWebView(with: "https://www.apple.com/ua/")
    }
    
    private func openWebView(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let webVC = WebViewController(url: url)
        webVC.modalPresentationStyle = .fullScreen
        present(webVC, animated: true)
    }
    
    // MARK: - StoreKit 2 Subscription Flow
    @objc private func subscribeTapped() {
        Task {
            do {
                // Example: replace with your real product ID
                guard let product = try await Product.products(for: ["com.yourapp.premium.weekly"]).first else { return }
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    if case .verified(_) = verification {
                        print("✅ Purchase success")
                    } else {
                        print("⚠️ Purchase not verified")
                    }
                default:
                    break
                }
            } catch {
                print("❌ Purchase failed: \(error)")
            }
        }
    }
}
