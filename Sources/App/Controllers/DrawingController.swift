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
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let drawingRequest = try req.content.decode(Drawing.self)
        
        let drawingFuture = Drawing.find(drawingRequest.id, on: req.db)
        
        drawingFuture.whenSuccess { drawing in
            guard let drawing = drawing else { return }
            
            drawing.title = drawingRequest.title
            drawing.data = drawingRequest.data
            drawing.update(on: req.db)
        }
        return drawingFuture.transform(to: .ok)
        
        //        print("--------->>>>>")
        //        print(drawing)
        //        print("--------->>>>>")
        //        return drawing.update(on: req.db)
        //            .transform(to: .ok)
        //
        
        //        updatable.title = drawing.title
        //        updatable.data = drawing.data
        //        updatable.update(on: req.db)
        
        
        //            .unwrap(or: Abort(.notFound))
        //            .flatMap {
        //                $0.title = drawing.title
        //                $0.data = drawing.data
        //                $0.update(on: req.db)
        //            }
        //            .transform(to: .ok)
        
        
        
        //        return Drawing.find(drawing.id, on: req.db)
        //            .unwrap(or:
        //                drawing.save(on: req.db).map { drawing }
        //        )
        //            .flatMap {
        //                $0.title = drawing.title
        //                $0.data = drawing.data
        //                $0.update(on: req.db)
        //        }
        //        .transform(to: .ok)
        
    }
    
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        print("")
        print("----")
        print(req)
        print("----")
        print("")
        
        return Drawing.find(req.parameters.get("drawingID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
