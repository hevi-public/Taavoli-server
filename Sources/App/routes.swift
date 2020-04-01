import Fluent
import Vapor
import WS

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let drawingController = DrawingController()
    app.get("drawing", use: drawingController.index)
    app.get("drawing", ":drawingID", use: drawingController.get)
    app.post("drawing", use: drawingController.create)
    app.put("drawing", use: drawingController.update)
    app.delete("drawing", ":drawingID", use: drawingController.delete)
    
    app.ws.build(.drawingWebSocket).at("ws/drawing").serve()
    
    app.logger.logLevel = .debug
    
}
