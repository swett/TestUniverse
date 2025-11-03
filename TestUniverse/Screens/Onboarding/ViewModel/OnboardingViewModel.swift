//
//  OnboardingViewModel.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
    private let api = OnboardingAPI()
    private let disposeBag = DisposeBag()

    let questions = BehaviorRelay<[QuestionModel]>(value: [])
    let currentIndex = BehaviorRelay<Int>(value: 0)
    let selectedAnswer = BehaviorRelay<String?>(value: nil)
    let didFinish = PublishRelay<Void>()
    
    var currentQuestion: Observable<QuestionModel?> {
        return Observable.combineLatest(questions, currentIndex)
            .map { questions, index in
                guard index < questions.count else { return nil }
                return questions[index]
            }
    }
    
    init() {
        fetch()
    }
    
    private func fetch() {
        api.fetchQuestions()
            .subscribe(onSuccess: { [weak self] items in
                self?.questions.accept(items)
            }, onFailure: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func nextQuestion() {
            let next = currentIndex.value + 1
            if next < questions.value.count {
                currentIndex.accept(next)
                selectedAnswer.accept(nil)
            } else {
                didFinish.accept(())
            }
        }
}
