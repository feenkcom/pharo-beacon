RestartingStreamLogger extends CustomStreamLogger to be able to automatically open and close the stream with the session.

The default operation is to flush the stream after each message.  This can be turned off.

Public API and Key Messages

- stdout 		Set the stream to stdout
- flush: 		Flag whether to flush the stream after every message

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
		flush:				<Boolean>		Flag whether to flush the stream after every message
		streamBlock:		<BlockClosure>	Stream creation block


!!!Implementation Points