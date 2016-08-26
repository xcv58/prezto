Lazy Load
=========

Provides lazy_load() to lazy load functionality.

Usage
-----

***Please include lazy-load in zpreztorc before any module you want to use lazy load function***

```shell
lazy_load load_func command1 command2 command3 ...
```

The lazy_load() will:

1. create a lazy function to wrap your load_func.
2. alias all the commands you provide by following arugments to the lazy function and comamnd itself

So that when you type in any of your trigger commands, the lazy function is called. It will:

1. unset the lazy function itself
2. unalias all commands
3. eval your load func
4. unset your load func
5. eval the arguments ($@) you typed in, so the command will run as normal

