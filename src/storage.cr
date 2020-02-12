module Storage
  
  # Native bindings.  Mostly generated.
  lib Binding
    # Container for string data.
    struct CrystalString
      ptr : LibC::Char*
      size : LibC::Int
    end
  
    # Container for a `Proc`
    struct CrystalProc
      ptr : Void*
      context : Void*
    end
  
    # Container for raw memory-data.  The `ptr` could be anything.
    struct CrystalSlice
      ptr : Void*
      size : LibC::Int
    end
  end
  
  # Helpers for bindings.  Required.
  module BindgenHelper
    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    def self.wrap_proc(proc : Proc)
      Binding::CrystalProc.new(
        ptr: proc.pointer,
        context: proc.closure_data,
      )
    end
  
    # Wraps `Proc` to a `Binding::CrystalProc`, which can then passed on to C++.
    # `Nil` version, returns a null-proc.
    def self.wrap_proc(nothing : Nil)
      Binding::CrystalProc.new(
        ptr: Pointer(Void).null,
        context: Pointer(Void).null,
      )
    end
  
    # Wraps a *list* into a container *wrapper*, if it's not already one.
    macro wrap_container(wrapper, list)
      %instance = {{ list }}
      if %instance.is_a?({{ wrapper }})
        %instance
      else
        {{wrapper}}.new.concat(%instance)
      end
    end
  
    # Wrapper for an instantiated, sequential container type.
    #
    # This offers (almost) all read-only methods known from `Array`.
    # Additionally, there's `#<<`.  Other than that, the container type is not
    # meant to be used for storage, but for data transmission between the C++
    # and the Crystal world.  Don't let that discourage you though.
    abstract class SequentialContainer(T)
      include Indexable(T)
  
      # `#unsafe_at` and `#size` will be implemented by the wrapper class.
  
      # Adds an element at the end.  Implemented by the wrapper.
      abstract def push(value)
  
      # Adds *element* at the end of the container.
      def <<(value : T) : self
        push(value)
        self
      end
  
      # Adds all *elements* at the end of the container, retaining their order.
      def concat(values : Enumerable(T)) : self
        values.each{|v| push(v)}
        self
      end
  
      def to_s(io)
        to_a.to_s(io)
      end
  
      def inspect(io)
        io << "<Wrapped "
        to_a.inspect(io)
        io << ">"
      end
    end
  end
  
  @[Link(ldflags: "#{__DIR__}/../tmp/storage.o -lstdc++")]
  lib Binding
    struct SimpleEtcFstabEntry
      device : CrystalString
      mount_point : CrystalString
      fs_type : FsType
      fs_freq : Int32
      fs_passno : Int32
    end
    fun bg_storage__SimpleEtcFstabEntry__CONSTRUCT_() : SimpleEtcFstabEntry*
    fun bg_Container_std__vector_std__string__CONSTRUCT_() : Void*
    fun bg_Container_std__vector_std__string_at_int(_self_ : Void*, index : Int32) : CrystalString
    fun bg_Container_std__vector_std__string_push_back_std__string(_self_ : Void*, value : CrystalString) : Void
    fun bg_Container_std__vector_std__string_size_(_self_ : Void*) : Int32
  end
  class SimpleEtcFstabEntry
    @unwrap : Binding::SimpleEtcFstabEntry
    
    def initialize()
      result = Binding.bg_storage__SimpleEtcFstabEntry__CONSTRUCT_()
    @unwrap = result
    end
    
    def to_unsafe
      pointerof(@unwrap)
    end
    def initialize(unwrap : Binding::SimpleEtcFstabEntry*)
      result = unwrap
    @unwrap = result
    end
    
  end
  class Container_std__vector_std__string < BindgenHelper::SequentialContainer(String)
    @unwrap : Void*
    
    def initialize()
      result = Binding.bg_Container_std__vector_std__string__CONSTRUCT_()
    @unwrap = result
    end
    
    def unsafe_fetch(index : Int) : String
      String.new(Binding.bg_Container_std__vector_std__string_at_int(self, index).ptr, Binding.bg_Container_std__vector_std__string_at_int(self, index).size)
    end
    
    def push(value : String) : Void
      Binding.bg_Container_std__vector_std__string_push_back_std__string(self, Binding::CrystalString.new(ptr: value.to_unsafe, size: value.bytesize))
    end
    
    def size() : Int32
      Binding.bg_Container_std__vector_std__string_size_(self)
    end
    
    def to_unsafe
      @unwrap
    end
    def initialize(unwrap : Void*)
      result = unwrap
    @unwrap = result
    end
    
  end
  enum FsType : Int32
    Unknown = 0
    Auto = 1
    Reiserfs = 2
    Ext2 = 3
    Ext3 = 4
    Ext4 = 5
    Btrfs = 6
    Vfat = 7
    Xfs = 8
    Jfs = 9
    Hfs = 10
    Ntfs = 11
    Swap = 12
    Hfsplus = 13
    Nfs = 14
    Nfs4 = 15
    Tmpfs = 16
    Iso9660 = 17
    Udf = 18
    Nilfs2 = 19
    Minix = 20
    Ntfs3g = 21
    F2fs = 22
    Exfat = 23
    Bitlocker = 24
  end
end
