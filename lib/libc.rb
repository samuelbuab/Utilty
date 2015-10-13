# encoding
require 'ffi'

module LibC
  extend FFI::Library
  ffi_lib FFI::Library::LIBC
  
  attach_function :malloc, [:size_t], :pointer
  attach_function :calloc, [:size_t, :size_t], :pointer
  attach_function :realloc, [:pointer, :size_t], :pointer
  attach_function :free, [:pointer], :void
  
  attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
  attach_function :memset, [:pointer, :int, :size_t], :pointer  
end
