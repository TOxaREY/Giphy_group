import UIKit

// Экран на котором показываются гифки
final class GiphyViewController: UIViewController {
    
    // @IBOutlet UILabel для счетчика гифок, например 1/10
    @IBOutlet weak var counterLabel: UILabel!
    
    // @IBOutlet UIImageView для Гифки
    @IBOutlet weak var giphyImageView: UIImageView!
    
    // @IBOutlet UIActivityIndicatorView загрузки гифки, так как она может загрухаться долго
    @IBOutlet weak var giphyActivityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var gifLabel: UILabel!
    
    private var alertPresenter: AlertPresenter?
    
    // Нажатие на кнопку лайка
    @IBAction func onYesButtonTapped() {
        // Проверка на то просмотрели или нет 10 гифок

        // Если все 10 гифок просомтрели необходимо показать UIAlertController о завершении
        // При нажатии на кнопку в UIAlertController необходимо сбросить счетчики и начать сначала
        
        // Иначе, если еще не просмотрели 10 гифок, то увеличиваем счетчик и обновляем UIlabel с счетчиком

        // Сохраняем понравившуюся гифку
        // presenter.saveGif(<Созданный UIImageView для @IBOutlet>.image)
        // Например -- presenter.saveGif(giphyImageView.image)

        // Загружаем следующую гифку
        // presenter.fetchNextGiphy()
        presenter.tappedButton(yes: true, image: giphyImageView.image)
    }

    // Нажатие на кнопку дизлайка
    @IBAction func onNoButtonTapped() {
        // Проверка на то просмотрели или нет 10 гифок

        // Если все 10 гифок просомтрели необходимо показать UIAlertController о завершении
        // При нажатии на кнопку в UIAlertController необходимо сбросить счетчики и начать

        // Иначе, если еще не просмотрели 10 гифок, то увеличиваем счетчик и обновляем UIlabel с счетчиком

        // Загружаем следующую гифку
        // presenter.fetchNextGiphy()
        presenter.tappedButton(yes: false, image: giphyImageView.image)
    }

    // Слой Presenter - бизнес логика приложения, к которым должен общаться UIViewController
    private lazy var presenter: GiphyPresenterProtocol = {
        let presenter = GiphyPresenter()
        presenter.viewController = self
        return presenter
    }()

    // MARK: - Жизенный цикл экрана

    override func viewDidLoad() {
        super.viewDidLoad()

        gifLabel.text = NSLocalizedString("Gif", comment: "gif label")
        alertPresenter = AlertPresenter(viewController: self)
        presenter.restart()
    }
}

// MARK: - Приватные методы

private extension GiphyViewController {
    
    func yesNoButtonsUnlock() {
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }
}

// MARK: - GiphyViewControllerProtocol

extension GiphyViewController: GiphyViewControllerProtocol {
    // Показ ошибки UIAlertController, что не удалось загрузить гифку
    func showError() {
        // Необходимо показать UIAlertController
        // Заголовок -- Что-то пошло не так(
        // Сообщение -- не возможно загрузить данные
        // Кнопка -- Попробовать еще раз
        //
        // При нажатии на кнопку необходимо перезагрузить гифку
        hideLoader()
        alertPresenter?.show(alertModel: AlertModel(title: NSLocalizedString("Wrong", comment: "Wrong title alert"), message: NSLocalizedString("Unable load", comment: "message alert unable load"), buttonText: NSLocalizedString("Try again", comment: "try again button"), completion: { [weak self] in
            guard let self = self else { return }
            self.presenter.fetchNextGiphy()
        }))
    }

    func showEndOfGiphy(message: String) {
        // Необходимо показать UIAlertController
        // Заголовок -- Мемы закончились!
        // Сообщение -- Вам понравилось: \(n)\\10
        // Кнопка -- Хочу посмотреть еще гифок
        //
        // При нажатии сбросить все счетчики -- вызов метода restart
        alertPresenter?.show(alertModel: AlertModel(title: NSLocalizedString("Memes over", comment: "Memes over title alert"), message: message, buttonText: NSLocalizedString("More gifs", comment: "more gifs button"), completion: { [weak self] in
            guard let self = self else { return }
            self.presenter.restart()
        }))
    }
    // Показать гифку UIImage
    func showGiphy(_ image: UIImage?) {
        yesNoButtonsUnlock()
        giphyImageView.image = image
    }

    // Показать лоадер
    // Присвоить UIImageView.image = nil
    // Вызвать giphyActivityIndicatorView показа индикатора загрузки
    func showLoader() {
        // presenter.saveGif(<Созданный UIImageView для @IBOutlet>.image)
        // Например -- presenter.saveGif(giphyImageView.image)
        giphyImageView.image = nil
        presenter.saveGif(giphyImageView.image)
        giphyActivityIndicatorView.startAnimating()
    }

    // Остановить giphyActivityIndicatorView показа индикатора загрузки
    func hideLoader() {
        giphyActivityIndicatorView.stopAnimating()
    }
    
    func counterLabelText(text: String) {
        counterLabel.text = text
    }
    
    func yesNoButtonsLock() {
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    func giphyImageViewAlpha(alpha: CGFloat) {
        giphyImageView.alpha = alpha
    }
    
    func giphyImageViewClearColor() {
        giphyImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func highlightImageBorder(isLike: Bool) {
        giphyImageView.layer.masksToBounds = true
        giphyImageView.layer.borderWidth = 8
        giphyImageView.layer.borderColor = isLike ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
}
