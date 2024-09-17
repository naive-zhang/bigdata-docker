 kill -9 $(jps | grep -v grep | grep 'RunJar' | awk '{print $1}')
