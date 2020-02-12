require "./storage"

# entries = Storage.read_simple_etc_fstab("./fstab")

entry1 = Storage::SimpleEtcFstabEntry.new
entry1.device = "/dev/sda"
puts entry1.device
puts entry1.mount_options

# entries.each do |entry|
#   puts entry.device
# end
