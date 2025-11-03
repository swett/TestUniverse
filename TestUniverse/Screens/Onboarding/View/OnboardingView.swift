//
//  OnboardingView.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingViewController: UIViewController {
    private let viewModel: OnboardingViewModel
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let questionLabel = UILabel()
    private let answersStack = UIStackView()
    private let nextButton = CapsuleButton(type: .system)
    private let coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol, viewModel: OnboardingViewModel) {
            self.coordinator = coordinator
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorF1F1F5
        
        titleLabel.text = "Let’s setup App for you"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        
        answersStack.axis = .vertical
        answersStack.spacing = 12
        
        nextButton.setTitle("Continue", for: .normal)
        nextButton.backgroundColor = .colorFFFFFF
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nextButton.layer.cornerRadius = 40
        nextButton.clipsToBounds = true
        nextButton.isEnabled = false
        nextButton.addShadow(color: .color808080, opacity: 0.25, offset: CGSize(width: 0, height: -4), radius: 36)
        
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(answersStack)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.left.equalToSuperview().offset(24)
            $0.right.lessThanOrEqualToSuperview().inset(24)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(24)
            $0.right.lessThanOrEqualToSuperview().inset(24)
        }
        
        answersStack.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(56)
            $0.width.equalTo(327)
        }
    }
    
    private func bindViewModel() {
        viewModel.currentQuestion
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] question in
                self?.updateQuestionUI(question)
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedAnswer
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] answer in
                self?.nextButton.isEnabled = (answer != nil)
                self?.nextButton.backgroundColor = answer != nil ? .color101B18: .colorFFFFFF
                self?.nextButton.setTitleColor(answer != nil ? .colorFFFFFF : .colorCACACA, for: .normal)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.nextQuestion()
            }
            .disposed(by: disposeBag)
        
        viewModel.didFinish
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                let subscriptionVC = SubscriptionViewController()
                subscriptionVC.modalPresentationStyle = .fullScreen
                self.present(subscriptionVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateQuestionUI(_ question: QuestionModel) {
        answersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        questionLabel.text = question.question
        
        for answer in question.answers {
            let button = UIButton(type: .system)
            button.setTitle(answer, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.setTitleColor(.color1A1A1A, for: .normal)
            button.layer.cornerRadius = 16
            button.backgroundColor = .colorFFFFFF
            button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            button.addShadow(color: .color969696, opacity: 0, offset: CGSize(width: 0, height: 1), radius: 7)
            button.contentHorizontalAlignment = .left
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.viewModel.selectedAnswer.accept(answer)
                    self?.highlightSelected(button)
                })
                .disposed(by: disposeBag)
            
            answersStack.addArrangedSubview(button)
        }
    }
    
    private func highlightSelected(_ selected: UIButton) {
        for case let button as UIButton in answersStack.arrangedSubviews {
            button.backgroundColor = (button == selected) ? .color47BE9A : .colorFFFFFF
            button.setTitleColor((button == selected) ? .colorFFFFFF : .color1A1A1A, for: .normal)
        }
    }
}
