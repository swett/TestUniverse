//
//  WebViewController.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 03.11.2025.
//

import UIKit
import WebKit
import SnapKit

final class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let url: URL
    private let closeButton = UIButton(type: .system)
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(56) // Apply top padding
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        setupCloseButton()
        webView.load(URLRequest(url: url))
    }
    
    private func setupCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .darkGray
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.right.equalToSuperview().inset(14)
            $0.width.height.equalTo(32)
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
