# bindgen experiment

This is a very limited subset of something I using to test this
https://github.com/Papierkorb/bindgen

## Current problems

First, this does not work because of this:


```
# make

# crystal src/binding_test.cr 
In src/storage.cr:97:23

 97 | mount_options : std::vector<std::string>
                       ^
Error: expecting token 'CONST', not 'std'
```

Second, if I remove the line in `SimpleEtcFstab.h` declaring `mount_options`
(just to move forward). I get this:

```
# make

# crystal src/binding_test.cr 
Showing last frame. Use --error-trace for full trace.

In /usr/share/crystal/src/indexable.cr:26:16

 26 | abstract def unsafe_fetch(index : Int)
                   ^-----------
Error: abstract `def Indexable(T)#unsafe_fetch(index : Int)` must be implemented by Storage::Container_std__vector_std__string
```

Last but not least, if I manually edit `src/storage.cr` and change this:

```crystal
def unsafe_fetch(index : Int32) : String
```

into this:
```crystal
def unsafe_fetch(index : Int) : String
```

I get this:

```
# crystal src/binding_test.cr 
Showing last frame. Use --error-trace for full trace.

In src/storage.cr:111:5

 111 | @unwrap = result
       ^------
Error: instance variable '@unwrap' of Storage::SimpleEtcFstabEntry must be Storage::Binding::SimpleEtcFstabEntry, not Pointer(Storage::Binding::SimpleEtcFstabEntry)
```

That's the point in which I gave up.
