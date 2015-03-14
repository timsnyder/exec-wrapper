**exec-wrapper** is a simple tool that creates setuid-wrappers for scripts and other executables. It can be used to allow users to run scripts with temporarily elevated privileges. Just set setuid-bit on script does not work, because OS isn’t run script itself, but it run an interpreter, which isn’t setuid.  Exec-wrapper creates small genuine executable (not script) with setuid or setgid bit that simply executes target script.

**exec-wrapper** also can be used if you want to transparently run programs with elevated priveleges but without using tools like su(1) or sudo(8) and without changing file mode bits on system executables.

For usage details see _man 8 exec-wrapper_.

// Sorry for my terrible english.