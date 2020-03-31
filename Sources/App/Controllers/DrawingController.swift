import Fluent
import Vapor

struct DrawingController {
    func index(req: Request) throws -> EventLoopFuture<[Drawing]> {
        return Drawing.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Drawing> {
            let drawing = try req.content.decode(Drawing.self)
            
            
    //        .flatMap { $0.delete(on: req.db) }
    //        .transform(to: .ok)
            
    //        if let updatable = Drawing.find(drawing.id, on: req.db).first() {
    //            updatable.title = drawing.title
    //            updatable.data = drawing.data
    //            drawing.update(on: req.db)
    //        } else {
                return drawing.save(on: req.db).map { drawing }
    //        }
        }
    
    func update(req: Request) throws -> EventLoopFuture<Drawing> {
            let drawingId = req.parameters.get("drawingID")
            
            
    //        .flatMap { $0.delete(on: req.db) }
    //        .transform(to: .ok)
            
    //        if let updatable = Drawing.find(drawing.id, on: req.db).first() {
    //            updatable.title = drawing.title
    //            updatable.data = drawing.data
    //            drawing.update(on: req.db)
    //        } else {
                return drawing.save(on: req.db).map { drawing }
    //        }
        }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        print("")
        print("----")
        print(req)
        print("----")
        print("")
        
        return Drawing.find(req.parameters.get("drawingID"), on: req.db)
            .unwrap(or: Abort(.unauthorized))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
