# MulticastTest

This is a small demo that shows how to set up UDP multicast and broadcast listeners.

The app uses port 49998 for broadcast and 49999 for multicast.

## Usage

This is a supervised OTP app which automatically starts up two listeners.

Start up the app with `iex -S mix`, and you should see messages indicating that the listeners are starting.

Then, in another terminal, you can use a tool like netcat to send multicast messages (depending on your OS and netcat distribution, you may also be able to send UDP broadcast messages)

`nc -u 224.1.1.1 49999`

I had to install/use socat to send broadcast packets on OSX  
`brew install socat`

Then, send a broadcast to 49998:  
`socat STDIO UDP4-DATAGRAM:255.255.255.255:49998,broadcast`

or, if you don't want to blast the entire network (substitute your actual subnet):  
`socat STDIO UDP4-DATAGRAM:192.168.0.255:49998,broadcast`
