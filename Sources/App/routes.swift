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
    app.get("drawings", use: drawingController.index)
    app.post("drawings", use: drawingController.create)
    app.delete("drawings", ":drawingID", use: drawingController.delete)
    
    app.ws.build(.drawingWebSocket).at("drawing").serve()
    
    app.logger.logLevel = .debug
    
}
