import Foundation
import UIKit
import Photos

// Presetner (бизнес слой для получения слудеющей гифки)
final class GiphyPresenter: GiphyPresenterProtocol {
    private var giphyFactory: GiphyFactoryProtocol
    // Переменная Int -- Счетчик залайканых или задизлайканных гифок
    // Например showdGifCounter -- счетчика показанных гифок
    private var showdGifCounter: Int = 1
    
    // Переменная Int -- Количество понравившихся гифок
    // Например likedGifCounter -- счетчик любимых гифок
    private var likedGifCounter: Int = 0
    
    // Слой View для общения и отображения случайной гифки
    weak var viewController: GiphyViewControllerProtocol?

    // MARK: - GiphyPresenterProtocol

    init(giphyFactory: GiphyFactoryProtocol = GiphyFactory()) {
        self.giphyFactory = giphyFactory
        self.giphyFactory.delegate = self
    }

    // Загрузка следующей гифки
    func fetchNextGiphy() {
        // Необходимо показать лоадер
        // Например -- viewController.showLoader()
        viewController?.showLoader()
        // Обратиться к фабрике и начать грузить новую гифку
        // Например -- giphyFactory.requestNextGiphy()
        giphyFactory.requestNextGiphy()
    }

    // Сохранение гифки
    func saveGif(_ image: UIImage?) {
        guard let data = image?.pngData() else {
            return
        }

        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, data: data, options: nil)
        })
    }
    
    // Учеличиваем счетчик просмотренных гифок на 1
    // Обновляем UILabel который находится в верхнем UIStackView и отвечает за количество просмотренных гифок
    // Обновляем счетчик просмотренных гифок UIlabel
    func updateCounterLabel() {
        showdGifCounter += 1
        viewController?.counterLabelText(text: "\(showdGifCounter)/10")
    }
    
    // Перезапускаем счетчики просмотренных гифок и понравивишихся гифок
    // Обновляем UILabel который находится в верхнем UIStackView и отвечает за количество просмотренных гифок
    // Загружаем гифку
    func restart() {
        showdGifCounter = 1
        likedGifCounter = 0
        viewController?.counterLabelText(text: "\(showdGifCounter)/10")
        fetchNextGiphy()
    }
    
    func tappedButton(yes yesButton: Bool, image: UIImage?) {
        viewController?.yesNoButtonsLock()
        if showdGifCounter == 10 {
            viewController?.showEndOfGiphy(message: "Вам понравилось: \(likedGifCounter)/10")
        } else {
            updateCounterLabel()
            if yesButton {
                likedGifCounter += 1
                saveGif(image)
                viewController?.highlightImageBorder(isLike: true)
            } else {
                viewController?.highlightImageBorder(isLike: false)
            }
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [weak self] in
                guard let self = self else { return }
                self.viewController?.giphyImageViewAlpha(alpha: 0.99)
            }) { [weak self] _ in
                guard let self = self else { return }
                self.viewController?.giphyImageViewAlpha(alpha: 1.0)
                self.viewController?.giphyImageViewClearColor()
                self.fetchNextGiphy()
            }
        }
    }
}

// MARK: - GiphyFactoryDelegate

extension GiphyPresenter: GiphyFactoryDelegate {
    // Успешная загрузка гифки
    func didRecieveNextGiphy(_ giphy: GiphyModel) {
        // Преобразуем набор картинок в гифку
        // !Обратите внимание в каком потоке это вызывается и нужно ли вызывать дополнительно!
        // DispatchQueue.main.async { [weak self] in
        //
        // Останавливаем индикатор загрузки -- viewController.hideHoaler()
        // Показать гифку -- viewController.showGiphy(image)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let image = UIImage.gif(url: giphy.url)
            self.viewController?.hideLoader()
            self.viewController?.showGiphy(image)
        }
        
    }

    // При загрузке гифки произошла ошибка
    func didReciveError(_ error: GiphyError) {
        // !Обратите внимание в каком потоке это вызывается и нужно ли вызывать дополнительно!
        // DispatchQueue.main.async { [weak self] in
        //
        // Останавливаем индикатор загрузки -- viewController.hideHoaler()
        // Показать ошибку -- viewController.showError()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewController?.hideLoader()
            self.viewController?.showError()
        }
    }
}
