# zombie_processes
How To Kill Zombie Processes on Linux
Also known as “defunct” or “dead” process – In simple words, a Zombie process is one that is dead but is present in the system’s process table. Ideally, it should have been cleaned from the process table once it completed its job/execution but for some reason, its parent process didn’t clean it up properly after the execution.
Now practically you can’t kill a Zombie because it is already dead! What can be done is to notify its parent process explicitly so that it can retry to read the child (dead) process’s status and eventually clean them from the process table. 
In a just (Linux) world, a process notifies its parent process once it has completed its execution and has exited. Then the parent process would remove the process from process table. At this step, if the parent process is unable to read the process status from its child (the completed process), it won’t be able to remove the process from memory and thus the process being dead still continues to exist in the process table – hence, called a Zombie!
In order to kill a Zombie process, we need to identify it first. The following command can be used to find zombie processes:
```
$ ps aux | egrep "Z|defunct"
```
Z in the STAT column and/or [defunct] in the last (COMMAND) column of the output would identify a Zombie process.

The following command can be used to find the parent process ID (PID):
```
$ ps -o ppid= <Child PID>
```
Once you have the Zombie’s parent process ID, you can use the following command to send a SIGCHLD signal to the parent process:
```
$ kill -s SIGCHLD <Parent PID>
```
The following command can be used to kill its parent process:
```
$ kill -9 <Parent PID>
```
