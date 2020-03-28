//
//  DrawingWebsocket.swift
//  App
//
//  Created by Hevi on 28/03/2020.
//

import Foundation
import WS

class DrawingWebSocket: ClassicObserver {
    override func on(open client: AnyClient) {
        super.on(open: client)
    }
    override func on(close client: AnyClient) {
        super.on(close: client)
    }

    override func on(text: String, client: AnyClient) {
        super.on(text: text, client: client)
    }
    
    override func on(data: Data, client: AnyClient) {
        super.on(data: data, client: client)
        print("data received")
        client.broadcast.send(data: data)
    }
    
    
//    override func on(ping: String, client: AnyClient) {}
//    override func on(pong: String, client: AnyClient) {}
//    override func on(byteBuffer: String, client: AnyClient) {}
    
    
    
}

extension WSID {
    static var drawingWebSocket: WSID<DrawingWebSocket> { .init() }
}
