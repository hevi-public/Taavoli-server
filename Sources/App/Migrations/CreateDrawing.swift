import Fluent

struct CreateDrawing: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drawings")
            .id()
            .field("title", .string, .required)
            .field("data", .data, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("drawings").delete()
    }
}
