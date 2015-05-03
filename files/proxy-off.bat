
@echo off

:: unset the proxy on the host system
set HTTP_PROXY=
set HTTPS_PROXY=

:: unset reusing the host proxy in vagrant VMs
set VAGRANT_HTTP_PROXY=
set VAGRANT_HTTPS_PROXY=
set VAGRANT_NO_PROXY=

:: unset git proxy
cmd /C %GITDIR%\cmd\git config --global --unset http.proxy
cmd /C %GITDIR%\cmd\git config --global --unset https.proxy
