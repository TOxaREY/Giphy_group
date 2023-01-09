import UIKit

// Протокол для общения между Presenter и View слоями
protocol GiphyViewControllerProtocol: AnyObject {
    // Отображение ошибки при загрузке гифки
    func showError()

    // Отображение гифки
    func showGiphy(_ image: UIImage?)

    // Начать показывать индикатор загрузки гифки
    func showLoader()

    // Закончить показывать индикатор загрузки гифки
    func hideLoader()
    
    func counterLabelText(text: String)
    
    func yesNoButtonsLock()
    
    func showEndOfGiphy(message: String)
    
    func giphyImageViewAlpha(alpha: CGFloat)
    
    func giphyImageViewClearColor()
    
    func highlightImageBorder(isLike: Bool)
}
