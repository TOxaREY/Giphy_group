## **Giphy**

Giphy - это приложение для просмотра и скачинваия гифок к себе на телефон.

## **Ссылки**

[Документация](https://developers.giphy.com/explorer/?)

[Макет](https://www.figma.com/file/CFVmaTZ621FgTJHsr20sCG/Giphy-Quiz-(YP)?node-id=0%3A1&t=AyyunAewwqNoVniU-1)

## **Описание приложения**

-  Одностраничное приложение с возможностью просматривать случайные гифки и скачивать их к себе на телефон. 

## **Функциональные требования**

На экране должны отображаться следующие элементы: 
- Верхний стек, в котором содержится два UILabel — "Гифка:" и "Счетчик текущей гифки"
- Изображение гифки UIIMageView
- Нижний стек c двумя кнопками лайк и дизлайк
При нажатии на кнопкку лайка должен происходить переход для отображения следующей рандомной гифки, гифка скачивается к себе на устройство
При нажатии на кнопку дизлайка должен происходить переход для отображения следующей рандомной гифки

## **Технические требования**

- Приложение должно поддерживать устройства iPhone с iOS 13, предусмотрен только портретный режим.
- Элементы интерфейса адаптируются под разрешения экранов больших iPhone (13, 13 Pro Max) — верстка под SE и iPad не предусмотрена.
- Экраны соответствует макету — использованы верные шрифты нужных размеров, все надписи находятся на нужном месте, расположение всех элементов, размеры кнопок и отступы — точно такие же, как в макете.

## **Дополнительно**
Не стесняйтесь изменять или эксперементировать с структурой файлов и папок. Используется маттерн MVP
Так же приветствуется создание дополнительных фабрик и объектов при необходимости

## **Паттерн MVP**
![схема MVP](https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/MVP-Pattern.png/274px-MVP-Pattern.png)
 - Модель (англ. Model) — данные для отображения;
 - Вид (англ. View) — реализует отображение данных (из Модели), обращается к Presenter за обновлениями, перенаправляет события от пользователя в Presenter;
 - Представитель (англ. Presenter) — реализует взаимодействие между Моделью и Видом и содержит в себе всю логику представления данных о предметной области; при необходимости получает данные из хранилища и преобразует для отображения во View.

