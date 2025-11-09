//
//  WishEventCreationView 2.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 07.11.2025.
//

import UIKit

final class WishEventCreationView: UIViewController { // HW4

    // MARK: - Constants
    private enum Constants {
        static let stackSpacing: CGFloat = 12
        static let horizontalPadding: CGFloat = 16
        static let topPadding: CGFloat = 20
        static let textFieldHeight: CGFloat = 44
        static let buttonCornerRadius: CGFloat = 10
        static let buttonHeight: CGFloat = 48
        static let labelFontSize: CGFloat = 16
        static let buttonFontSize: CGFloat = 18
        static let calendarTimeInterval: TimeInterval = 3600
        static let localeIdentifier = "ru_RU"

        static let titleLabel = "Title"
        static let descriptionLabel = "Description"
        static let startDateLabel = "Start Date"
        static let endDateLabel = "End Date"
        static let titlePlaceholder = "Enter title"
        static let descriptionPlaceholder = "Enter description"
        static let startDatePlaceholder = "Start Date in format dd.MM.yyyy"
        static let endDatePlaceholder = "End Date in format dd.MM.yyyy"
        static let saveButtonTitle = "Save"

        static let validationTitle = "Validation"
        static let validationMessage = "Title required"
        static let okButton = "OK"
        static let errorTitle = "Error"
        static let errorMessagePrefix = "Could not save event: "
        static let successTitle = "Done"
        static let successMessage = "Event added to Calendar"
        static let failureTitle = "Failed"
        static let failureMessage = "Could not add event to Calendar"
    }

    // MARK: - Properties
    var onSave: (() -> Void)?

    private var backgroundColor: UIColor
    private let stackView = UIStackView()
    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let startDateField = UITextField()
    private let endDateField = UITextField()
    private let saveButton = UIButton(type: .system)

    // MARK: - Init
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        configureUI()
    }

    // MARK: - UI Setup
    private func configureUI() {
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topPadding)
        ])

        func addField(labelText: String, textField: UITextField, placeholder: String) {
            let label = UILabel()
            label.text = labelText
            label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .semibold)
            stackView.addArrangedSubview(label)

            textField.borderStyle = .roundedRect
            textField.placeholder = placeholder
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
            stackView.addArrangedSubview(textField)
        }

        addField(labelText: Constants.titleLabel, textField: titleField, placeholder: Constants.titlePlaceholder)
        addField(labelText: Constants.descriptionLabel, textField: descriptionField, placeholder: Constants.descriptionPlaceholder)
        addField(labelText: Constants.startDateLabel, textField: startDateField, placeholder: Constants.startDatePlaceholder)
        addField(labelText: Constants.endDateLabel, textField: endDateField, placeholder: Constants.endDatePlaceholder)

        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = Constants.buttonCornerRadius
        saveButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        stackView.addArrangedSubview(saveButton)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(cancelPressed))
    }

    // MARK: - Actions
    @objc private func cancelPressed() {
        dismiss(animated: true)
    }

    @objc private func savePressed() {
        let title = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let desc = descriptionField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let startText = startDateField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let endText = endDateField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !title.isEmpty else {
            let alert = UIAlertController(
                title: Constants.validationTitle,
                message: Constants.validationMessage,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
            present(alert, animated: true)
            return
        }

        let startDate = dateFromString(startText) ?? Date()
        let endDate = dateFromString(endText) ?? Date().addingTimeInterval(Constants.calendarTimeInterval)

        do {
            try CoreDataManager.shared.saveEvent(
                title: title,
                descriptionText: desc,
                startDate: startText,
                endDate: endText
            )
        } catch {
            DispatchQueue.main.async { [weak self] in
                let alert = UIAlertController(
                    title: Constants.errorTitle,
                    message: Constants.errorMessagePrefix + error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
                self?.present(alert, animated: true)
            }
            return
        }

        let calendarModel = CalendarEventModel(
            title: title,
            startDate: startDate,
            endDate: endDate,
            note: desc
        )

        CalendarManager.shared.create(eventModel: calendarModel) { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }

                let title = success ? Constants.successTitle : Constants.failureTitle
                let message = success ? Constants.successMessage : Constants.failureMessage

                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.okButton, style: .default) { _ in
                    self.onSave?()
                    self.dismiss(animated: true)
                })
                self.present(alert, animated: true)
            }
        }
    }
}

// MARK: - Helpers
private func dateFromString(_ string: String) -> Date? {
    let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.isEmpty { return nil }

    let formats = [
        "dd.MM.yyyy HH:mm",
        "dd.MM.yyyy",
        "yyyy-MM-dd HH:mm",
        "yyyy-MM-dd"
    ]

    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")

    for format in formats {
        formatter.dateFormat = format
        if let date = formatter.date(from: trimmed) {
            return date
        }
    }
    return nil
}
