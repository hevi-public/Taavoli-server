import Fluent
import Vapor

final class Drawing: Model, Content {
    static let schema = "drawings"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "data")
    var data: Data

    init() { }

    init(id: UUID? = nil, title: String, data: Data) {
        self.id = id
        self.title = title
        self.data = data
    }
}
