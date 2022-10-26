//
//  TransportController.swift
//  Canary
//
//  Created by Mafalda on 1/27/21.
//

import Foundation
import Logging

import Net
import ReplicantSwift
import ShadowSwift
import Starbridge
import TransmissionTransport
import Transport

class TransportController
{
    let transportQueue = DispatchQueue(label: "TransportQueue")
    var transport: Transport
    var connectionCompletion: ((Connection?) -> Void)?
    var connection: Connection?
    
    init(transport: Transport, log: Logger)
    {
        self.transport = transport
    }
            
    func startTransport(completionHandler: @escaping (Connection?) -> Void)
    {
        connectionCompletion = completionHandler
        
        switch transport.type
        {
            case .replicant:
                launchReplicant()
            case .shadowsocks:
                launchShadow()
            case .starbridge:
                launchStarbridge()
        }
    }
    
    func handleStateUpdate(_ newState: NWConnection.State)
    {
        guard let completion = connectionCompletion
        else
        {
            print("Unable to establish transport connection, our completion handler is nil.")
            return
        }
        
        switch newState
        {
            case .ready:
                completion(connection)
            case .cancelled:
                completion(nil)
            case .failed(let error):
                print("Transport connection failed: \(error)")
                completion(nil)
            default:
                return
        }
    }
    
    func launchShadow()
    {
        switch transport.config
        {
            case .shadowsocksConfig(let shadowConfig):
                let shadowFactory = ShadowConnectionFactory(config: shadowConfig, logger: uiLogger)
                                
                guard var shadowConnection = shadowFactory.connect(using: .tcp)
                else
                {
                    uiLogger.error("Failed to create a ShadowSocks connection.")
                    return
                }
                
                connection = shadowConnection
                shadowConnection.stateUpdateHandler = self.handleStateUpdate
                shadowConnection.start(queue: transportQueue)
                
            default:
                uiLogger.error("Invalid ShadowSocks config.")
                return
        }
    }
    
    func launchStarbridge()
    {
        switch transport.config
        {
            case .starbridgeConfig(let starbridgeConfig):
                let starburstConfig = StarburstConfig.SMTPClient
                let starbridge = Starbridge(logger: uiLogger, config: starburstConfig)
                
                do
                {
                    let starbridgeConnection = try starbridge.connect(config: starbridgeConfig)
                    let starbridgeTransportConnection = TransmissionTransport.TransmissionToTransportConnection({return starbridgeConnection})
                    self.connection = starbridgeTransportConnection
                    starbridgeTransportConnection.stateUpdateHandler = self.handleStateUpdate
                    starbridgeTransportConnection.start(queue: transportQueue)
                }
                catch
                {
                    uiLogger.error("Canary.TransportController: Failed to create a Starbridge connection: \(error)")
                    handleStateUpdate(.failed(NWError.posix(.ECONNREFUSED)))
                }
                
            default:
                uiLogger.error("Canary.TransportController: Invalid Starbridge config.")
                return
        }
    }
    
    func launchReplicant()
    {
        print("Replicant is not currently supported.")
    }
}
