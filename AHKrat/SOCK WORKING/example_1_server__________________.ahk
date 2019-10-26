#Include AHKsock.ahk
/*! TheGood
    AHKsock - A simple AHK implementation of Winsock.
    AHKsock Example 1 - Simple Scenario
    http://www.autohotkey.com/forum/viewtopic.php?p=355775
    Last updated: August 24th, 2010
    
    In this simple scenario:
        1.  First, the server starts listening for clients on port 27015.
        2.  As soon as the client is started, it attempts to connect to the server.
        3.  As soon as the connection is established, the CONNECTED/ACCEPTED event is fired on both client and server.
        4.  Once the server receives the SEND event, it will send some binary data to the client.
        5.  Once the binary data is successfully sent, the server will initiate shutdown.
        6.  The client receives a RECEIVED event with the data sent by the server.
        7.  As soon as the client receives the DISCONNECT event, it exits.
        8.  The server receives a DISCONNECT event as well, meaning that shutdown is complete.
        9.  The server goes back to listening for clients on port 27015.
        10. The client can be started up again to have the same process repeat.
    
    This example does not have a GUI, but uses OutputDebug to output its data. See the command's docs for more details.
    If the server isn't running on the same computer, change sServer to the IP address or hostname of the server.
*/
    ;Needed if AHKsock isn't in one of your lib folders
    ;#Include %A_ScriptDir%\AHKsock.ahk
    

    
    ;Create the binary data which will be sent to any client that connects.
    ;It is just an example; you can change it if you want.
    VarSetCapacity(bData, bDataLength := 1, 0x99)
    ;Listen on port 27015
AHKsock_Listen(27015, "Send")


Return
F1::
    VarSetCapacity(bData, bDataLength := 1, 0x01)
    InputBox, bDataLength,,,,120,100
return




Send(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bRecvData = 0, bRecvDataLength = 0) {
    Global bData, bDataLength
    Static bDataSent, bConnected
    
    If (sEvent = "ACCEPTED") {
        OutputDebug, % "Server - A client connected!"
        
        If bConnected {
            OutputDebug, % "Server - Disconnected new client because we are still serving a previous client."
            AHKsock_Close(iSocket)
            
        ;If we weren't connected before, we are now!
        } Else bConnected := True
        
    } Else If (sEvent = "DISCONNECTED") {
        OutputDebug, % "Server - The client disconnected. Going back to listening..."
        bConnected := False
        
    } Else If (sEvent = "SEND") {
        bDataSent := 0
        Loop {
            
            ;Try to send the data
            If ((i := AHKsock_Send(iSocket, &bData + bDataSent, bDataLength - bDataSent)) < 0) {
                
                ;Check if we received WSAEWOULDBLOCK.
                If (i = -2) {
                    ;That's ok. We can leave and we'll keep sending from
                    ;where we left off the next time we get the SEND event.
                    Return
                    
                ;Something bad has happened with AHKsock_Send
                } Else OutputDebug, % "Server - AHKsock_Send failed with return value = " i " and ErrorLevel = " ErrorLevel
                
            ;We were able to send bytes!
            } Else OutputDebug, % "Server - Sent " i " bytes!"
            
            ;Check if everything was sent
            If (i < bDataLength - bDataSent)
                bDataSent += i ;Advance the offset so that at the next iteration, we'll start sending from where we left off
            Else Break ;We're done
        }
        
        ;Reset the static variable
        bDataSent := 0
        
        OutputDebug, % "Server - Closing the client connection now..."
        If (i := AHKsock_Close(iSocket))
            OutputDebug, % "Server - The shutdown() call failed. ErrorLevel = " ErrorLevel
        
        ;Reset the connection status so that we can accept new clients.
        ;We don't need to actually wait for the client we just served to disconnect because as long as we are done sending
        ;data to it, we can use the bDataSent variable to track the data sending progress with another client!
        bConnected := False
    }
}

