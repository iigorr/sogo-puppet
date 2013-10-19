$username = "igor"

include system-base
include dev-base
include sogo


Class["system-base"] -> Class["dev-base"] -> Class["sogo"]