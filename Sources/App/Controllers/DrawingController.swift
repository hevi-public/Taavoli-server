import Fluent
import Vapor

struct DrawingController {
    func index(req: Request) throws -> EventLoopFuture<[Drawing]> {
        return Drawing.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Drawing> {
        let drawing = try req.content.decode(Drawing.self)
        return drawing.save(on: req.db).map { drawing }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Drawing.find(req.parameters.get("drawingID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
