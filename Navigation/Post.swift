
import Foundation

public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public static func makePosts() -> [Post] {
        var post = [Post]()
        post.append(Post(author: "User1", description: "Сотрудники лаборатории DxOMark опубликовали результаты тестирования камеры нового iPhone SE. Смартфон оснащается одной камерой на 12 Мп, но поддерживает все фирменные функции, такие как Deep Fusion, Smart HDR и Photographic Styles. Специалисты рассказали о сильных и слабых сторонах этого аппарата при съёмке фото и видео.", image: "post2image", likes: 22, views: 33))
        post.append(Post(author: "User2", description: "Toyota считает, что водородное топливо может быть хорошей альтернативой электричеству, когда речь заходит об экологически чистых источниках питания. В компании придумали способ хранения и доставки этого взрывоопасного источника энергии, разработав специальные водородные картриджи. ", image: "post1image", likes: 11, views: 44))
        post.append(Post(author: "User3", description: "Apple M2: больше мощи при прежнем энергопотреблении. Спустя два года после презентации своего революционного компьютерного процессора M1 компания Apple презентовала M2. Новый чип выполнен по 5-нанометровому процессу второго поколения и обеспечивает заметный скачок производительности.", image: "post3image", likes: 20, views: 40))
        post.append(Post(author: "User4", description: "Apple представила iOS 16: кастомизация, отложенные платежи и новый CarPlay. В рамках конференции для разработчиков WWDC 2022 компания Apple представила новую версию фирменной операционной системы для смартфонов iOS 16. Одним из главных нововведений стал полностью переработанный экран блокировки, но не обошлось и без других интересных изменений.", image: "post4image", likes: 66, views: 777))
        return post
    }
}








