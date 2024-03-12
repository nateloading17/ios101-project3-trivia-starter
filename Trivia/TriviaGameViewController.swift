//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Abraham Syed on 10/2/23.
//
import UIKit

class TriviaViewController: UIViewController {
    
    struct Question {
        let text: String
        let correctAnswer: Int
        let answers: [String]
    }

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    private let answerButtons: [UIButton] = {
        var buttons = [UIButton]()
        for _ in 0..<4 {
            let button = UIButton()
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.red.cgColor
            button.layer.borderWidth = 3.0
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.titleLabel?.lineBreakMode = .byWordWrapping
            buttons.append(button)
        }
        return buttons
    }()

    private var currentQuestionIndex = 0

    private let questions: [Question] = [
        Question(text: "What movie won best picture?", correctAnswer: 2, answers: ["Poor Things", "Barbie", "Oppenheimer", "American Fiction"]),
        Question(text: "What song won best original song?", correctAnswer: 0, answers: ["What Was I Made For?", "I'm Just Ken", "Wahzhazhe", "It Never Went Away"]),
        Question(text: "Whao won best actress?", correctAnswer: 1, answers: ["Lily Gladstone", "Emma Stone", "Carey Mulligan", "Annette Bening"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
        setupUI()
        loadQuestion()
    }

    private func setupUI() {
        view.addSubview(questionLabel)
        for button in answerButtons {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        var previousButton: UIButton?
        for button in answerButtons {
            if let previousButton = previousButton {
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 20).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
            }
            previousButton = button
        }

        for (index, button) in answerButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        }
    }

    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            // Handle end of questions
            return
        }

        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text

        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
        }
    }

    @objc private func answerButtonTapped(_ sender: UIButton) {
        let selectedAnswer = sender.tag
        let question = questions[currentQuestionIndex]
        let isCorrect = selectedAnswer == question.correctAnswer
        displayResultPopUp(isCorrect)

        // Load the next question
        currentQuestionIndex += 1
        loadQuestion()
    }

    private func displayResultPopUp(_ isCorrect: Bool) {
        let popUp = UIAlertController(title: isCorrect ? "Correct" : "Incorrect", message: nil, preferredStyle: .alert)
        popUp.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(popUp, animated: true, completion: nil)
    }
}
