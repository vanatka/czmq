################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

module CZMQ
  module FFI

    # working with multipart messages
    class Zmsg
      class DestroyedError < RuntimeError; end

      # Boilerplate for self pointer, initializer, and finalizer
      class << self
        alias :__new :new
      end
      def initialize ptr, finalize=true
        @ptr = ptr
        if @ptr.null?
          @ptr = nil # Remove null pointers so we don't have to test for them.
        elsif finalize
          @finalizer = self.class.create_finalizer_for @ptr
          ObjectSpace.define_finalizer self, @finalizer
        end
      end
      def self.create_finalizer_for ptr
        Proc.new do
          ptr_ptr = ::FFI::MemoryPointer.new :pointer
          ptr_ptr.write_pointer ptr
          ::CZMQ::FFI.zmsg_destroy ptr_ptr
        end
      end
      def null?
        !@ptr or @ptr.null?
      end
      # Return internal pointer
      def __ptr
        raise DestroyedError unless @ptr
        @ptr
      end
      # So external Libraries can just pass the Object to a FFI function which expects a :pointer
      alias_method :to_ptr, :__ptr
      # Nullify internal pointer and return pointer pointer
      def __ptr_give_ref
        raise DestroyedError unless @ptr
        ptr_ptr = ::FFI::MemoryPointer.new :pointer
        ptr_ptr.write_pointer @ptr
        ObjectSpace.undefine_finalizer self if @finalizer
        @finalizer = nil
        @ptr = nil
        ptr_ptr
      end

      # Create a new empty message object
      def self.new()
        ptr = ::CZMQ::FFI.zmsg_new()
        __new ptr
      end

      # Destroy a message object and all frames it contains
      def destroy()
        return unless @ptr
        self_p = __ptr_give_ref
        result = ::CZMQ::FFI.zmsg_destroy(self_p)
        result
      end

      # Receive message from socket, returns zmsg_t object or NULL if the recv   
      # was interrupted. Does a blocking recv. If you want to not block then use 
      # the zloop class or zmsg_recv_nowait or zmq_poll to check for socket input
      # before receiving.                                                        
      def self.recv(source)
        result = ::CZMQ::FFI.zmsg_recv(source)
        result = Zmsg.__new result, true
        result
      end

      # Send message to destination socket, and destroy the message after sending
      # it successfully. If the message has no frames, sends nothing but destroys
      # the message anyhow. Nullifies the caller's reference to the message (as  
      # it is a destructor).                                                     
      def self.send(self_p, dest)
        self_p = self_p.__ptr_give_ref
        result = ::CZMQ::FFI.zmsg_send(self_p, dest)
        result
      end

      # Send message to destination socket as part of a multipart sequence, and 
      # destroy the message after sending it successfully. Note that after a    
      # zmsg_sendm, you must call zmsg_send or another method that sends a final
      # message part. If the message has no frames, sends nothing but destroys  
      # the message anyhow. Nullifies the caller's reference to the message (as 
      # it is a destructor).                                                    
      def self.sendm(self_p, dest)
        self_p = self_p.__ptr_give_ref
        result = ::CZMQ::FFI.zmsg_sendm(self_p, dest)
        result
      end

      # Return size of message, i.e. number of frames (0 or more).
      def size()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_size(self_p)
        result
      end

      # Return total size of all frames in message.
      def content_size()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_content_size(self_p)
        result
      end

      # Return message routing ID, if the message came from a ZMQ_SERVER socket.
      # Else returns zero.                                                      
      def routing_id()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_routing_id(self_p)
        result
      end

      # Set routing ID on message. This is used if/when the message is sent to a
      # ZMQ_SERVER socket.                                                      
      def set_routing_id(routing_id)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_set_routing_id(self_p, routing_id)
        result
      end

      # Push frame to the front of the message, i.e. before all other frames.  
      # Message takes ownership of frame, will destroy it when message is sent.
      # Returns 0 on success, -1 on error. Deprecates zmsg_push, which did not 
      # nullify the caller's frame reference.                                  
      def prepend(frame_p)
        raise DestroyedError unless @ptr
        self_p = @ptr
        frame_p = frame_p.__ptr_give_ref
        result = ::CZMQ::FFI.zmsg_prepend(self_p, frame_p)
        result
      end

      # Add frame to the end of the message, i.e. after all other frames.      
      # Message takes ownership of frame, will destroy it when message is sent.
      # Returns 0 on success. Deprecates zmsg_add, which did not nullify the   
      # caller's frame reference.                                              
      def append(frame_p)
        raise DestroyedError unless @ptr
        self_p = @ptr
        frame_p = frame_p.__ptr_give_ref
        result = ::CZMQ::FFI.zmsg_append(self_p, frame_p)
        result
      end

      # Remove first frame from message, if any. Returns frame, or NULL.
      def pop()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_pop(self_p)
        result = Zframe.__new result, true
        result
      end

      # Push block of memory to front of message, as a new frame.
      # Returns 0 on success, -1 on error.                       
      def pushmem(src, size)
        raise DestroyedError unless @ptr
        self_p = @ptr
        size = Integer(size)
        result = ::CZMQ::FFI.zmsg_pushmem(self_p, src, size)
        result
      end

      # Add block of memory to the end of the message, as a new frame.
      # Returns 0 on success, -1 on error.                            
      def addmem(src, size)
        raise DestroyedError unless @ptr
        self_p = @ptr
        size = Integer(size)
        result = ::CZMQ::FFI.zmsg_addmem(self_p, src, size)
        result
      end

      # Push string as new frame to front of message.
      # Returns 0 on success, -1 on error.           
      def pushstr(string)
        raise DestroyedError unless @ptr
        self_p = @ptr
        string = String(string)
        result = ::CZMQ::FFI.zmsg_pushstr(self_p, string)
        result
      end

      # Push string as new frame to end of message.
      # Returns 0 on success, -1 on error.         
      def addstr(string)
        raise DestroyedError unless @ptr
        self_p = @ptr
        string = String(string)
        result = ::CZMQ::FFI.zmsg_addstr(self_p, string)
        result
      end

      # Push formatted string as new frame to front of message.
      # Returns 0 on success, -1 on error.                     
      def pushstrf(format, *args)
        raise DestroyedError unless @ptr
        self_p = @ptr
        format = String(format)
        result = ::CZMQ::FFI.zmsg_pushstrf(self_p, format, *args)
        result
      end

      # Push formatted string as new frame to end of message.
      # Returns 0 on success, -1 on error.                   
      def addstrf(format, *args)
        raise DestroyedError unless @ptr
        self_p = @ptr
        format = String(format)
        result = ::CZMQ::FFI.zmsg_addstrf(self_p, format, *args)
        result
      end

      # Pop frame off front of message, return as fresh string. If there were
      # no more frames in the message, returns NULL.                         
      def popstr()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_popstr(self_p)
        result = ::FFI::AutoPointer.new(result, LibC.method(:free))
        result
      end

      # Push encoded message as a new frame. Message takes ownership of    
      # submessage, so the original is destroyed in this call. Returns 0 on
      # success, -1 on error.                                              
      def addmsg(msg_p)
        raise DestroyedError unless @ptr
        self_p = @ptr
        msg_p = msg_p.__ptr_give_ref
        result = ::CZMQ::FFI.zmsg_addmsg(self_p, msg_p)
        result
      end

      # Remove first submessage from message, if any. Returns zmsg_t, or NULL if
      # decoding was not succesfull.                                            
      def popmsg()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_popmsg(self_p)
        result = Zmsg.__new result, true
        result
      end

      # Remove specified frame from list, if present. Does not destroy frame.
      def remove(frame)
        raise DestroyedError unless @ptr
        self_p = @ptr
        frame = frame.__ptr if frame
        result = ::CZMQ::FFI.zmsg_remove(self_p, frame)
        result
      end

      # Set cursor to first frame in message. Returns frame, or NULL, if the
      # message is empty. Use this to navigate the frames as a list.        
      def first()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_first(self_p)
        result = Zframe.__new result, false
        result
      end

      # Return the next frame. If there are no more frames, returns NULL. To move
      # to the first frame call zmsg_first(). Advances the cursor.               
      def next()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_next(self_p)
        result = Zframe.__new result, false
        result
      end

      # Return the last frame. If there are no frames, returns NULL.
      def last()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_last(self_p)
        result = Zframe.__new result, false
        result
      end

      # Save message to an open file, return 0 if OK, else -1. The message is  
      # saved as a series of frames, each with length and data. Note that the  
      # file is NOT guaranteed to be portable between operating systems, not   
      # versions of CZMQ. The file format is at present undocumented and liable
      # to arbitrary change.                                                   
      def save(file)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_save(self_p, file)
        result
      end

      # Load/append an open file into message, create new message if
      # null message provided. Returns NULL if the message could not
      # be loaded.                                                  
      def self.load(self_, file)
        self_ = self_.__ptr if self_
        result = ::CZMQ::FFI.zmsg_load(self_, file)
        result = Zmsg.__new result, true
        result
      end

      # Serialize multipart message to a single buffer. Use this method to send  
      # structured messages across transports that do not support multipart data.
      # Allocates and returns a new buffer containing the serialized message.    
      # To decode a serialized message buffer, use zmsg_decode ().               
      def encode(buffer)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_encode(self_p, buffer)
        result
      end

      # Decodes a serialized message buffer created by zmsg_encode () and returns
      # a new zmsg_t object. Returns NULL if the buffer was badly formatted or   
      # there was insufficient memory to work.                                   
      def self.decode(buffer, buffer_size)
        buffer_size = Integer(buffer_size)
        result = ::CZMQ::FFI.zmsg_decode(buffer, buffer_size)
        result = Zmsg.__new result, true
        result
      end

      # Create copy of message, as new message object. Returns a fresh zmsg_t
      # object. If message is null, or memory was exhausted, returns null.   
      def dup()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_dup(self_p)
        result = Zmsg.__new result, true
        result
      end

      # Send message to zsys log sink (may be stdout, or system facility as
      # configured by zsys_set_logstream).                                 
      def print()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_print(self_p)
        result
      end

      # Return true if the two messages have the same number of frames and each  
      # frame in the first message is identical to the corresponding frame in the
      # other message. As with zframe_eq, return false if either message is NULL.
      def eq(other)
        raise DestroyedError unless @ptr
        self_p = @ptr
        other = other.__ptr if other
        result = ::CZMQ::FFI.zmsg_eq(self_p, other)
        result
      end

      # Generate a signal message encoding the given status. A signal is a short
      # message carrying a 1-byte success/failure code (by convention, 0 means  
      # OK). Signals are encoded to be distinguishable from "normal" messages.  
      def self.new_signal(status)
        status = Integer(status)
        result = ::CZMQ::FFI.zmsg_new_signal(status)
        result = Zmsg.__new result, true
        result
      end

      # Return signal value, 0 or greater, if message is a signal, -1 if not.
      def signal()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zmsg_signal(self_p)
        result
      end

      # Probe the supplied object, and report if it looks like a zmsg_t.
      def self.is(self_)
        result = ::CZMQ::FFI.zmsg_is(self_)
        result
      end

      # Self test of this class
      def self.test(verbose)
        verbose = !(0==verbose||!verbose) # boolean
        result = ::CZMQ::FFI.zmsg_test(verbose)
        result
      end
    end
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
