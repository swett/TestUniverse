//
//  NetworkLayer.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import RxSwift

final class OnboardingAPI {
    func fetchQuestions() -> Single<[QuestionModel]> {
        let url = URL(string: "https://test-ios.universeapps.limited/onboarding")!
        
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                guard let data = data else {
                    single(.failure(NSError(domain: "", code: -1)))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(QuestionResponse.self, from: data)
                    single(.success(response.items))
                } catch {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
