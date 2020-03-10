//
//  ViewController.swift
//  WebSocketClient
//
//  Created by TJOEUN-304 on 2020/03/10.
//  Copyright © 2020 TJOEUN-304. All rights reserved.
//

import UIKit
import Starscream //웹소켓 외부 프로젝트 import

class ViewController: UIViewController, WebSocketDelegate {
    
    //각종 이벤트를 처리하는 메서드
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            //isConnected = true
            area.text += "접속성공\n"
            
        case .disconnected(let reason, let code):
            //isConnected = false
             area.text += "연결종료\n"
            
        case .text(let string):
            print("서버의 메시지: \(string)")
            //문자열 줄바꿈 및 누적!
            area.text += "\(string)\n"
            
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viablityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled: break
            //isConnected = false
        case .error(let error): break
            //isConnected = false
            //handleError(error)
        }
    }

    @IBOutlet weak var t_ip: UITextField!
    @IBOutlet weak var area: UITextView!
    @IBOutlet weak var t_input: UITextField!
    
    //웹소켓 객체 선언
    var socket:WebSocket!
    
    //접속 버튼
    @IBAction func btnClick1(_ sender: Any) {
        connectServer()
    }
    
    //전송 버튼
    @IBAction func btnClick2(_ sender: Any) {
        send()
    }
    
    //접속 메서드 정의
    func connectServer(){
       let urlRequest =  URLRequest(url:URL(string: "ws://192.168.100.2:7777")!)
        socket = WebSocket(request: urlRequest)
        socket.delegate = self
        socket.connect() //접속!
    }
    
    //메시지 전송 메서드 정의
    func send(){
        socket.write(string: t_input.text!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
