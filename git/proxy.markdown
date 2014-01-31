## Setting up the proxies

As stated above we're in a unique place at web where we need two proxies to perform our duties as
dilligent developers. Luckily with the latest version of Git that you just installed that's pretty darn easy.
You'll want to override your configuration in Git so that you don't have to do this for every project.

Since big brother likes to watch our Internet traffic we don't want to require SSL verification to actually
throw a wrench into our Git operations. Normally this is not required because we can trust the validity of
the certificate. We can turn off SSL verification globally for all Git operations with one command:

    $ git config --global http.sslVerify false

Many of our Git HTTP operations happen externally. For this we need to use the development proxy that access
the Internet. If your machine was at any point bootstrapped that is likely going to reside in an environment
variable for safe keeping.

    $ echo $HTTP_PROXY
    http://proxy.com:80
    $ git config --global http.proxy $HTTP_PROXY

Our internal GitHub server sits behind the proxy into our corporate development network. Again if you've
ran bootstrap sometime in the last year or so you're going to have that as an environment variable as well.
The difference between this next bit is that we're effectively _globbing an entire URL space_ to use this
proxy. Everything else will use the original proxy that we set in the above command.

    $ echo $CFE_PROXY
    http://bproxy.com:80
    $ git config --global http.'https://github.dev.com/'.proxy $CFE_PROXY
